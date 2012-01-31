/* ***** BEGIN LICENSE BLOCK *****
 *
 * Copyright 2010-2012 Matt d'Entremont
 *
 * This file is part of Convertinator.
 *
 * Convertinator is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Convertinator is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with Convertinator.  If not, see <http://www.gnu.org/licenses/>.
 *
 * ***** END LICENSE BLOCK ***** */

package net
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	import mx.utils.StringUtil;
	
	import objects.Data;
	import objects.Unit;
	import objects.UnitData;
	
	import qnx.dialog.AlertDialog;
	import qnx.dialog.DialogSize;
	import qnx.display.IowWindow;
	
	public class CurrencyFetcher
	{
		public static const CURRENCY_RSS_URL:String = "http://themoneyconverter.com/USD/rss.xml";
		private static var _outgoingRequest:Boolean = false;
		
		/**
		 * Goes out to the web and fetches the currency data from the RSS feed
		 * at "themoneyconverter.com". If successful it will save the data in
		 * App storage and then populate the currency object for the user's
		 * viewing.
		 */
		public static function fetchCurrencyData():void {
			if (_outgoingRequest == false) {
				_outgoingRequest = true;
				
				var xmlData:HTTPService = new HTTPService();
				var call:Object;
				xmlData.url = CURRENCY_RSS_URL;
				xmlData.resultFormat = "e4x";
				
				xmlData.addEventListener(ResultEvent.RESULT, onHttpSuccess);
				xmlData.addEventListener(FaultEvent.FAULT, onHttpFault);
				
				xmlData.send();
			}
		}
		
		/**
		 * Called when the http request fails. Currently we do nothing but flip
		 * a boolean, however maybe we should display a dialog to the user.
		 * 
		 * For now we will not display a dialog as it is a rare case, and will
		 * just annoy the user. However we used to show a dialog if the 
		 * fetchCurrencyData call was the results of a user initiated action.
		 * (ie: Pressing the "Update Currency" button).
		 */ 
		private static function onHttpFault(event:FaultEvent):void {
			_outgoingRequest = false;
		}
		
		/**
		 * Sets the currency data object and enters the data into the App's
		 * shared object.
		 */
		private static function onHttpSuccess(event:ResultEvent):void {
			_outgoingRequest = false;
			
			var xml:XML = event.result as XML;
			trace(xml.toXMLString());
			
			var currencyData:ArrayCollection = new ArrayCollection();
			
			var baseUnit:String = xml.channel.title;
			baseUnit = StringUtil.trim(baseUnit.replace("Exchange Rates For ", ""));
			
			currencyData.addItem(new Unit(baseUnit, 1));
			for each(var item:XML in xml.channel.elements("item")) {
				var description:String = item.description;
				var obj:Array = description.split(" = ");
				description = obj[1];
				var rate:Number = Number(description.match(/\d+(.\d+)?/)[0]);
				var currency:String = StringUtil.trim(description.substr(description.indexOf(" ")));
				currencyData.addItem(new Unit(currency, rate));
			}
			
			var lastUpdate:Date = new Date();
			
			Data.appSettings.data.currencyData = currencyData;
			Data.appSettings.data.lastUpdate = lastUpdate.getTime();
			
			UnitData.currencyData = currencyData;
		}
		
		public static function setupCurrencyData():void {
			if (Data.currencyUpdateSpecified == false) {
				var title:String = "Fetch Updated Currency";
				var text:String = "This application has the ability to periodically retrieve updated currency data. Do you wish to allow this application to automatically fetch currency data on start-up?";
				
				// show the alert
				var alert:AlertDialog = new AlertDialog();
				
				alert.addButton("Yes");
				alert.addButton("No");
				alert.addEventListener(Event.SELECT, autoUpdateAlertHandler);
				alert.dialogSize = DialogSize.SIZE_SMALL;
				alert.message = text;
				alert.title = title;
				
				alert.show(IowWindow.getAirWindow().group);
			} else if (Data.currencyUpdateEnabled) {
				var lastUpdate:Number = Data.lastCurrencyUpdate;
				
				if (isNaN(lastUpdate)) {
					// Update if it isn't set
					CurrencyFetcher.fetchCurrencyData();
				} else {
					var today:Date = new Date();
					var elapsed:Number = today.getTime() - lastUpdate;
					
					/*
					* If more than CURRENCY_UPDATE_INTERVAL hours have elapsed since 
					* the last successful update, perform another.
					*/
					if ((elapsed / 1000 / 60 / 60) > Data.CURRENCY_UPDATE_INTERVAL) {
						CurrencyFetcher.fetchCurrencyData();
					}
				}
			}			
		}
		
		/**
		 * Handle the auto update dialog. The event's target will have a selected index
		 * of 0 for true or 1 for false.
		 */
		private static function autoUpdateAlertHandler(event:Event):void {
			if (event.target.selectedIndex == 0) {
				// User enabled currency updating, fetch updated currency
				Data.currencyUpdateEnabled = true;
				
				CurrencyFetcher.fetchCurrencyData();
			} else {
				// User disabled currency updating, do nothing
				Data.currencyUpdateEnabled = false;
			}
			
			Data.currencyUpdateSpecified = true;
		}
	}
}
