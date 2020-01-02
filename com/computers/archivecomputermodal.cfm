<cfif structKeyExists(URL, "id")>
	<cfset objComputers = createObject('/itmanagement.com.computers.Computers').init() />
	<cfset objITManagement = createObject('/itmanagement.com.itmanagement.ITManagement').init() />
	<cfset computerName = objComputers.getComputerName(URL.id) />
	<cfset ITManagementID = objComputers.getITManagementID(URL.id) />
	<cfset AssetID = objITManagement.getFixedAssetID(ITManagementID) />
	<input type="hidden" id="archiveComputerFormValue" name="archiveComputerFormValue" value="<cfoutput>#URL.id#</cfoutput>">
	<input type="hidden" id="assetID" name="assetID" value="<cfoutput>#AssetID#</cfoutput>">
	<p>Are you sure you want to delete Computer <cfoutput>#computerName#</cfoutput>?</p>
	<p>Note: It cannot be undone.</p>
</cfif>