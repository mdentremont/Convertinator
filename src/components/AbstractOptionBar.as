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
	import flash.display.GradientType;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	
	import mx.effects.Tween;
	
	import qnx.events.QNXApplicationEvent;
	import qnx.system.QNXApplication;
	import qnx.ui.core.Container;
	import qnx.ui.core.ContainerFlow;
	import qnx.ui.core.Containment;
	
	public class AbstractOptionBar extends Container
	{
		protected static const BUTTON_HEIGHT:int = 75;

		protected static const ANIMATION_DURATION:int = 250;
		
		protected static const MENU_BAR_HEIGHT:int = 100;
		protected static const OVERLAY_HEIGHT:int = 500;
		
		protected static const SCREEN_HEIGHT:int = 600;
		protected static const SCREEN_WIDTH:int = 1024;
		
		protected var _displayed:Boolean;
		
		// Put the buttons on the bar and the rest of the screen is the overlay
		protected var _menuBar:Container;
		
		protected var _onClose:Function;
		protected var _overlay:Container;

		public function AbstractOptionBar() {
			super();
			
			_displayed = false;
			
			setSize(SCREEN_WIDTH, SCREEN_HEIGHT);
			
			_menuBar = new Container();
			_menuBar.containment = Containment.UNCONTAINED;
			_menuBar.flow = ContainerFlow.HORIZONTAL;
			_menuBar.opaqueBackground = 0x000000;
			
			_overlay = new Container();
			_overlay.setSize(SCREEN_WIDTH, OVERLAY_HEIGHT);
			_overlay.setPosition(0, MENU_BAR_HEIGHT);
			
			addChild(_menuBar);
			addChild(_overlay);
		}
		
		/**
		 * Slide-out the menu bar.
		 */
		public function closeMenu():void {
			new Tween(this, 0, -MENU_BAR_HEIGHT, ANIMATION_DURATION, -1,
				function onTweenUpdate(value:Object):void {
					_menuBar.y = value as Number;
				},
				function onTweenFinished(value:Object):void {
					removeFromStage();
					
				}
			);
		}
		
		public function get displayed():Boolean {
			return _displayed;
		}
		
		/**
		 * Draw the background with a gradient to give the "pop-out" appearance.
		 * We also draw an invisible overlay underneath the option bar to capture
		 * touch events.
		 */
		protected function drawMenuBarBackground():void {
			var colours:Array = [0x808080, 0x202020];
			var alphas:Array = [1, 1];
			var ratios:Array = [0, 255];
			
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(SCREEN_WIDTH, MENU_BAR_HEIGHT, Math.PI / 2, 0, 0);
			
			_menuBar.graphics.clear();
			_menuBar.graphics.beginGradientFill(GradientType.LINEAR, colours, alphas, ratios, matrix);
			_menuBar.graphics.drawRect(0, 0, SCREEN_WIDTH, MENU_BAR_HEIGHT);
			_menuBar.graphics.endFill();
		}
		
		protected function drawOverlay():void {
			_overlay.graphics.clear();
			_overlay.graphics.beginFill(0x000000, 0);
			_overlay.graphics.drawRect(0, 0, SCREEN_WIDTH, OVERLAY_HEIGHT);
			_overlay.graphics.endFill();
		}
		
		override protected function onAdded():void {
			_menuBar.setSize(SCREEN_WIDTH, MENU_BAR_HEIGHT);
			_menuBar.setPosition(0, -MENU_BAR_HEIGHT);

			drawMenuBarBackground();
			drawOverlay();

			new Tween(this, -MENU_BAR_HEIGHT, 0, ANIMATION_DURATION, -1,
				function onTweenUpdate(value:Object):void {
					_menuBar.y = value as Number;
				},
				function onTweenFinished(value:Object):void {
					_menuBar.y = value as Number;
					
					_overlay.addEventListener(MouseEvent.CLICK, onOverlayClick);
				}
			);
		}
		
		/**
		 * When the overlay is clicked we hide the menu.
		 */
		protected function onOverlayClick(event:MouseEvent):void {
			// Close menu
			closeMenu();
		}
		
		protected function removeFromStage():void {
			if (parent != null) {
				parent.removeChild(this);
			}
			
			_displayed = false;
		}
		
		/**
		 * Slide-in the menu bar.
		 */
		public function showMenu(stage:Stage):void {
			_displayed = true;

			stage.addChild(this);
		}
	}
}