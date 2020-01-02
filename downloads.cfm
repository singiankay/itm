<cfif structKeyExists(URL, "download")>
	<cfset fileDirectory = URLDecode(URL.file) />
	<cfswitch expression=#URL.type#>
		<cfcase value="Computer">
			<cfset filePath=expandPath("uploads/computers/"&fileDirectory) />	
		</cfcase>
		<cfcase value="Equipment">
			<cfset filePath=expandPath("uploads/equipment/"&fileDirectory) />
		</cfcase>
		<cfcase value="Others">
			<cfset filePath=expandPath("uploads/others/"&fileDirectory) />
		</cfcase>
		<cfcase value="HistoryComputer">
			<cfset filePath=expandPath("uploads/history/computers/"&fileDirectory) />	
		</cfcase>
		<cfcase value="HistoryEquipment">
			<cfset filePath=expandPath("uploads/history/equipment/"&fileDirectory) />
		</cfcase>
		<cfcase value="HistoryOthers">
			<cfset filePath=expandPath("uploads/history/others/"&fileDirectory) />
		</cfcase>
		<cfdefaultcase>
		</cfdefaultcase>
	</cfswitch>
	<cfif fileExists(filePath)>
		<cfset fileName=dateFormat(now(),"yyyymmdd")&timeformat(now(),"HHmmss")&"_"&fileDirectory />
		<cfheader name="Content-Disposition" value="attachment; filename=#fileName#">
		<cfcontent file="#filePath#" type="application/octet-stream">
		<cfabort>
	<cfelse>
		<cfoutput>
			<!DOCTYPE html>
			<html>
			<head>
				<meta charset="utf-8">
				<meta http-equiv="X-UA-Compatible" content="IE=edge">
				<title>Error. File Not Found</title>
			</head>
			<body>
				<h1>Error: File Not Found</h1>
				<p>We are very sorry but the file you are requesting was not found in our server.</p>
				<p>Please contact the MIS Department about this issue. Thank you.</p>
			</body>
			</html>
		</cfoutput>
	</cfif>
</cfif>