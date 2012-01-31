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

package components
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import net.CurrencyFetcher;
	
	import objects.Data;
	
	import qnx.dialog.AlertDialog;
	import qnx.dialog.DialogSize;
	import qnx.display.IowWindow;
	import qnx.ui.buttons.LabelButton;
	import qnx.ui.buttons.ToggleSwitch;
	import qnx.ui.core.Container;
	import qnx.ui.core.ContainerFlow;
	import qnx.ui.core.Containment;
	import qnx.ui.core.SizeUnit;
	import qnx.ui.text.Label;
	
	/**
	 * The option bar shown (currently) throughout the app.
	 * 
	 * Currently no plans for any new option bars.
	 */
	public class DefaultOptionBar extends AbstractOptionBar
	{
		// Stupid hacks :(
		private static const BUTTON_LABEL_PADDING:int = 30;
		private static const LABEL_PADDING:int = 5;
		private static const TOGGLE_SWITCH_MARGIN:int = 12;
		
		protected var _aboutButton:LabelButton;
		protected var _currencyUpdateEnabledSwitch:ToggleSwitch;
		protected var _updateCurrencyNowButton:LabelButton;
		
		public function DefaultOptionBar()
		{
			super();
			
			initComponents();
		}
		
		private function initComponents():void {
			_menuBar.debugColor = 0x00FF00;
			
			_aboutButton = new LabelButton();
			_aboutButton.addEventListener(MouseEvent.CLICK, onAboutButtonClick);
			_aboutButton.containment = Containment.DOCK_RIGHT
			_aboutButton.height = BUTTON_HEIGHT;
			_aboutButton.label = "About";
			_aboutButton.size = _aboutButton.label_txt.width;
			_menuBar.addChild(_aboutButton);
			
			var toggleContainer:Container = new Container();
			
			var label:Label = new Label();
			label.containment = Containment.DOCK_TOP;
			label.text = "Update Currency?";
			label.width = label.textWidth + LABEL_PADDING;

			toggleContainer.addChild(label);
			
			_currencyUpdateEnabledSwitch = new ToggleSwitch();
			_currencyUpdateEnabledSwitch.addEventListener(
				Event.SELECT,
				onCurrencyEnabledToggle
			);
			_currencyUpdateEnabledSwitch.containment = Containment.DOCK_BOTTOM;
			_currencyUpdateEnabledSwitch.selected = Data.currencyUpdateEnabled;
			toggleContainer.addChild(_currencyUpdateEnabledSwitch);
			
			/*
			 * Determine the needed margins to align the components with the 
			 * other buttons.
			 */
			var verticalMargins:int = (_menuBar.size - BUTTON_HEIGHT) / 2;
			
			toggleContainer.containment = Containment.DOCK_RIGHT;
			toggleContainer.flow = ContainerFlow.VERTICAL;
			toggleContainer.margins = Vector.<Number>([
				TOGGLE_SWITCH_MARGIN,
				verticalMargins,
				TOGGLE_SWITCH_MARGIN,
				verticalMargins
			]);
			toggleContainer.size = Math.max(label.width, _currencyUpdateEnabledSwitch.width);
			toggleContainer.sizeUnit = SizeUnit.PIXELS;
			
			_menuBar.addChild(toggleContainer);
			
			_updateCurrencyNowButton = new LabelButton();
			_updateCurrencyNowButton.addEventListener(MouseEvent.CLICK, onUpdateNowClick);
			_updateCurrencyNowButton.containment = Containment.DOCK_RIGHT;
			_updateCurrencyNowButton.height = BUTTON_HEIGHT;
			_updateCurrencyNowButton.label = "Update Currency Now";
			_updateCurrencyNowButton.size = _updateCurrencyNowButton.label_txt.width + BUTTON_LABEL_PADDING;
			
			_menuBar.addChild(_updateCurrencyNowButton);
		}
		
		protected function onAboutButtonClick(event:MouseEvent):void {
			closeMenu();
			
			[Embed(source="about.txt",mimeType="application/octet-stream")]
			var aboutTextByteArray:Class;
			
			var aboutText:String = ( new aboutTextByteArray() as ByteArray).toString();

			// Show the "About" dialog
			var aboutDialog:AlertDialog = new AlertDialog();
			aboutDialog.addButton("OK");
			aboutDialog.dialogSize = DialogSize.SIZE_MEDIUM;
			aboutDialog.message = aboutText;
			aboutDialog.hideOnButtonClick = true;
			aboutDialog.title = "About";
			
			aboutDialog.show(IowWindow.getAirWindow().group);
		}

		protected function onCurrencyEnabledToggle(event:Event):void {
			Data.currencyUpdateEnabled = _currencyUpdateEnabledSwitch.selected;
			
			closeMenu();
		}
		
		protected function onUpdateNowClick(event:MouseEvent):void {
			CurrencyFetcher.fetchCurrencyData();
			
			closeMenu();
		}
	}
}