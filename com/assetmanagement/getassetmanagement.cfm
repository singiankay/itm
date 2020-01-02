<cfset objAssetManagement = createObject('/itmanagement.com.assetmanagement.AssetManagement').init() />
<cfset getAllRecords = objAssetManagement.getAllRecords()>
<cfoutput query="getAllRecords">
	<tr data-value="#getAllRecords.id_record#" class="AssetRows">
			<td>#getAllRecords.id_record#</td>
			<td>#getAllRecords.asset_tag#</td>
			<td>#DateFormat(getAllRecords.invoice_post, "mm/dd/yyyy")#</td>
			<td>#getAllRecords.description#</td>
	</tr>
</cfoutput>