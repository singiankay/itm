<cfset objDatasource = createObject('/itmanagement.com.config.Datasource').init() />
<cfset objITManagement = createObject('/itmanagement.com.itmanagement.ITManagement').init() />
<cfset objConsumables = createObject('/itmanagement.com.consumables.Consumables').init() />
<cfscript>
	if(structKeyExists(URL, "id")) {
		getConsumableItems = objConsumables.getConsumableItems(URL.id);
		 writeOutput(serializeJSON(getConsumableItems));
	}
</cfscript>