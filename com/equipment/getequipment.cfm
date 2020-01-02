<cfset objDatasource = createObject('/itmanagement.com.config.Datasource').init() />
<cfset objITManagement = createObject('itmanagement.com.itmanagement.ITManagement').init() />
<cfset objEquipment = createObject('/itmanagement.com.equipment.Equipment').init() />
<cfset getAllRecords = objEquipment.getAllRecords() />
<cfoutput query="getAllRecords">
	<tr data-value="#getAllRecords.id_record#" class="AssetRows">
			<td>#getAllRecords.id_fixedasset#</td>
			<td>#getAllRecords.asset_tag#</td>
			<td>#getAllRecords.brand#</td>
			<td>#getAllRecords.model#</td>
			<td>#getAllRecords.provider#</td>
			<td>#DateFormat(getAllRecords.date_issued, "mm/dd/yyyy")#</td>
			<td>#DateFormat(getAllRecords.date_destroyed, "mm/dd/yyyy")#</td>
			<td>#DateFormat(getAllRecords.date_stocked, "mm/dd/yyyy")#</td>
			<td>#getAllRecords.remarks#</td>
			<td>
				<cfif getAllRecords.attachment NEQ ''>
					<div class="btn-group-vertical center-block">
					<a href="downloads.cfm?download=true&type=Equipment&file=#URLEncodedFormat(getAllRecords.attachment)#" class="btn btn-sm btn-block bg-navy" target="_blank" role="button">#getAllRecords.attachment#&nbsp;<i class="fa fa-download"></i></a>
					<input type="button" class="btn btn-block btn-xs btn-danger" onclick="deleteEquipmentAttachment('#getAllRecords.attachment#',#getAllRecords.type_equipment_id#)" data-attachment_id="#getAllRecords.attachment#" value="Delete">
					</div>
				</cfif>
			</td>
			<cfif getAllRecords.is_active EQ 1>
				<td><i class="fa fa-check text-green" aria-hidden="true"></i></td>
			<cfelseif getAllRecords.is_active EQ 0>
				<td><i class="fa fa-close text-red" aria-hidden="true"></i></td>
			<cfelse>
				<td>Unknown</td>
			</cfif>
			<td>
				<div class="btn-group-vertical">
					<input type="button" class="btn btn-block btn-sm btn-success" onclick="editEquipment(#getAllRecords.type_equipment_id#)" value="Edit">
					<input type="button" class="btn btn-block btn-sm btn-danger" onclick="archiveEquipment(#getAllRecords.type_equipment_id#)" value="Delete">
					<input type="button" class="btn btn-block btn-sm bg-purple" onclick="showEquipmentHistory(#getAllRecords.id_record#,#getAllRecords.type_equipment_id#,'#getAllRecords.type#')" value="Show History">
				</div>
			</td>
	</tr>
</cfoutput>