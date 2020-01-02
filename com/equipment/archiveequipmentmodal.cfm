<cfif structKeyExists(URL, "id")>
	<cfset objEquipment = createObject('/itmanagement.com.equipment.Equipment').init() />
	<cfset objITManagement = createObject('/itmanagement.com.itmanagement.ITManagement').init() />
	<cfset equipmentName = objEquipment.getEquipmentName(URL.id) />
	<cfset ITManagementID = objEquipment.getITManagementID(URL.id) />
	<cfset AssetID = objITManagement.getFixedAssetID(ITManagementID) />
	<input type="hidden" id="archiveEquipmentFormValue" name="archiveEquipmentFormValue" value="<cfoutput>#URL.id#</cfoutput>">
	<input type="hidden" id="assetID" name="assetID" value="<cfoutput>#AssetID#</cfoutput>">
	<p>Are you sure you want to delete Equipment <cfoutput>#equipmentName#</cfoutput>?</p>
	<p>Note: It cannot be undone.</p>
</cfif>