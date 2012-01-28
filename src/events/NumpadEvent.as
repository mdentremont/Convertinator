package events
{
	import flash.events.Event;
	
	public class NumpadEvent extends Event
	{
		private var _key:String;
		
		public function NumpadEvent(type:String, key:String) {
			super(type);
			_key = key;
		}
		
		/**
		 * Return the specific NumPad key which was pressed.
		 */
		public function get key():String {
			return _key;
		}
		
		public function set key(value:String):void {
			_key = value;
		}
	}
}