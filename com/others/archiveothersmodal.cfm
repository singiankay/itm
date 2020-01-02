<cfif structKeyExists(URL, "id")>
	<cfset objOthers = createObject('itmanagement.com.others.Others').init() />
	<cfset objITManagement = createObject('itmanagement.com.itmanagement.ITManagement').init() />
	<cfset othersName = objOthers.getOthersName(URL.id) />
	<cfset ITManagementID = objOthers.getITManagementID(URL.id) />
	<cfset AssetID = objITManagement.getFixedAssetID(ITManagementID) />
	<input type="hidden" id="archiveOthersFormValue" name="archiveOthersFormValue" value="<cfoutput>#URL.id#</cfoutput>">
	<input type="hidden" id="assetID" name="assetID" value="<cfoutput>#AssetID#</cfoutput>">
	<p>Are you sure you want to delete Others <cfoutput>#othersName#</cfoutput>?</p>
	<p>Note: It cannot be undone.</p>
</cfif>