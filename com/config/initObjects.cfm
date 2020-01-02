<cfif structKeyExists(Session, "loggedin") >
	<cfif Session.loggedin EQ true>
		<cfset objAlerts = createObject('/itmanagement.com.config.Alerts').init() />
		<cfset objAssetManagement = createObject('/itmanagement.com.assetmanagement.AssetManagement').init() />
		<cfset objITManagement = createObject('/itmanagement.com.itmanagement.ITManagement').init() />
		<cfset objValidator = createObject('/itmanagement.com.config.Validator').init() />
		<cfset objITManagementValidator = createObject('/itmanagement.com.config.ITManagementValidator').init() />
		<cfset objComputers = createObject('/itmanagement.com.computers.Computers').init() />
		<cfset objEquipment = createObject('/itmanagement.com.equipment.Equipment').init() />
		<cfset objOthers = createObject('/itmanagement.com.others.Others').init() />
		<cfset objConsumables = createObject('/itmanagement.com.consumables.Consumables').init() />
		<cfset Alert = objAlerts.setAlertMessage("","") />
	</cfif>
<cfelse>
	<cfset RedirectURL = "login.cfm?Redirect="&listlast(cgi.script_name,"/") />
	<cflocation url=#RedirectURL# addtoken="no"/>
</cfif>