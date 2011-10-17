package objects
{
	[Bindable]
	public class Unit
	{
		private var _type:String;
		private var _value:Number;
		private var _convertedValue:Number;
		private var _formula:Function;
		
		public function Unit(type:String="", value:Number=1, formula:Function = null) {
			_type = type;
			_value = value;
			_convertedValue = convertedValue;
			_formula = formula;
		}
		
		public function toString():String {
			return type;
		}
		
		public function getConvertedValue(input:Number):Number {
			if (_formula != null) {
				var convNum:Number = _formula(input * _value);
				return convNum;
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

		public function get convertedValue():Number {
			return _convertedValue;
		}

		public function set convertedValue(value:Number):void {
			_convertedValue = value;
		}

		public function get formula():Function
		{
			return _formula;
		}

		public function set formula(value:Function):void
		{
			_formula = value;
		}

	}
}