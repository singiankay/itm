<cfset objDatasource = createObject('itmanagement.com.config.Datasource').init() />
<cfset objImportComputer = createObject('itmanagement.com.import.ImportComputer').init() />
<cfscript>
if(structKeyExists(FORM, "uploadData")) {
	result = objImportComputer.setObject(FORM.uploadData);
	writeOutput(result);
}
else if(structKeyExists(FORM, "importData")) {
	result = objImportComputer.insertData(FORM.importData);
	writeOutput(result);
}
</cfscript>