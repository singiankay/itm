component displayname = "Attendance" output = "false" hint = "Attendance class" accessors = "true" extends="itmanagement/com/itmanagement/ITManagement"
{

	function init() {
		variables.instance.dsn = super.getDatasource();
		return this;
	}

	function getDatasource() {
		variables.instance.dsn = super.getDatasource();
		return variables.instance.dsn;
	}

	function getRecords(year) {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
					SELECT 

					<cfloop from=1 to=52 index='x'>
							(SELECT percentage
								FROM tbl_attendance WHERE week_num = #i# AND year_num = :year
								) as week_#i#,
				  </cfloop>	
						

					year_num
					FROM tbl_attendance
					WHERE year_num = :year
					LIMIT 1
			");
			sqlQuery.addParam(name="year", value="#arguments.year#", CFSQLTYPE="CF_SQL_VARCHAR");
			var resultset = sqlQuery.execute().getResult();
			return resultset;		
	}



}