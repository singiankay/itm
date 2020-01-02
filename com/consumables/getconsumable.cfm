<cfset objDatasource = createObject('/itmanagement.com.config.Datasource').init() />
<cfset objITManagement = createObject('/itmanagement.com.itmanagement.ITManagement').init() />
<cfset objConsumables = createObject('/itmanagement.com.consumables.Consumables').init() />
<cfset getConsumables = objConsumables.getConsumables() />
<cfscript>
	if(structKeyExists(URL, "get_consumable")) {
		consumable = objConsumables.getConsumableByID(URL.id);
		writeOutput(serializeJSON(consumable));
	}
</cfscript>