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
	import flash.net.SharedObject;
	
	import mx.collections.ArrayCollection;
	import mx.utils.StringUtil;
	
	public class Data
	{
		private static const APP_NAME:String = "Convertinator";
		public static const CURRENCY_UPDATE_INTERVAL:int = 12;
		
		private static var _appSettings:SharedObject = SharedObject.getLocal(APP_NAME);
		private static var _categories:Object;

		public static function get appSettings():SharedObject {
			return _appSettings;
		}
		
		/**
		 * Returns the currency data. 
		 * 
		 * If auto-updating is enabled and the data been previously been
		 * fetched, this data will be stored in the App's
		 * shared object storage.
		 * 
		 * Otherwise we can pull pre-packaged currency data from the included
		 * XML file.
		 */
		public static function get currencyData():ArrayCollection {
			var currencyData:ArrayCollection = new ArrayCollection();
			if (_appSettings.data.currencyData != null) {
				var tmpCurrencyData:ArrayCollection = _appSettings.data.currencyData;

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
		
		public static function get currencyUpdateEnabled():Boolean {
			return _appSettings.data.currencyUpdateEnabled;
		}
		
		public static function set currencyUpdateEnabled(value:Boolean):void {
			_appSettings.data.currencyUpdateEnabled = value;
		}
		
		public static function get currencyUpdateSpecified():Boolean {
			return _appSettings.data.currencyUpdateSpecified;
		}
		
		public static function set currencyUpdateSpecified(value:Boolean):void {
			_appSettings.data.currencyUpdateSpecified = value;
		}
		
		public static function get lastCurrencyUpdate():Number {
			return _appSettings.data.lastCurrencyUpdate;
		}
	}
}

