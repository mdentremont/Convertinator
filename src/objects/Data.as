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

package objects
{
	import flash.events.Event;
	import flash.net.SharedObject;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	import mx.utils.StringUtil;
	
	import qnx.dialog.AlertDialog;
	import qnx.display.IowWindow;
	
	public class Data
	{
		private static var _categories:Object;

		public static function getCurrencyData():ArrayCollection {
			var settings:SharedObject = SharedObject.getLocal(Convertinator.APP_NAME);
			
			var currencyData:ArrayCollection = new ArrayCollection();
			if (settings.data.currencyData != null) {
				var tmpCurrencyData:ArrayCollection = settings.data.currencyData;

				for (var i:int = 0; i < tmpCurrencyData.length; i++) {
					var type:String = tmpCurrencyData[i].type;
					var value:Number = tmpCurrencyData[i].value;
					var formula:Function = tmpCurrencyData[i].formula;
					var tUnit:Unit = new Unit(type, value, formula);
					currencyData.addItem(tUnit);
				}
			} else {
				[Embed(source="currency.dat", mimeType="text/xml")]
				var xmlData:Class;
				var xml:XML = xmlData.data as XML;
				
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
			}
			
			return currencyData;
		}
		
		/**
		 * Only show the dialog if the update was user initiated
		 */
		public static function fetchCurrencyData():void {
			var xmlData:HTTPService = new HTTPService();
			var call:Object;
			xmlData.url = "http://themoneyconverter.com/USD/rss.xml";
			xmlData.resultFormat = "e4x";
			
			xmlData.addEventListener("result", httpSuccess);
			
			xmlData.send();
		}
		
		private static function httpSuccess(event:ResultEvent):void {
			var xml:XML = event.result as XML;
			
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
			
			var settings:SharedObject = SharedObject.getLocal(Convertinator.APP_NAME);
			var lastUpdate:Date = new Date();
			settings.data.lastUpdate = lastUpdate.getTime();
			settings.data.currencyData = currencyData;
			
			UnitData.currencyData = currencyData;
			
			getCurrencyData();
		}
	}
}