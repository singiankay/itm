component displayname = "History" output = "false" hint = "History class" accessors = "true" extends="itmanagement/com/config/Datasource"
{
	variables.attributes.DBNumber = 1;

	function init() {
		variables.instance.dsn = super.setDatasource(variables.attributes.DBNumber);
		return this;
	}

	function getDatasource() {
		variables.instance.dsn = super.setDatasource(variables.attributes.DBNumber);
		return variables.instance.dsn;
	}

	function getHistory(id,type) {
		
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			if(arguments.type == "Computer") {
				sqlQuery.setSQL("
					SELECT tbl_revision_history.id_record, tbl_revision_history.date, tbl_revision_history.time, tbl_revision_history.remarks, tbl_revision_history.attachment, tbl_revision_history.date_created, tbl_fk_itmanagement.type   
					FROM ((tbl_revision_history 
					INNER JOIN tbl_computer 
					ON tbl_revision_history.id_itmanagement = tbl_computer.id_itmanagement) 
					INNER JOIN tbl_fk_itmanagement 
					ON tbl_revision_history.id_itmanagement = tbl_fk_itmanagement.id_record) 
					WHERE tbl_revision_history.id_itmanagement = :id 
				");
			}
			if(arguments.type == "Equipment") {
				sqlQuery.setSQL("
					SELECT tbl_revision_history.id_record, tbl_revision_history.date, tbl_revision_history.time, tbl_revision_history.remarks, tbl_revision_history.attachment, tbl_revision_history.date_created, tbl_fk_itmanagement.type   
					FROM ((tbl_revision_history 
					INNER JOIN tbl_equipment 
					ON tbl_revision_history.id_itmanagement = tbl_equipment.id_itmanagement) 
					INNER JOIN tbl_fk_itmanagement 
					ON tbl_revision_history.id_itmanagement = tbl_fk_itmanagement.id_record) 
					WHERE tbl_revision_history.id_itmanagement = :id 
				");
			}

			if(arguments.type == "Others") {
				sqlQuery.setSQL("
					SELECT tbl_revision_history.id_record, tbl_revision_history.date, tbl_revision_history.time, tbl_revision_history.remarks, tbl_revision_history.attachment, tbl_revision_history.date_created, tbl_fk_itmanagement.type   
					FROM ((tbl_revision_history 
					INNER JOIN tbl_others 
					ON tbl_revision_history.id_itmanagement = tbl_others.id_itmanagement) 
					INNER JOIN tbl_fk_itmanagement 
					ON tbl_revision_history.id_itmanagement = tbl_fk_itmanagement.id_record) 
					WHERE tbl_revision_history.id_itmanagement = :id 
				");
			}

			sqlQuery.addParam(name="id", value=arguments.id, CFSQLTYPE="CF_SQL_INTEGER");
			var resultset = sqlQuery.execute().getResult();
			return resultset;
		}
		catch (customExcp e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
	}

	function uploadAttachment(attachment, type) {
		var fileMimeType = "*";
		try {
			switch(arguments.type) {
				case "Computer":
					var uploadFile = fileUpload("\\npi-appserver\sourcecode\itmanagement\uploads\history\computers",arguments.Attachment,fileMimeType,"MakeUnique");
				break;
				case "Equipment":
					var uploadFile = fileUpload("\\npi-appserver\sourcecode\itmanagement\uploads\history\equipment",arguments.Attachment,fileMimeType,"MakeUnique");
				break;
				case "Others":
					var uploadFile = fileUpload("\\npi-appserver\sourcecode\itmanagement\uploads\history\others",arguments.Attachment,fileMimeType,"MakeUnique");
				break;
			}
		}
		catch (customExcp e) {
			writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
		if(uploadFile.fileWasSaved) {
			return uploadFile;
		}
		else {
			return false;
		}
	}

	function getFilename(attachment) {
		var name = arguments.attachment.serverFileName&"."&arguments.attachment.serverFileExt;
		return name;
	}

	function deleteFileIfExists(id,type) {
		var attachmentName = getAttachmentName(arguments.id);
		if( ifExistsFilename(attachmentName,arguments.type) == true ) {
			try {
				switch (arguments.type) {
					case "Computer":
						fileDelete("\\npi-appserver\sourcecode\itmanagement\uploads\history\computers\"&attachmentName);
					break;
					case "Equipment":
						fileDelete("\\npi-appserver\sourcecode\itmanagement\uploads\history\equipment\"&attachmentName);
					break;
					case "Others":
						fileDelete("\\npi-appserver\sourcecode\itmanagement\uploads\history\others\"&attachmentName);
					break;
				}
			}
			catch (customExcp e) {
				writeOutput("Error");
			    writeDump(e); // have a look at the contents of this
			}
			return true;
		}
		else {
			return true;
		}
	}

	function getAttachmentName(id) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				SELECT attachment 
				FROM tbl_revision_history 
				WHERE id_record = :id 
				LIMIT 1
			");
			sqlQuery.addParam(name="id", value=arguments.id, CFSQLTYPE="CF_SQL_INTEGER");
			var resultset = sqlQuery.execute().getResult();
			for(var i=1; i<=resultset.recordcount; i++) {
				return resultset.attachment;
			}			
		}
		catch (customExcp e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
	}

	function ifExistsFilename(attachment, type) {
		switch (arguments.type) {
			case "Computer":
				var FilePath = "\\npi-appserver\sourcecode\itmanagement\uploads\history\computers\"&arguments.attachment;
			break;
			case "Equipment":
				var FilePath = "\\npi-appserver\sourcecode\itmanagement\uploads\history\equipment\"&arguments.attachment;
			break;
			case "Others":
				var FilePath = "\\npi-appserver\sourcecode\itmanagement\uploads\history\others\"&arguments.attachment;
			break;
		}

		if(fileExists(FilePath)) {
			return true;
		}
		else {
			return false;
		}
	}

	function updateDeletedAttachment(id) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				UPDATE tbl_revision_history 
				SET attachment = '' 
				WHERE id_record = :id_record 
			");
			sqlQuery.addParam(name="id_record", value=arguments.id, CFSQLTYPE="CF_SQL_INTEGER");
			
			var resultset = sqlQuery.execute();
		}
		catch (customExcp e) {
			writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
		return true;
	}
}