component displayname = "EquipmentHistory" output = "false" hint = "Equipment History class" accessors = "true" extends="itmanagement/com/history/History"
{
	function init() {
		variables.instance.dsn = super.getDatasource();
		return this;
	}

	function getDatasource() {
		variables.instance.dsn = super.getDatasource();
		return variables.instance.dsn;
	}

	function getHistory(id, type) {
		try {
			return super.getHistory(arguments.id, arguments.type);
		}
		catch (customExcp e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
	}

	function getHistoryByID(id) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				SELECT date,time,remarks,attachment  
				FROM tbl_revision_history 
				WHERE id_record = :id 
				LIMIT 1
			");
			sqlQuery.addParam(name="id", value=arguments.id, CFSQLTYPE="CF_SQL_INTEGER");
			var resultset = sqlQuery.execute().getResult();
			for(var i=1; i<=resultset.recordcount; i++) {
				var History = structNew();
				History.date = resultset.date;
				History.time = resultset.time;
				History.remarks = resultset.remarks;
				History.attachment = resultset.attachment;
			}
			return History;
		}
		catch (customExcp e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
	}

	function createHistory(History) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				INSERT INTO tbl_revision_history 
				(id_itmanagement, date, time, remarks)
				VALUES
				(:id_itmanagement, :date, :time, :remarks)
			");

			sqlQuery.addParam(name="id_itmanagement", value=arguments.History.ID, CFSQLTYPE="CF_SQL_INTEGER");
			sqlQuery.addParam(name="date", value=arguments.History.HistoryDate, CFSQLTYPE="CF_SQL_DATE");
			sqlQuery.addParam(name="time", value=arguments.History.HistoryTime, CFSQLTYPE="CF_SQL_TIME");
			sqlQuery.addParam(name="remarks", value=arguments.History.Remarks, CFSQLTYPE="CF_SQL_LONGVARCHAR");
			var resultset = sqlQuery.execute();
			if(resultset.getPrefix().generatedkey > 0) {
				return true;
			}
			else {
				return false;
			}
			
		}
		catch (customExcp e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
	}

	function updateHistory(History) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				UPDATE tbl_revision_history 
				SET date =:date, time = :time, remarks = :remarks 
				WHERE id_record = :id_record
			");

			sqlQuery.addParam(name="date", value=arguments.History.HistoryDate, CFSQLTYPE="CF_SQL_DATE");
			sqlQuery.addParam(name="time", value=arguments.History.HistoryTime, CFSQLTYPE="CF_SQL_TIME");
			sqlQuery.addParam(name="remarks", value=arguments.History.Remarks, CFSQLTYPE="CF_SQL_LONGVARCHAR");
			sqlQuery.addParam(name="id_record", value=arguments.History.ID, CFSQLTYPE="CF_SQL_INTEGER");
			
			var resultset = sqlQuery.execute();
			return true;
		}
		catch (customExcp e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
	}	
}