<cfscript>
if(structKeyExists(FORM, "createConsumable")) {

	if(objValidator.setEmptyStringCondition(FORM.name) == false AND objValidator.setEmptyStringCondition(FORM.minimum_level) == false AND objValidator.setEmptyStringCondition(FORM.maximum_level) == false) {
		if(isValid("integer",FORM.minimum_level) AND isValid("integer",FORM.maximum_level)) {
			createConsumable = structNew();
			createConsumable.Name = FORM.name;
			createConsumable.MinimumLevel = FORM.minimum_level;
			createConsumable.MaximumLevel = FORM.maximum_level;
			createConsumable.Remarks = FORM.remarks;
			createConsumableRecord = objConsumables.createConsumable(createConsumable);
			if (createConsumableRecord == true) {
				Alert = objAlerts.setAlertMessage("Success","Consumable Created");
			}
			else {
				Alert = objAlerts.setAlertMessage("Error","Something unexpected happened. Please contact MIS about this issue.");
			}
		}
		else {
			Alert = objAlerts.setAlertMessage("Error","Quantity Levels are not Numbers");
		}
	}
	else {
		Alert = objAlerts.setAlertMessage("Error","Complete Missing Fields");
	}
}
if(structKeyExists(FORM, "updateConsumable")) {
	if(objValidator.setEmptyStringCondition(FORM.name) == false AND objValidator.setEmptyStringCondition(FORM.minimum_level) == false AND objValidator.setEmptyStringCondition(FORM.maximum_level) == false) {
		if(isValid("integer",FORM.minimum_level) AND isValid("integer",FORM.maximum_level)) {
			updateConsumable = structNew();
			updateConsumable.Name = FORM.name;
			updateConsumable.ID = FORM.id;
			updateConsumable.MinimumLevel = FORM.minimum_level;
			updateConsumable.MaximumLevel = FORM.maximum_level;
			updateConsumable.Remarks = FORM.remarks;
			updateConsumableRecord = objConsumables.updateConsumable(updateConsumable);
			if (updateConsumableRecord == true) {
				Alert = objAlerts.setAlertMessage("Success","Consumable "&updateConsumable.Name&" Updated");
			}
			else {
				Alert = objAlerts.setAlertMessage("Error","Something unexpected happened. Please contact MIS about this issue.");
			}
		}
		else {
			Alert = objAlerts.setAlertMessage("Error","Quantity Levels are not Numbers");
		}
	}
	else {
		Alert = objAlerts.setAlertMessage("Error","Complete Missing Fields");
	}
}
if(structKeyExists(FORM, "deleteConsumable")) {
	deleteConsumable = objConsumables.deleteConsumable(FORM.id);
	if(deleteConsumable == true) {
		Alert = objAlerts.setAlertMessage("Success","Consumable Deleted.");
	}
	else {
		Alert = objAlerts.setAlertMessage("Error","Failed to Delete Consumable.");
	}
}
if(structKeyExists(FORM, "createConsumableItem")) {
	if(objValidator.setEmptyStringCondition(FORM.description) == false AND objValidator.setEmptyStringCondition(FORM.action) == false AND objValidator.setEmptyStringCondition(FORM.quantity) == false AND objValidator.setEmptyStringCondition(FORM.date_recorded) == false ) {
		if(isValid("integer",FORM.quantity)) {
			if(isDate(FORM.date_recorded)) {
				createConsumableItem = structNew();
				createConsumableItem.fk_consumables_id = FORM.fk_consumables_id;
				createConsumableItem.description = FORM.description;
				createConsumableItem.action = FORM.action;
				createConsumableItem.quantity = FORM.quantity;
				createConsumableItem.date_recorded = FORM.date_recorded;
				createConsumableItem.remarks = FORM.remarks;
				updateConsumableRecord = objConsumables.createConsumableItem(createConsumableItem);
				if(updateConsumableRecord == true) {
					Alert = objAlerts.setAlertMessage("Success","Consumable Entry Created.");
				}
				else {
					Alert = objAlerts.setAlertMessage("Error","Something Went Wrong.");
				}
			}
			else {
				Alert = objAlerts.setAlertMessage("Error","Invalid Date.");
			}
		}
		else {
			Alert = objAlerts.setAlertMessage("Error","Quantity is not of Integer Type.");
		}
	}
	else {
		Alert = objAlerts.setAlertMessage("Error","Complete All Fields.");
	}
}
if(structKeyExists(FORM, "updateConsumableItem")) {
	if(objValidator.setEmptyStringCondition(FORM.description) == false AND objValidator.setEmptyStringCondition(FORM.action) == false AND objValidator.setEmptyStringCondition(FORM.quantity) == false AND objValidator.setEmptyStringCondition(FORM.date_recorded) == false ) {
		if(isValid("integer",FORM.quantity)) {
			if(isDate(FORM.date_recorded)) {
				updateconsumableItem = structNew();
				updateConsumableItem.id = FORM.id;
				updateConsumableItem.fk_consumables_id = FORM.fk_consumables_id;
				updateConsumableItem.description = FORM.description;
				updateConsumableItem.action = FORM.action;
				updateConsumableItem.quantity = FORM.quantity;
				updateConsumableItem.date_recorded = FORM.date_recorded;
				updateConsumableItem.remarks = FORM.remarks;
				updateConsumableRecord = objConsumables.updateConsumableItem(updateConsumableItem);
				if(updateConsumableRecord == true) {
					Alert = objAlerts.setAlertMessage("Success","Consumable Entry Updated.");
				}
				else {
					Alert = objAlerts.setAlertMessage("Error","Something Went Wrong.");
				}
			}
			else {
				Alert = objAlerts.setAlertMessage("Error","Invalid Date.");
			}
		}
		else {
			Alert = objAlerts.setAlertMessage("Error","Quantity is not of Integer Type.");
		}
	}
	else {
		Alert = objAlerts.setAlertMessage("Error","Complete All Fields.");
	}
}
if(structKeyExists(FORM, "deleteConsumableItem")) {
	deleteConsumableItem = objConsumables.deleteConsumableItem(FORM.id);
	if(deleteConsumableItem == true) {
		Alert = objAlerts.setAlertMessage("Success","Consumable Entry Deleted.");
	}
	else {
		Alert = objAlerts.setAlertMessage("Error","Failed to Delete Consumable Entry.");
	}
}
</cfscript>