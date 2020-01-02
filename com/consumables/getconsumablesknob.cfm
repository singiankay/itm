<cfset objDatasource = createObject('/itmanagement.com.config.Datasource').init() />
<cfset objITManagement = createObject('/itmanagement.com.itmanagement.ITManagement').init() />
<cfset objConsumables = createObject('/itmanagement.com.consumables.Consumables').init() />
<cfset getConsumables = objConsumables.getConsumablesKnob() />
<cfscript>
    writeOutput(serializeJSON(getConsumables));
</cfscript>