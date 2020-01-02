
<cfschedule action = "update" 
    task = "IT Management Maintenance Schedule Reminder (friday)"  
    operation = "HTTPRequest" 
    url = "http://npi-appserver/itmanagement/com/notifications/schedule_reminder.cfm" 
    startDate = "10/19/18" 
    startTime = "6:15 am"
		interval="weekly"
    publish = "no"/> 


<cfschedule action = "update" 
    task = "IT Management Maintenance Schedule Lapse Reminder (monday)"  
    operation = "HTTPRequest" 
    url = "http://npi-appserver/itmanagement/com/notifications/lapse_reminder.cfm" 
    startDate = "10/22/18" 
    startTime = "6:15 am"
		interval="weekly"
    publish = "no"/> 
