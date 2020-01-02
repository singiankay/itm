component displayname = "Others" output = "false" hint = "Others class" accessors = "true" extends="itmanagement/com/itmanagement/ITManagement"
{

	function init() {
		variables.instance.dsn = super.getDatasource();
		return this;
	}

	function getDatasource() {
		variables.instance.dsn = super.getDatasource();
		return variables.instance.dsn;
	}

	function getAllRecords() {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				SELECT 
				b.id_record, b.type, b.id_fixedasset, b.type, b.date_created, b.date_updated,  
				a.id_record AS type_others_id, a.brand, a.model, a.date_issued, a.date_updated, a.date_created, a.date_destroyed, a.date_stocked, a.remarks, a.attachment, a.is_active, c.asset_tag 
				FROM itmanagement.tbl_others a 
					INNER JOIN itmanagement.tbl_fk_itmanagement b 
						ON a.id_itmanagement = b.id_record 
							INNER JOIN fixedasset.tbl_assets c 
								ON b.id_fixedasset = c.id_record 
				WHERE b.type = :type 
					AND a.is_archive = :isArchive 
			");
			sqlQuery.addParam(name="type", value="Others", CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="isArchive", value="0", CFSQLTYPE="CF_SQL_INTEGER");
			var resultset = sqlQuery.execute().getResult();
			return resultset;
		}
		catch (customExcp e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
	}

	function getOthers(id) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				SELECT id_record, brand, model, date_issued, date_destroyed, date_stocked, is_active, remarks, attachment  
				FROM tbl_others 
				WHERE id_record = :id 
				LIMIT 1
			");
			sqlQuery.addParam(name="id", value=arguments.id, CFSQLTYPE="CF_SQL_INTEGER");
			var resultset = sqlQuery.execute().getResult();
			for(var i=1; i<=resultset.recordcount; i++) {
				var Others = structNew();
				StructInsert(Others, "id_record", resultset.id_record); 
				StructInsert(Others, "brand", resultset.brand); 
				StructInsert(Others, "model", resultset.model); 
				StructInsert(Others, "date_issued", resultset.date_issued);
				StructInsert(Others, "date_destroyed", resultset.date_destroyed);
				StructInsert(Others, "date_stocked", resultset.date_stocked);
				StructInsert(Others, "is_active", resultset.is_active);
				StructInsert(Others, "remarks", resultset.remarks);
				StructInsert(Others, "attachment", resultset.attachment);
			}
			return Others;		
		}
		catch (customExcp e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
	}

	function getOthersName(id) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				SELECT brand, model 
				FROM tbl_others 
				WHERE id_record = :id 
				LIMIT 1
			");
			sqlQuery.addParam(name="id", value=arguments.id, CFSQLTYPE="CF_SQL_INTEGER");
			var resultset = sqlQuery.execute().getResult();
			for(var i=1; i<=resultset.recordcount; i++) {
				return resultset.brand&": "&resultset.model;
			}			
		}
		catch (customExcp e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
	}

	function getAttachmentName(id) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				SELECT attachment 
				FROM tbl_others  
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

	function getITManagementID(id) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				SELECT id_itmanagement 
				FROM tbl_others 
				WHERE id_record = :id 
				LIMIT 1
			");
			sqlQuery.addParam(name="id", value=arguments.id, CFSQLTYPE="CF_SQL_INTEGER");
			var resultset = sqlQuery.execute().getResult();
			for(var i=1; i<=resultset.recordcount; i++) {
				return resultset.id_itmanagement;
			}			
		}
		catch (customExcp e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
	}

	function archiveOthers(id) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				UPDATE tbl_others 
				SET is_archive = :is_archive 
				WHERE id_record = :id 
				LIMIT 1
			");
			sqlQuery.addParam(name="is_archive", value=1, CFSQLTYPE="CF_SQL_INTEGER");
			sqlQuery.addParam(name="id", value=arguments.id, CFSQLTYPE="CF_SQL_INTEGER");
			var resultset = sqlQuery.execute();
			return true;
		}
		catch (customExcp e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
	}

	function updateOthers(Others) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				UPDATE tbl_others 
				SET brand = :brand, model = :model, date_issued = :date_issued, date_destroyed = :date_destroyed, date_stocked = :date_stocked, remarks = :remarks, is_active = :is_active, 
					attachment = ( 
						CASE 
							WHEN :attachment = '' AND attachment = '' 
								THEN attachment 
							WHEN :attachment = '' AND attachment <> '' 
								THEN attachment 
							WHEN :attachment <> '' AND attachment = '' 
								THEN :attachment
							WHEN :attachment <> '' AND attachment <> '' 
								THEN :attachment 
							ELSE attachment 
						END 
					) 
				WHERE id_record = :id_record  
			");
			sqlQuery.addParam(name="brand", value=arguments.Others.Brand, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="model", value=arguments.Others.Model, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="date_issued", value=arguments.Others.DateIssued, CFSQLTYPE="CF_SQL_DATE");
			sqlQuery.addParam(name="date_destroyed", value=arguments.Others.DateDestroyed, CFSQLTYPE="CF_SQL_DATE");
			sqlQuery.addParam(name="date_stocked", value=arguments.Others.DateStocked, CFSQLTYPE="CF_SQL_DATE");
			sqlQuery.addParam(name="remarks", value=arguments.Others.Remarks, CFSQLTYPE="CF_SQL_LONGVARCHAR");
			sqlQuery.addParam(name="attachment", value=arguments.Others.Attachment, CFSQLTYPE="CF_SQL_LONGVARCHAR");
			sqlQuery.addParam(name="is_active", value=arguments.Others.isActive, CFSQLTYPE="CF_SQL_TINYINT");
			sqlQuery.addParam(name="id_record", value=arguments.Others.OthersID, CFSQLTYPE="CF_SQL_INTEGER");
			
			var resultset = sqlQuery.execute();
			
			return true;
		}
		catch (customExcp e) {
			writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
	}

	function updateDeletedAttachment(id) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				UPDATE tbl_others 
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

	function uploadAttachment(attachment) {
		var fileMimeType = "*";
		try {
			var uploadFile = fileUpload("\\npi-appserver\sourcecode\itmanagement\uploads\others",arguments.Attachment,fileMimeType,"MakeUnique");
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

	function ifExistsFilename(attachment) {
		if(fileExists("\\npi-appserver\sourcecode\itmanagement\uploads\others\"&arguments.attachment)) {
			return true;
		}
		else {
			return false;
		}
	}

	function deleteFileIfExists(id) {
		var attachmentName = getAttachmentName(arguments.id);
		if( ifExistsFilename(attachmentName) == true ) {
			try {
				fileDelete("\\npi-appserver\sourcecode\itmanagement\uploads\others\"&attachmentName);
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
}