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

import components.AbstractOptionBar;
import components.DefaultOptionBar;

import flash.events.Event;

import mx.formatters.NumberFormatter;

import net.CurrencyFetcher;

import objects.Unit;

import qnx.events.QNXApplicationEvent;
import qnx.system.QNXApplication;

import spark.components.gridClasses.GridColumn;
import spark.events.IndexChangeEvent;

private var _optionBar:AbstractOptionBar;

private function initializeApp():void {
	// Associate the bezel gesture to the options screen 
	QNXApplication.qnxApplication.addEventListener(QNXApplicationEvent.SWIPE_DOWN, showOptionsScreen);
	
	_optionBar = new DefaultOptionBar();
	
	CurrencyFetcher.setupCurrencyData();
	
	numPad.units = unitBar.data;
	unitBarClickHandler(new IndexChangeEvent(""));
	updateConversions(null);
}

private function updateConversions(event:Event):void {
	var userInput:Number = 0;
	
	// Assure the input is valid
	if (numPad.textBoxText != "" && numPad.textBoxText != "-") {
		userInput = Number(numPad.textBoxText);
	}
	
	// Disable the unitBar while we change the data
	unitBar.data.disableAutoUpdate();
	
	var selectedUnit:Unit = unitBar.data.getItemAt(numPad.selectedIndex) as Unit;

	/*
	 * This converts the user input into it's value in comparison to that unit
	 * type's base value (each unit's value is in relation to that unit type's
	 * "index" unit). 
	 *
	 * By multiplying all units by the user's "real" input (for you economists
	 * out there :)), their value will now be based off the selected unit.
	 *
	 * This is much too complicated for me to manage typing out, can anyone
	 * else think of a better way to describe it?
	 */
	var indexedSelectedUnit:Number = userInput;
	if (selectedUnit.formula != null) {
		// Conversion for this unit is determined using a formula
		indexedSelectedUnit = selectedUnit.formula(userInput, true);
	} else {
		indexedSelectedUnit /= selectedUnit.value;
	}
	
	for each (var unit:Unit in unitBar.data.source) {
		unit.convertedValue = unit.getConvertedValue(indexedSelectedUnit);
	}
	
	// Disable the unitBar while we change the data
	unitBar.data.enableAutoUpdate();
}

private function unitBarClickHandler(event:IndexChangeEvent):void {
	dataGrid.selectedIndex = 0;
	dataGrid.validateNow();
	numPad.selectedIndex = 0;
	numPad.selectedType.label = (numPad.units[numPad.selectedIndex] as Unit).type;
	updateConversions(event);
}

private function convertedLabelFunction(item:Object, column:GridColumn):String {
	var value:String = item[column.dataField];
	if (value.indexOf('e') >= 0) {
		return value;
	} else {
		var formatter:NumberFormatter = new NumberFormatter();
		formatter.precision = 4;
		return formatter.format(value);
	}
}

private function showOptionsScreen(event:Event):void {
	if (_optionBar.displayed == false) {
		_optionBar.showMenu(this.stage);
	} else {
		_optionBar.closeMenu();
	}
}
