component displayname="ITM" output="false" hint="IT Management Class" accessors="true" extends="itmanagement/com/config/Datasource"
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

	function getFixedAssetID(itm_id) {
		try {    
		   var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				SELECT id_fixedasset 
				FROM tbl_fk_itmanagement 
				WHERE id_record = :id_record 
				LIMIT 1
			");
			sqlQuery.addParam(name="id_record", value=arguments.itm_id, CFSQLTYPE="CF_SQL_INTEGER");
			var resultset = sqlQuery.execute().getResult();
			for(var i=1; i<=resultset.recordcount; i++) {
				var id = resultset.id_fixedasset;
			}
			return id;
		}
		catch (customExcp e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
	}

	function getAllRecords () {
		var sqlQuery = new Query();
		sqlQuery.setDatasource(variables.instance.dsn);
		sqlQuery.setSQL("
			SELECT id_record, asset_tag, description 
			FROM tbl_assets 
			WHERE isActive = :isActive 
			AND equipment_type = :equipment_type 
			AND id_itmanagement = :id_itmanagement
		");
		sqlQuery.addParam(name="isActive", value="1", CFSQLTYPE="CF_SQL_INTEGER");
		sqlQuery.addParam(name="equipment_type", value="2", CFSQLTYPE="CF_SQL_INTEGER");
		sqlQuery.addParam(name="id_itmanagement", value="0", CFSQLTYPE="CF_SQL_INTEGER");
		var resultset = sqlQuery.execute().getResult();
		return resultset;
	}

	function createITManagementRecord(id_fixedasset, type) {
		
		try {    
		   var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				INSERT INTO tbl_fk_itmanagement 
				(id_fixedasset, type) 
				VALUES 
				(:id_fixedasset, :type) 
			");
			sqlQuery.addParam(name="id_fixedasset", value=arguments.id_fixedasset, CFSQLTYPE="CF_SQL_INTEGER");
			sqlQuery.addParam(name="type", value=arguments.type, CFSQLTYPE="CF_SQL_VARCHAR");
			var resultset = sqlQuery.execute();
			return resultset.getPrefix().generatedkey;
		}
		catch (customExcp e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
	}

	function createComputerRecord(computerData) {
		var ItManagementID = createITManagementRecord(arguments.computerData.AssetID,arguments.computerData.AssetType);
		var ComputerID = insertComputerRecord(ItManagementID, arguments.computerData);
		return ItManagementID;
	}

	function insertComputerRecord(ItManagementID, ComputerData) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				INSERT INTO tbl_computer 
				(id_itmanagement, computer_type, computer_name, ip_address, processor_type, memory_type, operating_system, office, graphics_card, date_issued, date_destroyed, date_stocked, remarks, attachment, is_active) 
				VALUES 
				(:id_itmanagement, :computer_type, :computer_name, :ip_address, :processor_type, :memory_type, :operating_system, :office, :graphics_card, :date_issued, :date_destroyed, :date_stocked, :remarks, :attachment, :is_active) 
			");
			sqlQuery.addParam(name="id_itmanagement", value=arguments.ItManagementID, CFSQLTYPE="CF_SQL_INTEGER");
			sqlQuery.addParam(name="computer_type", value=arguments.ComputerData.ComputerType, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="computer_name", value=arguments.ComputerData.ComputerName, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="ip_address", value=arguments.ComputerData.IPAddress, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="processor_type", value=arguments.ComputerData.ProcessorType, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="memory_type", value=arguments.ComputerData.MemoryType, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="operating_system", value=arguments.ComputerData.OperatingSystem, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="office", value=arguments.ComputerData.Office, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="graphics_card", value=arguments.ComputerData.GraphicsCard, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="date_issued", value=arguments.ComputerData.DateIssued, CFSQLTYPE="CF_SQL_DATE");
			sqlQuery.addParam(name="date_destroyed", value=arguments.ComputerData.DateDestroyed, CFSQLTYPE="CF_SQL_DATE");
			sqlQuery.addParam(name="date_stocked", value=arguments.ComputerData.DateStocked, CFSQLTYPE="CF_SQL_DATE");
			sqlQuery.addParam(name="remarks", value=arguments.ComputerData.Remarks, CFSQLTYPE="CF_SQL_LONGVARCHAR");
			sqlQuery.addParam(name="attachment", value=arguments.ComputerData.Attachment, CFSQLTYPE="CF_SQL_LONGVARCHAR");
			sqlQuery.addParam(name="is_active", value=arguments.ComputerData.isActive, CFSQLTYPE="CF_SQL_TINYINT");
			var resultset = sqlQuery.execute();
			return resultset.getPrefix().generatedkey;
		}
		catch (customExcp e) {
			writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
	}

	function createEquipmentRecord(equipmentData) {
		var ITManagementID = createITManagementRecord(arguments.equipmentData.AssetID,arguments.equipmentData.AssetType);
		var EquipmentID = insertEquipmentRecord(ItManagementID, arguments.equipmentData);
		return ITManagementID;
	}

	function insertEquipmentRecord(ItManagementID, EquipmentData) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				INSERT INTO tbl_equipment 
				(id_itmanagement, brand, model, provider, date_issued, date_destroyed, date_stocked, remarks, attachment, is_active) 
				VALUES 
				(:id_itmanagement, :brand, :model, :provider, :date_issued, :date_destroyed, :date_stocked, :remarks, :attachment, :is_active) 
			");
			sqlQuery.addParam(name="id_itmanagement", value=arguments.ItManagementID, CFSQLTYPE="CF_SQL_INTEGER");
			sqlQuery.addParam(name="brand", value=arguments.EquipmentData.Brand, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="model", value=arguments.EquipmentData.Model, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="provider", value=arguments.EquipmentData.Provider, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="date_issued", value=arguments.EquipmentData.DateIssued, CFSQLTYPE="CF_SQL_DATE");
			sqlQuery.addParam(name="date_destroyed", value=arguments.EquipmentData.DateDestroyed, CFSQLTYPE="CF_SQL_DATE");
			sqlQuery.addParam(name="date_stocked", value=arguments.EquipmentData.DateStocked, CFSQLTYPE="CF_SQL_DATE");
			sqlQuery.addParam(name="remarks", value=arguments.EquipmentData.Remarks, CFSQLTYPE="CF_SQL_LONGVARCHAR");
			sqlQuery.addParam(name="attachment", value=arguments.EquipmentData.Attachment, CFSQLTYPE="CF_SQL_LONGVARCHAR");
			sqlQuery.addParam(name="is_active", value=arguments.EquipmentData.isActive, CFSQLTYPE="CF_SQL_TINYINT");
			var resultset = sqlQuery.execute();
			return resultset.getPrefix().generatedkey;
		}
		catch (customExcp e) {
			writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
	}

	function createOthersRecord(othersData) {
		var ITManagementID = createITManagementRecord(arguments.othersData.AssetID,arguments.othersData.AssetType);
		var OthersID = insertOthersRecord(ItManagementID, arguments.othersData);
		return ITManagementID;
	}

	function insertOthersRecord(ItManagementID, OthersData) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				INSERT INTO tbl_others  
				(id_itmanagement, brand, model, date_issued, date_destroyed, date_stocked, remarks, attachment, is_active) 
				VALUES 
				(:id_itmanagement, :brand, :model, :date_issued, :date_destroyed, :date_stocked, :remarks, :attachment, :is_active) 
			");
			sqlQuery.addParam(name="id_itmanagement", value=arguments.ItManagementID, CFSQLTYPE="CF_SQL_INTEGER");
			sqlQuery.addParam(name="brand", value=arguments.OthersData.Brand, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="model", value=arguments.OthersData.Model, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="date_issued", value=arguments.OthersData.DateIssued, CFSQLTYPE="CF_SQL_DATE");
			sqlQuery.addParam(name="date_destroyed", value=arguments.OthersData.DateDestroyed, CFSQLTYPE="CF_SQL_DATE");
			sqlQuery.addParam(name="date_stocked", value=arguments.OthersData.DateStocked, CFSQLTYPE="CF_SQL_DATE");
			sqlQuery.addParam(name="remarks", value=arguments.OthersData.Remarks, CFSQLTYPE="CF_SQL_LONGVARCHAR");
			sqlQuery.addParam(name="attachment", value=arguments.OthersData.Attachment, CFSQLTYPE="CF_SQL_LONGVARCHAR");
			sqlQuery.addParam(name="is_active", value=arguments.OthersData.isActive, CFSQLTYPE="CF_SQL_TINYINT");
			var resultset = sqlQuery.execute();
			return resultset.getPrefix().generatedkey;
		}
		catch (customExcp e) {
			writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
	}
	
	function uploadAttachment(attachment,type) {
		var fileMimeType = "*";
		try {
			switch(arguments.type) {
				case "Computer":
					var uploadFile = fileUpload("\\npi-appserver\sourcecode\itmanagement\uploads\computers",arguments.Attachment,fileMimeType,"MakeUnique");
				break;
				case "Equipment":
					var uploadFile = fileUpload("\\npi-appserver\sourcecode\itmanagement\uploads\equipment",arguments.Attachment,fileMimeType,"MakeUnique");
				break;
				case "Others":
					var uploadFile = fileUpload("\\npi-appserver\sourcecode\itmanagement\uploads\others",arguments.Attachment,fileMimeType,"MakeUnique");
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

	/* 
	 *	Problem with this function is that MakeUnique isn't working when File is renamed
	 */
	// function renameAttachment(uploadFile,type,id) {
	// 	var oldName = arguments.uploadFile.serverDirectory&"/"&arguments.uploadFile.serverFile;
	// 	var Filename = arguments.uploadFile.serverFileName;
	// 	var uploadExt = arguments.uploadFile.serverFileExt;
	// 	var period = now();

	// 	switch(arguments.type) {
	// 		case "Computer":
	// 			var newName = arguments.uploadFile.serverDirectory&"/CP"&arguments.id&"_"&Filename&"."&uploadExt;
	// 			var returnName = "CP"&arguments.id&"_"&Filename&"."&uploadExt;
				
	// 		break;
	// 		case "Equipment":
	// 			var newName = arguments.uploadFile.serverDirectory&"/EQ"&arguments.id&"_"&Filename&"."&uploadExt;
	// 			var returnName = "EQ"&arguments.id&"_"&Filename&"."&uploadExt;
	// 		break;
	// 		case "Others":
	// 			var newName = arguments.uploadFile.serverDirectory&"/OT"&arguments.id&"_"&Filename&"."&uploadExt;
	// 			var returnName = "OT"&arguments.id&"_"&Filename&"."&uploadExt;
	// 		break;
	// 	}
	// 	try {
	// 		fileMove(oldName, newName);
	// 	}
	// 	catch (customExcp e) {
	// 		writeOutput("Error");
	// 	    writeDump(e); // have a look at the contents of this
	// 	}
	// 	return returnName;
	// }
}