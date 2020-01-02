<cfset objITManagement = createObject('/itmanagement.com.itmanagement.ITManagement').init() />
<cfset objComputers = createObject('/itmanagement.com.computers.Computers').init() />
<cfscript>
if(structKeyExists(FORM, "attachmentName")) {
	isDelete = objComputers.deleteFileIfExists(FORM.ComputerID);
	if(isDelete == true) {
		Delete =objComputers.updateDeletedAttachment(FORM.ComputerID);
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