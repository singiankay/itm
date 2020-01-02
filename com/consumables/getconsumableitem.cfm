<cfset objDatasource = createObject('/itmanagement.com.config.Datasource').init() />
<cfset objITManagement = createObject('/itmanagement.com.itmanagement.ITManagement').init() />
<cfset objConsumables = createObject('/itmanagement.com.consumables.Consumables').init() />
<cfscript>
	if(structKeyExists(URL, "id")) {
		consumableItem = objConsumables.getConsumableItemByID(URL.id);
		actionsArray = objConsumables.getActions();
		structInsert(consumableItem, "actions", actionsArray);
		writeOutput(serializeJSON(consumableItem));
	}
</cfscript>