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

		public static var httpFaultOpen:Boolean = false;
		
		public static function getCurrencyData():void {
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
			_categories["Currency"] = UnitData.currencyData;
			UnitData.currencyData = currencyData;
		}
		
		/**
		 * Only show the dialog if the update was user initiated
		 */
		public static function fetchCurrencyData(userInitiated:Boolean):void {
			var xmlData:HTTPService = new HTTPService();
			var call:Object;
			xmlData.url = "http://themoneyconverter.com/USD/rss.xml";
			xmlData.resultFormat = "e4x";
			
			xmlData.addEventListener("result", httpSuccess);
			
			if (userInitiated) {
				xmlData.addEventListener("fault", httpFault);
			}
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
		
		private static function httpFault(event:FaultEvent):void {
			if (!httpFaultOpen) {
				var alert:AlertDialog = new AlertDialog();
				alert.title = "Error Retrieving Currency Data";
				alert.message = "Sorry, there was an error retrieving the currency data. Please try again later";
				alert.addButton("OK");
				alert.addEventListener(Event.SELECT, function(event:Event):void {
					httpFaultOpen = false;
				});
				alert.show(IowWindow.getAirWindow().group);
				httpFaultOpen = true;
			}
		}
		
		public static function getKeys():ArrayCollection {
			var text:ArrayCollection = new ArrayCollection();
			for (var string:String in categories) {
				text.addItem(string);
			}
			return text;
		}
		
		public static function get categories():Object {
			if (_categories == null) {
				_categories = new Object();
				_categories["Weight"] = UnitData.weightData;
				_categories["Volume"] = UnitData.volumeData;
				_categories["Currency"] = UnitData.currencyData;
				_categories["Temperature"] = UnitData.temperatureData;
				_categories["Time"] = UnitData.timeData;
				_categories["Speed"] = UnitData.speedData;
				_categories["Area"] = UnitData.areaData;
				_categories["Cooking"] = UnitData.cookingData;
				_categories["Length"] = UnitData.lengthData;
				_categories["Pressure"] = UnitData.pressureData;
			}
			return _categories;
		}
	}
}