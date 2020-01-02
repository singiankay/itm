<cfset objITManagement = createObject('/itmanagement.com.itmanagement.ITManagement').init() />
<cfset objEquipment = createObject('/itmanagement.com.equipment.Equipment').init() />
<cfscript>
if(structKeyExists(FORM, "attachmentName")) {
	isDelete = objEquipment.deleteFileIfExists(FORM.EquipmentID);
	if(isDelete == true) {
		Delete =objEquipment.updateDeletedAttachment(FORM.EquipmentID);
		if(Delete == true) {
			writeOutput("true");
		}
		else {
			writeOutput("false");
		}
	}
	else {
		writeOutput("false");
	}
}
</cfscript>