package objects
{
	/**
	 * Units are used to make all the conversions. Each unit is defined
	 * in relation to the base unit.
	 * 
	 * Ex: If meter is the base unit, its value will be 1, and everything else
	 * will be determined as a factor of one. This means that the kilometer's
	 * value will be .001, since 1 meter is .001 kilometers.
	 * 
	 * All unit categories use this method except for temperatures, which are
	 * calculated using a formula.
	 */
	[Bindable]
	public class Unit
	{
		private var _type:String;
		private var _value:Number;
		private var _convertedValue:Number;
		private var _formula:Function;
		
		public function Unit(type:String="", value:Number=1, formula:Function = null) {
			_convertedValue = convertedValue;
			_formula = formula;
			_type = type;
			_value = value;
		}

		public function get convertedValue():Number {
			return _convertedValue;
		}

		public function set convertedValue(value:Number):void {
			_convertedValue = value;
		}

		public function get formula():Function {
			return _formula;
		}

		public function set formula(value:Function):void {
			_formula = value;
		}		

		public function getConvertedValue(input:Number):Number {
			if (_formula != null) {
				var convertedNumber:Number = _formula(input * _value);
				return convertedNumber;
			}
			return (input * _value);
		}
		
		public function get type():String {
			return _type;
		}
		
		public function set type(value:String):void {
			_type = value;
		}	
		public function get value():Number {
			return _value;
		}
		
		public function set value(value:Number):void {
			_value = value;
		}
	}
}