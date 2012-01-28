import flash.events.Event;
import flash.net.SharedObject;

import mx.formatters.NumberFormatter;

import objects.Data;
import objects.Unit;

import qnx.dialog.AlertDialog;
import qnx.dialog.DialogSize;
import qnx.display.IowWindow;
import qnx.events.QNXApplicationEvent;
import qnx.system.QNXApplication;

import spark.components.gridClasses.GridColumn;
import spark.events.IndexChangeEvent;


public static var APP_NAME:String = "Convertinator";
private var swiping:Boolean;
private var settings:SharedObject = SharedObject.getLocal(APP_NAME);
[Bindable]
public var autoUpdateEnabled:Boolean;
[Bindable]
public var autoUpdateIntervalIndex:int;

private function initializeApp():void {
	// Associate the bezel gesture to the options screen 
	QNXApplication.qnxApplication.addEventListener(QNXApplicationEvent.SWIPE_DOWN, showOptionsScreen);
	
	autoUpdateEnabled = settings.data.autoUpdateEnabled;
	autoUpdateIntervalIndex = settings.data.autoUpdateIntervalIndex;
	
	var	autoUpdateSpecified:Boolean = settings.data.autoUpdateSpecified;
	if (autoUpdateSpecified == false) {
		var title:String = "Fetch Updated Currency";
		var text:String = "This application has the ability to periodically retrieve updated currency data. Do you wish to allow this application to automaticaly fetch currency data on startup?";

		// show the alert
		var alert:AlertDialog = new AlertDialog();
		alert.title = title;
		alert.message = text;
		alert.addButton("Yes");
		alert.addButton("No");
		alert.dialogSize = DialogSize.SIZE_SMALL;
		alert.addEventListener(Event.SELECT, autoUpdateAlertHandler);
		alert.show(IowWindow.getAirWindow().group);
	} else if (autoUpdateEnabled) {
		var lastUpdate:Number = settings.data.lastUpdate;
		if (isNaN(lastUpdate)) {
			Data.fetchCurrencyData(false);
		} else {
			var today:Date = new Date();
			var elapsed:Number = today.getTime() - lastUpdate;
			
			// If more than 12 hours have elapsed since the last successful update, perform another
			if ((elapsed / 1000 / 60 / 60) > 12) {
				Data.fetchCurrencyData(false);
			}
		}
	}
	Data.getCurrencyData();
	
	numPad.units = unitBar.data;
	unitBarClickHandler(new IndexChangeEvent(""));
	updateConversions(null);
}

private function autoUpdateAlertHandler(event:Event):void {
	var settings:SharedObject = SharedObject.getLocal(APP_NAME);
	
	if (event.target.selectedIndex == 0) {
		settings.data.autoUpdateSpecified = true;
		autoUpdateEnabled = true;
		settings.data.autoUpdateEnabled = autoUpdateEnabled;
		autoUpdateIntervalIndex = 0;
		settings.data.autoUpdateIntervalIndex = autoUpdateIntervalIndex;
		Data.fetchCurrencyData(true);
	} else {
		settings.data.autoUpdateSpecified = true;
		autoUpdateEnabled = false;
		settings.data.autoUpdateEnabled = autoUpdateEnabled;
		autoUpdateIntervalIndex = 0;
		settings.data.autoUpdateIntervalIndex = autoUpdateIntervalIndex;
	}
}

private function autoUpdateCheckboxChangeHandler(event:Event):void {
	autoUpdateEnabled = !autoUpdateEnabled;
	settings.data.autoUpdateEnabled = autoUpdateEnabled;
}

private function autoUpdateIntervalChangeHandler(event:IndexChangeEvent):void {
	autoUpdateIntervalIndex = event.newIndex;
	settings.data.autoUpdateIntervalIndex = autoUpdateIntervalIndex;
}

private function updateConversions(event:Event):void {
	var userInput:Number = 0;
	if (numPad.textBoxText != "" && numPad.textBoxText != "-") {
		userInput = Number(numPad.textBoxText);
	}
	unitBar.data.disableAutoUpdate();
	
	var selectedUnit:Unit = unitBar.data.getItemAt(numPad.selectedIndex) as Unit;
	if (selectedUnit.formula != null) {
		userInput = selectedUnit.formula(userInput, true);
	} else {
		userInput /= selectedUnit.value;
	}
	for each (var unit:Unit in unitBar.data.source) {
		unit.convertedValue = unit.getConvertedValue(userInput);
	}
	
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
	panel.visible = true;
}
