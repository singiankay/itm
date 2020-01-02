<cfset objAlerts = createObject('/itmanagement.com.config.Alerts').init() />
<cfset objLogin = createObject('/itmanagement.com.login.Login').init() />
<cfset objHRIS = createObject('/itmanagement.com.login.HRIS').init() />
<cfset Alert = objAlerts.setAlertMessage("","") />