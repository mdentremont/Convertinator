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