component displayname = "Computers" output = "false" hint = "Computers class" accessors = "true" extends="/itmanagement/com/itmanagement/ITManagement"
{
	// variables.attributes.DBNumber = 1;

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
				a.id_record AS type_computer_id, a.computer_type, a.computer_name, a.ip_address, a.processor_type, a.memory_type, a.operating_system, a.office, a.graphics_card, a.date_issued, a.date_updated, a.date_created, a.date_destroyed, a.date_stocked, a.remarks, a.is_active, a.attachment, c.asset_tag
				FROM itmanagement.tbl_computer a 
					INNER JOIN itmanagement.tbl_fk_itmanagement b 
					ON a.id_itmanagement = b.id_record 
						INNER JOIN fixedasset.tbl_assets c
							ON b.id_fixedasset = c.id_record 
				WHERE b.type = :type 
					AND a.is_archive = :isArchive 
			");
			sqlQuery.addParam(name="type", value="Computer", CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="isArchive", value="0", CFSQLTYPE="CF_SQL_INTEGER");
			var resultset = sqlQuery.execute().getResult();
			return resultset;
		}
		catch (any e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
	}

	function getComputer(id) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				SELECT id_record, computer_type, computer_name, ip_address, processor_type, memory_type, operating_system, office, graphics_card, date_issued, date_destroyed, date_stocked, is_active, attachment, remarks 
				FROM tbl_computer 
				WHERE id_record = :id 
				LIMIT 1
			");
			sqlQuery.addParam(name="id", value=arguments.id, CFSQLTYPE="CF_SQL_INTEGER");
			var resultset = sqlQuery.execute().getResult();
			for(var i=1; i<=resultset.recordcount; i++) {
				var Computer = structNew();
				StructInsert(Computer, "id_record", resultset.id_record); 
				StructInsert(Computer, "computer_type", resultset.computer_type); 
				StructInsert(Computer, "computer_name", resultset.computer_name); 
				StructInsert(Computer, "ip_address", resultset.ip_address); 
				StructInsert(Computer, "processor_type", resultset.processor_type);
				StructInsert(Computer, "memory_type", resultset.memory_type);
				StructInsert(Computer, "operating_system", resultset.operating_system);
				StructInsert(Computer, "office", resultset.office);
				StructInsert(Computer, "graphics_card", resultset.graphics_card);
				StructInsert(Computer, "date_issued", resultset.date_issued);
				StructInsert(Computer, "date_destroyed", resultset.date_destroyed);
				StructInsert(Computer, "date_stocked", resultset.date_stocked);
				StructInsert(Computer, "is_active", resultset.is_active);
				StructInsert(Computer, "attachment", resultset.attachment);
				StructInsert(Computer, "remarks", resultset.remarks);
			}
			return Computer;		
		}
		catch (any e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
	}

	function getComputerName(id) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				SELECT computer_name 
				FROM tbl_computer 
				WHERE id_record = :id 
				LIMIT 1
			");
			sqlQuery.addParam(name="id", value=arguments.id, CFSQLTYPE="CF_SQL_INTEGER");
			var resultset = sqlQuery.execute().getResult();
			for(var i=1; i<=resultset.recordcount; i++) {
				return resultset.computer_name;
			}			
		}
		catch (any e) {
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
				FROM tbl_computer 
				WHERE id_record = :id 
				LIMIT 1
			");
			sqlQuery.addParam(name="id", value=arguments.id, CFSQLTYPE="CF_SQL_INTEGER");
			var resultset = sqlQuery.execute().getResult();
			for(var i=1; i<=resultset.recordcount; i++) {
				return resultset.attachment;
			}			
		}
		catch (any e) {
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
				FROM tbl_computer 
				WHERE id_record = :id 
				LIMIT 1
			");
			sqlQuery.addParam(name="id", value=arguments.id, CFSQLTYPE="CF_SQL_INTEGER");
			var resultset = sqlQuery.execute().getResult();
			for(var i=1; i<=resultset.recordcount; i++) {
				return resultset.id_itmanagement;
			}			
		}
		catch (any e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
	}

	function archiveComputer(id) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				UPDATE tbl_computer 
				SET is_archive = :is_archive 
				WHERE id_record = :id 
				LIMIT 1
			");
			sqlQuery.addParam(name="is_archive", value=1, CFSQLTYPE="CF_SQL_INTEGER");
			sqlQuery.addParam(name="id", value=arguments.id, CFSQLTYPE="CF_SQL_INTEGER");
			var resultset = sqlQuery.execute();
			return true;
		}
		catch (any e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
	}

						// CASE 
						// 	WHEN ((:attachment IS NULL OR :attachment = "") AND (attachment IS NULL OR attachment = "")) 
						// 		THEN attachment 
						// 	WHEN ((:attachment IS NULL OR :attachment = "") AND (attachment IS NOT NULL OR attachment != "")) 
						// 		THEN attachment 
						// 	WHEN ((:attachment IS NOT NULL OR :attachment != "") AND (attachment IS NULL OR attachment = "")) 
						// 		THEN :attachment 
						// 	WHEN ((:attachment IS NOT NULL OR :attachment != "") AND (attachment IS NOT NULL OR attachment != "")) 
						// 		THEN :attachment 
						// 	ELSE attachment 
						// END 
	function updateComputer(Computer) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				UPDATE tbl_computer 
				SET computer_type = :computer_type, computer_name = :computer_name, ip_address = :ip_address, processor_type = :processor_type, memory_type = :memory_type, operating_system = :operating_system, office = :office, graphics_card = :graphics_card, date_issued = :date_issued, date_destroyed = :date_destroyed, date_stocked = :date_stocked, remarks = :remarks, is_active = :is_active,
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
			sqlQuery.addParam(name="computer_type", value=arguments.Computer.ComputerType, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="computer_name", value=arguments.Computer.ComputerName, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="ip_address", value=arguments.Computer.IPAddress, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="processor_type", value=arguments.Computer.ProcessorType, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="memory_type", value=arguments.Computer.MemoryType, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="operating_system", value=arguments.Computer.OperatingSystem, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="office", value=arguments.Computer.Office, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="graphics_card", value=arguments.Computer.GraphicsCard, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="date_issued", value=arguments.Computer.DateIssued, CFSQLTYPE="CF_SQL_DATE");
			sqlQuery.addParam(name="date_destroyed", value=arguments.Computer.DateDestroyed, CFSQLTYPE="CF_SQL_DATE");
			sqlQuery.addParam(name="date_stocked", value=arguments.Computer.DateStocked, CFSQLTYPE="CF_SQL_DATE");
			sqlQuery.addParam(name="remarks", value=arguments.Computer.Remarks, CFSQLTYPE="CF_SQL_LONGVARCHAR");
			sqlQuery.addParam(name="attachment", value=arguments.Computer.Attachment, CFSQLTYPE="CF_SQL_LONGVARCHAR");
			sqlQuery.addParam(name="is_active", value=arguments.Computer.isActive, CFSQLTYPE="CF_SQL_TINYINT");
			sqlQuery.addParam(name="id_record", value=arguments.Computer.ComputerID, CFSQLTYPE="CF_SQL_INTEGER");
			
			var resultset = sqlQuery.execute();
		}
		catch (any e) {
			writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
		return true;
	}

	function updateDeletedAttachment(id) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				UPDATE tbl_computer 
				SET attachment = '' 
				WHERE id_record = :id_record 
			");
			sqlQuery.addParam(name="id_record", value=arguments.id, CFSQLTYPE="CF_SQL_INTEGER");
			
			var resultset = sqlQuery.execute();
		}
		catch (any e) {
			writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
		return true;
	}

	function uploadAttachment(attachment) {
		var fileMimeType = "*";
		try {
			var uploadFile = fileUpload("\\npi-appserver\sourcecode\itmanagement\uploads\computers",arguments.Attachment,fileMimeType,"MakeUnique");
		}
		catch (any e) {
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
		if(fileExists("\\npi-appserver\sourcecode\itmanagement\uploads\computers\"&arguments.attachment)) {
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
				fileDelete("\\npi-appserver\sourcecode\itmanagement\uploads\computers\"&attachmentName);
			}
			catch (any e) {
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