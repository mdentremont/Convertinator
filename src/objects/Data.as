package objects
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
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
		public static var httpFaultOpen:Boolean = false;
		
		public static function getCurrencyData():void {
			var settings:SharedObject = SharedObject.getLocal(Convertinator.APP_NAME);
			
			if (settings.data.currencyData != null) {
				var tmpCurrencyData:ArrayCollection = settings.data.currencyData;
				currencyData = new ArrayCollection();
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
				
				currencyData = new ArrayCollection();
				
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
			_categories["Currency"] = currencyData;
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
			currencyData = new ArrayCollection();
			
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
			return _categories;
		}
		
		private static const lengthData:ArrayCollection = new ArrayCollection([
			new Unit("Kilometer", .001),
			new Unit("Hectometer", .01),
			new Unit("Dekameter", .1),
			new Unit("Meter", 1),
			new Unit("Decimeter", 10),
			new Unit("Centimeter", 100),
			new Unit("Millimeter", 1000),
			new Unit("Micrometer", 1000000),
			new Unit("Foot", 3.280839895),
			new Unit("Inch", 39.37007874),
			new Unit("Mile", .000621371),
			new Unit("Nautical Mile", 0.000539957),
			new Unit("Yard", 1.093613298),
			new Unit("Fathom", .546806649),
			new Unit("Arpent", .017087708),
			new Unit("Pica", 236.220472441),
			new Unit("Hand", 9.82519685),
			new Unit("Caliber", 3937.007874016),
			new Unit("Smoot", 0.587613116),
			new Unit("Furlong", 0.00497096954)
		]);
		
		private static const weightData:ArrayCollection = new ArrayCollection([
			new Unit("Kilogram", 1),
			new Unit("Hectogram", 10),
			new Unit("Dekagram", 100),
			new Unit("Gram", 1000),
			new Unit("Decigram", 10000),
			new Unit("Centigram", 100000),
			new Unit("Milligram", 1000000),
			new Unit("Quintal", .01),
			new Unit("Ton (metric)", .001),
			new Unit("Ton (US)", .001102311),
			new Unit("Ton (UK)", .000984207),
			new Unit("Pound", 2.204622622),
			new Unit("Ounce", 35.27396195),
			new Unit("Quarter (US)", .088184905),
			new Unit("Quarter (UK)", .078736522),
			new Unit("Stone (US)", .17636981),
			new Unit("Stone (UK)", .157473044),
			new Unit("Grain", 15432.3583529),
			new Unit("Bag of Sugar", 2),
			new Unit("Bag of Cement", .02),
			new Unit("Elephant", 0.0001666666),
		]);
		
		private static const areaData:ArrayCollection = new ArrayCollection([
			new Unit("Square Kilometer", .000001),
			new Unit("Square Hectometer", .0001),
			new Unit("Square Dekameter", .01),
			new Unit("Square Meter", 1),
			new Unit("Square Decimeter", 100),
			new Unit("Square Centimeter", 10000),
			new Unit("Square Millimeter", 1000000),
			new Unit("Square Mile", Math.pow(13.86102159, -7)),
			new Unit("Square Yard", 1.19599005),
			new Unit("Square Foot", 10.7639104),
			new Unit("Square Inch", 1550.0031),
			new Unit("Acre", 0.000247105381),
			new Unit("Hectare", .0001),
			new Unit("Barn", Math.pow(10, 28)),
		]);
		
		private static const volumeData:ArrayCollection = new ArrayCollection([
			new Unit("Cubic Kilometer", .000000001),
			new Unit("Cubic Hectometer", .000001),
			new Unit("Cubic Dekameter", .001),
			new Unit("Cubic Meter", 1),
			new Unit("Cubic Decimeter", 1000),
			new Unit("Cubic Centimeter", 1000000),
			new Unit("Cubic Millimeter", 1000000000),
			new Unit("Cubic Mile", Math.pow(12.39912759, -10)),
			new Unit("Cubic Yard", 1.30795062),
			new Unit("Cubic Foot", 35.3146667),
			new Unit("Cubic Inch", 61023.7441),
			new Unit("Megalitre", .001),
			new Unit("Kiloliter", 1),
			new Unit("Dekalitre", 100),
			new Unit("Litre", 1000),
			new Unit("Decilitre", 10000),
			new Unit("Centilitre", 100000),
			new Unit("Milliliter", 1000000),
			new Unit("Fluid Ounce (US)", 33814.0227),
			new Unit("Fluid Ounce (UK)", 35195.0652),
			new Unit("Gallon (US)", 264.172052),
			new Unit("Gallon (UK)", 219.969157),
			new Unit("Barrel (US)", 8.38641436055),
			new Unit("Barrel (Oil)", 6.28981077),
			new Unit("Barrel (UK)", 6.11246944),
			new Unit("Quart (US)", 1056.68821),
			new Unit("Quart (UK)", 879.87663),
			new Unit("Pint (US)", 2113.37642),
			new Unit("Pint (UK)", 1759.75326),
			new Unit("Gill (US)", 8453.505),
			new Unit("Gill (UK)", 7039.01304),
		]);
		
		private static var currencyData:ArrayCollection = new ArrayCollection([
			new Unit("Loading Data", 0)
		]);
		
		private static const temperatureData:ArrayCollection = new ArrayCollection([
			new Unit("Celsius", 1),
			new Unit("Delisle Scale", 1, function(input:Number, inverse:Boolean = false):Number {
				var val:Number = Unit(this).value;
				if (inverse) {
					return 100 - (input * (2/3));
				}
				return (100 - input) * (3/2)
				}),
				new Unit("Fahrenheit", 1, function(input:Number, inverse:Boolean = false):Number {
					var val:Number = Unit(this).value;
					if (inverse) {
						return (5/9)*(input - 32);
					}
					return (9/5)*(input) + 32;
				}),
				new Unit("Kelvin", 1, function(input:Number, inverse:Boolean = false):Number {
					var val:Number = Unit(this).value;
					if (inverse) {
						return input - 273.15;
					}
					return input + 273.15;
				}),
				new Unit("Newton Scale", 1, function(input:Number, inverse:Boolean = false):Number {
					var val:Number = Unit(this).value;
					if (inverse) {
						return input * (100/33);
					}
					return input * (33/100);
				}),
				new Unit("Rankine", 1, function(input:Number, inverse:Boolean = false):Number {
					var val:Number = Unit(this).value;
					if (inverse) {
						return (input - 491.67) * (5/9);
					}
					return (input + 273.15) * (9/5);
				}),
				new Unit("Réaumur Scale", 1, function(input:Number, inverse:Boolean = false):Number {
					var val:Number = Unit(this).value;
					if (inverse) {
						return input * (5/4);
					}
					return input * (4/5);
				}),
				new Unit("Rømer Scale", 1, function(input:Number, inverse:Boolean = false):Number {
					var val:Number = Unit(this).value;
					if (inverse) {
						return (input - 7.5) * (40/21)
					}
					return (input * (21/40)) + 7.5;
				}),
		]);
		
		private static const timeData:ArrayCollection = new ArrayCollection([
			new Unit("Millenium", .0000000000316887646),
			new Unit("Century", .000000000316887646),
			new Unit("Decade", .00000000316887646),
			new Unit("Year", .0000000316887646),
			new Unit("Month", .000000380265176),
			new Unit("Week", .000001653439153),
			new Unit("Day", .0000115740741),
			new Unit("Hour", .000277777777777777),
			new Unit("Minute", .0166666666666666),
			new Unit("Second", 1),
			new Unit("Millisecond", 1000),
			new Unit("Microsecond", 1000000),
			new Unit("Nanosecond", 1000000000),
			new Unit("Picosecond", 1000000000000),
			new Unit("Femtosecond", 1000000000000000),
			new Unit("Attosecond", 1000000000000000000),
			new Unit("Dog Year", 0.0000002218213522),
			new Unit("Fortnight", .000000826719577),
			new Unit("Jiffy", .01),
			new Unit("Shake", 100000000),
			new Unit("Microfortnight", 1.2096),
		]);
		
		private static const speedData:ArrayCollection = new ArrayCollection([
			new Unit("Kilometer/Second", .001),
			new Unit("Kilometer/Minute", .06),
			new Unit("Kilometer/Hour", 3.6),
			new Unit("Meter/Second", 1),
			new Unit("Meter/Minute", 60),
			new Unit("Meter/Hour", 3600),
			new Unit("Inch/Second", 39.37007874),
			new Unit("Inch/Minute", 2362.204724409),
			new Unit("Inch/Hour", 141732.283464),
			new Unit("Foot/Second", 3.280839895),
			new Unit("Foot/Minute", 196.850393701),
			new Unit("Foot/Hour", 11811.02362204),
			new Unit("Yard/Second", 1.093613298),
			new Unit("Yard/Minute", 65.6167979),
			new Unit("Yard/Hour", 3937.007874016),
			new Unit("Mile/Second", .000621371),
			new Unit("Mile/Minute", .037282272),
			new Unit("Mile/Hour", 2.236936292),
			new Unit("Nautical Miles/Hour (Knot)", 1.943844492),
			new Unit("Furlong/Fortnight", 0.000166309524),
		]);
		
		private static const cookingData:ArrayCollection = new ArrayCollection([
			new Unit("Cup (Metric)", 1),
			new Unit("Cup(US)", 1.0566882),
			new Unit("Dash", 405.7682707),
			new Unit("Demi", 1),
			new Unit("Dessertspoon", 25),
			new Unit("Drop", 4869.219248475),
			new Unit("Gallon (US)", .066043012),
			new Unit("Gallon (UK)", .054992312),
			new Unit("Liter", .25),
			new Unit("Milliliter", 250),
			new Unit("Ounce (US)", 8.45350565),
			new Unit("Ounce (UK)", 8.798769925),
			new Unit("Pinch", 811.536541425),
			new Unit("Pint (US)", .5283441),
			new Unit("Pint (UK)", .439938496),
			new Unit("Quart (US)", .26417205),
			new Unit("Quart (UK)", .21996925),
			new Unit("Tablespoon (US)", 16.90701125),
			new Unit("Tablespoon (UK)", 17.597539875),
			new Unit("Tablespoon (Metric)", 16.6665),
			new Unit("Teaspoon (US)", 50.721035),
			new Unit("Teaspoon (UK)", 70.3901592),
			new Unit("Teaspoon (Metric)", 50),
			new Unit("Teacup", 1.319855),
			new Unit("Shot", 8.453505676),
		]);
		
		private static const pressureData:ArrayCollection = new ArrayCollection([
			new Unit("PSI", 1),
			new Unit("KSI", 0.001),
			new Unit("Pascal", 6894.757293178),
			new Unit("Kilopasccal", 6.894757293), 
			new Unit("Newton/Square Centimeter", 0.689475729),
			new Unit("Newton/Square Millimeter", 0.006894757),
			new Unit("Bar", 0.068947573),
			new Unit("Millibar", 68.947572932),
			new Unit("Torr", 51.714932572),
			new Unit("Standard Atmosphere", 0.068045964),
			new Unit("Technical Atmosphere", 0.070306958),
		]);
		
		private static var _categories:Object = new Object();
		_categories["Weight"] = weightData;
		_categories["Volume"] = volumeData;
		_categories["Currency"] = currencyData;
		_categories["Temperature"] = temperatureData;
		_categories["Time"] = timeData;
		_categories["Speed"] = speedData;
		_categories["Area"] = areaData;
		_categories["Cooking"] = cookingData;
		_categories["Length"] = lengthData;
		_categories["Pressure"] = pressureData;
	}
}