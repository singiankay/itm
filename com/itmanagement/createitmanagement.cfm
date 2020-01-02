<cfscript>
if(structKeyExists(FORM, "AssetType")) {
	if(FORM.AssetType == "Computer") {

		if(objITManagementValidator.validateComputer(FORM.IPAddress, FORM.DateIssued, FORM.DateDestroyed, FORM.DateStocked) == true) {
			
			submitComputerRecords = structNew();

			submitComputerRecords.AssetID = FORM.AssetID;
			submitComputerRecords.AssetType = FORM.AssetType;
			submitComputerRecords.ComputerType = FORM.ComputerType;
			submitComputerRecords.ComputerName = FORM.ComputerName;
			submitComputerRecords.IPAddress = FORM.IPAddress;
			submitComputerRecords.ProcessorType = FORM.ComputerProcessor;
			submitComputerRecords.MemoryType =  FORM.Memory;
			submitComputerRecords.OperatingSystem = FORM.OperatingSystem;
			submitComputerRecords.Office = FORM.Office;
			submitComputerRecords.GraphicsCard = FORM.GraphicsCard;
			submitComputerRecords.DateIssued = objValidator.setEmptyStringOrDate(FORM.DateIssued);
			submitComputerRecords.DateDestroyed = objValidator.setEmptyStringOrDate(FORM.DateDestroyed);
			submitComputerRecords.DateStocked = objValidator.setEmptyStringOrDate(FORM.DateStocked);
			submitComputerRecords.Remarks = FORM.Remarks;
			submitComputerRecords.Attachment = "";
			isContinueAfterAttachment = false;

			if(FORM.Attachment != "") {
				uploadAttachment = objITManagement.uploadAttachment("Attachment",FORM.AssetType);
				submitComputerRecords.Attachment = objITManagement.getFilename(uploadAttachment);
				isContinueAfterAttachment = true;
			}
			else {
				isContinueAfterAttachment = true;
			}
			if(isContinueAfterAttachment == true) {
				if(structKeyExists(FORM, "isActive")) {
					submitComputerRecords.isActive = objValidator.setCheckboxValue(FORM.isActive);
				}
				else {
					submitComputerRecords.isActive = objValidator.setCheckboxValue();
				}
				createComputerRecord = objITManagement.createComputerRecord(submitComputerRecords);
				updateITManagementID = objAssetManagement.updateITManagementID(createComputerRecord, submitComputerRecords.AssetID);
				if(updateITManagementID == true) {
					Alert = objAlerts.setAlertMessage("Success","Record Created.");
				}
				else {
					Alert = objAlerts.setAlertMessage("Error","Something Went Wrong. Please Try Again.");
				}
			}
		}
		else {
			Alert = objITManagementValidator.validateComputer(FORM.IPAddress, FORM.DateIssued, FORM.DateDestroyed, FORM.DateStocked);
		}
	}
	else if(FORM.AssetType == "Equipment") {
		if(objITManagementValidator.validateEquipment(FORM.DateIssued, FORM.DateDestroyed, FORM.DateStocked) == true) {
			submitEquipmentRecords = structNew();
			submitEquipmentRecords.AssetID = FORM.AssetID;
			submitEquipmentRecords.AssetType = FORM.AssetType;
			submitEquipmentRecords.Brand = FORM.Brand;
			submitEquipmentRecords.Model = FORM.Model;
			submitEquipmentRecords.Provider = FORM.Provider;
			submitEquipmentRecords.DateIssued = objValidator.setEmptyStringOrDate(FORM.DateIssued);
			submitEquipmentRecords.DateDestroyed = objValidator.setEmptyStringOrDate(FORM.DateDestroyed);
			submitEquipmentRecords.DateStocked = objValidator.setEmptyStringOrDate(FORM.DateStocked);
			submitEquipmentRecords.Remarks = FORM.Remarks;
			submitEquipmentRecords.Attachment = "";
			isContinueAfterAttachment = false;

			if(FORM.Attachment != "") {
				uploadAttachment = objITManagement.uploadAttachment("Attachment",FORM.AssetType);
				submitEquipmentRecords.Attachment = objITManagement.getFilename(uploadAttachment);
				isContinueAfterAttachment = true;
			}
			else {
				isContinueAfterAttachment = true;
			}
			if(isContinueAfterAttachment == true) {
				if(structKeyExists(FORM, "isActive")) {
					submitEquipmentRecords.isActive = objValidator.setCheckboxValue(FORM.isActive);
				}
				else {
					submitEquipmentRecords.isActive = objValidator.setCheckboxValue();
				}
				createEquipmentRecord = objITManagement.createEquipmentRecord(submitEquipmentRecords);
				updateITManagementID = objAssetManagement.updateITManagementID(createEquipmentRecord, submitEquipmentRecords.AssetID);
				if(updateITManagementID == true) {
					Alert = objAlerts.setAlertMessage("Success","Record Created.");
				}
				else {
					Alert = objAlerts.setAlertMessage("Error","Something Went Wrong. Please Try Again.");
				}
			}
		}
		else {
			Alert = objITManagementValidator.validateEquipment(FORM.DateIssued, FORM.DateDestroyed, FORM.DateStocked);
		}
	}
	else if(FORM.AssetType == "Others") {
		if(objITManagementValidator.validateOthers(FORM.DateIssued, FORM.DateDestroyed, FORM.DateStocked) == true) {
			submitOthersRecords = structNew();
			submitOthersRecords.AssetID = FORM.AssetID;
			submitOthersRecords.AssetType = FORM.AssetType;
			submitOthersRecords.Brand = FORM.Brand;
			submitOthersRecords.Model = FORM.Model;
			submitOthersRecords.DateIssued = objValidator.setEmptyStringOrDate(FORM.DateIssued);
			submitOthersRecords.DateDestroyed = objValidator.setEmptyStringOrDate(FORM.DateDestroyed);
			submitOthersRecords.DateStocked = objValidator.setEmptyStringOrDate(FORM.DateStocked);
			submitOthersRecords.Remarks = FORM.Remarks;
			submitOthersRecords.Attachment = "";
			isContinueAfterAttachment = false;

			if(FORM.Attachment != "") {
				uploadAttachment = objITManagement.uploadAttachment("Attachment",FORM.AssetType);
				submitOthersRecords.Attachment = objITManagement.getFilename(uploadAttachment);
				isContinueAfterAttachment = true;
			}
			else {
				isContinueAfterAttachment = true;
			}
			if(isContinueAfterAttachment == true) {
				if(structKeyExists(FORM, "isActive")) {
					submitOthersRecords.isActive = objValidator.setCheckboxValue(FORM.isActive);
				}
				else {
					submitOthersRecords.isActive = objValidator.setCheckboxValue();
				}
				createOthersRecord = objITManagement.createOthersRecord(submitOthersRecords);
				updateITManagementID = objAssetManagement.updateITManagementID(createOthersRecord, submitOthersRecords.AssetID);
				if(updateITManagementID == true) {
					Alert = objAlerts.setAlertMessage("Success","Record Created.");
				}
				else {
					Alert = objAlerts.setAlertMessage("Error","Something Went Wrong. Please Try Again.");
				}
			}
			
		}
		else {
			Alert = objITManagementValidator.validateOthers(FORM.DateIssued, FORM.DateDestroyed, FORM.DateStocked);
		}
	}
	else {
		Alert = objAlerts.setAlertMessage("Error","Something Went Wrong. Please Try Again.");
	}
}
</cfscript>
