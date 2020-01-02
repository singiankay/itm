<cfset objDatasource = createObject('/itmanagement.com.config.Datasource').init() />
<cfset objITManagement = createObject('/itmanagement.com.itmanagement.ITManagement').init() />
<cfset objConsumables = createObject('/itmanagement.com.consumables.Consumables').init() />
<cfset getConsumables = objConsumables.getConsumables() />
<cfoutput query="getConsumables">
	<tr data-value="#getConsumables.id#" class="consumable-rows">
		<td>#getConsumables.name#</td>
		<td>#getConsumables.minimum_level#</td>
		<td>#getConsumables.maximum_level#</td>
		<td>#getConsumables.remarks#</td>
	</tr>
</cfoutput>