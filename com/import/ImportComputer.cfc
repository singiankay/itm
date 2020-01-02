component displayname ="ImportComputer" hint="Import Computer class" accessors="true" persistent="true" extends="itmanagement/com/config/Datasource"
{
	property name="IDITManagement" setter="true" type="any";
	property name="AssetID" setter="true" type="any";
	property name="AssetTag" setter="true";
	property name="ComputerType" setter="true";
	property name="ComputerName" setter="true";
	property name="IPAddress" setter="true";
	property name="Processor" setter="true";
	property name="Memory" setter="true";
	property name="OperatingSystem" setter="true";
	property name="Office" setter="true";
	property name="GraphicsCard" setter="true";
	property name="DateIssued" setter="true";
	property name="Remarks" setter="true";
	property name="IsActive" setter="true";
	property name="Error" setter="true";

	attributes.DBNumber = 1;
	attributes.FixedAssetDBNumber = 2;
	
	// importData = {
	// 	AssetTag = "",
	// 	ComputerType = "",
	// 	ComputerName = "",
	// 	IPAddress = "",
	// 	Processor = "",
	// 	Memory = "",
	// 	OperatingSystem = "",
	// 	Office = "",
	// 	GraphicsCard = "",
	// 	DateIssued = "",
	// 	Remarks = "",
	// 	IsActive = "",
	// 	Error = ""
	// };
	
	function init() {
		instance.dsn = super.setDatasource(attributes.DBNumber);
		return this;
	}

	function setObject(jsonData) {
		var obj = DeserializeJSON(arguments.jsonData);
		var errors = "";
		
		setAssetTag(obj.asset_tag);
		var Asset = isAsset(getAssetTag());
		if(isStruct(Asset)) {
			if(Asset.id_itmanagement != 0) { //should be 0 to correct
				SETIDITMANAGEMENT("");
				setAssetID("");
				errors = listAppend(errors, "Error: Asset already recorded");
			}
			else {
				setIDITManagement(Asset.id_itmanagement);
				setAssetID(Asset.id_record);
			}
		}
		else if(isAsset(getAssetTag()) == false) {
			SETIDITMANAGEMENT("");
			setAssetID("");
			errors = listAppend(errors, "Error: Asset Tag Not Found");
		}
		else {
			setIDITManagement(Asset.id_itmanagement);
			setAssetID(Asset.id_record);
		}

		setComputerType(obj.computer_type);
		setComputerName(obj.computer_name);

		if(IfEmpty(obj.computer_type)) {
			errors = listAppend(errors, "Error: Computer type is required");
		}
		if(IfEmpty(obj.computer_name)) {
			errors = listAppend(errors, "Error: Computer name is required");
		}
		if(!ifEmpty(obj.ip_address)) {
			if(ifIPAddress(obj.ip_address) == false) {
				errors = listAppend(errors, "Error: Invalid IP Address Format");
			}
		}

		setIPAddress(obj.ip_address);
		setProcessor(obj.processor);
		setMemory(obj.memory);
		setOperatingSystem(obj.operating_system);
		setOffice(obj.office);
		setGraphicsCard(obj.graphics_card);
		if(!ifEmpty(obj.date_issued)) {
			if(isDate(obj.date_issued) == "No") {
				errors = listAppend(errors, "Error: Incorrect date format");
			}
		}
		
		var returnError = listToArray(errors);
		
		setDateIssued(obj.date_issued);
		
		setRemarks(obj.remarks);
		setIsActive(1);
		setError(errors);
		structInsert(obj,"asset_id", getAssetID());
		structInsert(obj,"id_itmanagement", getIDITManagement());
		structInsert(obj,"is_active", getIsActive());
		structInsert(obj,"error",returnError);	
		returnData = serializeJSON(obj);
		return returnData;
	}

	function insertData(jsonData) {
		var obj = deserializeJSON(setObject(arguments.jsonData));
		var itm = createITManagement(obj.asset_id);
		var errors = "";

		if(itm.type == "Success") {
			var itm_id = itm.data;
		}
		else if(itm.type == "Error") {
			errors = listAppend(errors, "Error:Problem Creating IT Management Data");
			return itm;
		}
		var computer = createComputer(obj, itm_id);
		if(computer.type == "Success") {
			var computer_id = computer.data;
		}
		else if(computer.type == "Error") {
			errors = listAppend(errors, "Error: Problem Creating Computer Data");
			var returnError = listToArray(errors);
			structUpdate(obj, "error", returnError);
			returnData = serializeJSON(obj);
			return returnData;
		}
		var update_itm = updateITManagementID(obj.asset_id,itm_id);
		if(update_itm.type == "Success") {
			errors = listAppend(errors, update_itm.type);
		}
		else if(update_itm.type == "Error") {
			errors = listAppend(errors, update_itm.message);
			var returnError = listToArray(errors);
			structUpdate(obj, "error", returnError);
			returnData = serializeJSON(obj);
			return returnData;
		}
		var returnError = listToArray(errors);
		structUpdate(obj, "error", returnError);
		returnData = serializeJSON(obj);
		return returnData;
	}

	function createITManagement(asset_id) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				INSERT INTO tbl_fk_itmanagement 
				(id_fixedasset, type) 
				VALUES 
				(:id_fixedasset, :type) 
			");
			sqlQuery.addParam(name="id_fixedasset", value=arguments.asset_id, CFSQLTYPE="CF_SQL_INTEGER");
			sqlQuery.addParam(name="type", value="Computer", CFSQLTYPE="CF_SQL_VARCHAR");
			var resultset = sqlQuery.execute();
			var success = structNew();
			var dataresult = resultset.getPrefix().generatedkey;
			success = {
				type = "Success",
				data = dataresult
			};
			return success;
		}
		catch (any e) {
			var error = structNew();
			var errorresult = e.Message;
			error = {
				type = "Error",
				message = errorresult
			};
			return error;
		}
	}

	function createComputer(obj, itm_id) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				INSERT INTO tbl_computer 
				(id_itmanagement, computer_type, computer_name, ip_address, processor_type, memory_type, operating_system, office, graphics_card, date_issued, date_destroyed, date_stocked, remarks, attachment, is_active) 
				VALUES 
				(:id_itmanagement, :computer_type, :computer_name, :ip_address, :processor_type, :memory_type, :operating_system, :office, :graphics_card, :date_issued, :date_destroyed, date_stocked, :remarks, :attachment, :is_active) 
			");
			sqlQuery.addParam(name="id_itmanagement", value=arguments.itm_id, CFSQLTYPE="CF_SQL_INTEGER");
			sqlQuery.addParam(name="computer_type", value=arguments.obj.computer_type, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="computer_name", value=arguments.obj.computer_name, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="ip_address", value=arguments.obj.ip_address, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="processor_type", value=arguments.obj.processor, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="memory_type", value=arguments.obj.memory, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="operating_system", value=arguments.obj.operating_system, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="office", value=arguments.obj.office, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="graphics_card", value=arguments.obj.graphics_card, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="date_issued", value=arguments.obj.date_issued, CFSQLTYPE="CF_SQL_DATE");
			sqlQuery.addParam(name="date_destroyed", value="", CFSQLTYPE="CF_SQL_DATE");
			sqlQuery.addParam(name="date_stocked", value="", CFSQLTYPE="CF_SQL_DATE");
			sqlQuery.addParam(name="remarks", value=arguments.obj.remarks, CFSQLTYPE="CF_SQL_LONGVARCHAR");
			sqlQuery.addParam(name="attachment", value="", CFSQLTYPE="CF_SQL_LONGVARCHAR");
			sqlQuery.addParam(name="is_active", value=arguments.obj.is_active, CFSQLTYPE="CF_SQL_TINYINT");
			var resultset = sqlQuery.execute();
			var success = structNew();
			var dataresult = resultset.getPrefix().generatedkey;
			success = {
				type = "Success",
				data = dataresult
			};
			return success;
		}
		catch (any e) {
			var error = structNew();
			var errorresult = e.Message;
			error = {
				type = "Error",
				message = errorresult
			};
			return error;
		}
	}

	function updateITManagementID(asset_id, itm_id) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(super.setDatasource(attributes.FixedAssetDBNumber));
			sqlQuery.setSQL("
				UPDATE tbl_assets 
				SET id_itmanagement = :id_itmanagement 
				WHERE id_record = :id_record 
			");
			sqlQuery.addParam(name="id_itmanagement", value=arguments.itm_id, CFSQLTYPE="CF_SQL_INTEGER");
			sqlQuery.addParam(name="id_record", value=arguments.asset_id, CFSQLTYPE="CF_SQL_INTEGER");
			var resultset = sqlQuery.execute();
			var success = structNew();
			success = {
				type = "Success",
				data = "Success"
			};
			return success;
		}
		catch (any e) {
			var error = structNew();
			var errorresult = e.Message;
			error = {
				type = "Error",
				message = errorresult
			};
			return error;
		}

	}

	function isAsset(AssetTag) {
		try {    
		   var sqlQuery = new Query();
			sqlQuery.setDatasource(super.setDatasource(attributes.FixedAssetDBNumber));
			sqlQuery.setSQL("
				SELECT id_record, id_itmanagement 
				FROM tbl_assets 
				WHERE asset_tag = :asset_tag
				LIMIT 1
			");
			sqlQuery.addParam(name="asset_tag", value=arguments.AssetTag, CFSQLTYPE="CF_SQL_VARCHAR");
			var resultset = sqlQuery.execute().getResult();
			if (resultset.recordcount > 0) {
				for (result in resultset) {
					var result = structNew();
					result = {
						id_record = resultset.id_record,
						id_itmanagement = resultset.id_itmanagement 
					};
				}
				return result;
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

	function ifEmpty(value) {
		if(arguments.value == "") {
			return true;
		}
		else {
			return false;
		}
	}

	function ifIPAddress(str) {
		if(isValid("regex",arguments.str,"^(\d|[1-9]\d|1\d\d|2([0-4]\d|5[0-5]))\.(\d|[1-9]\d|1\d\d|2([0-4]\d|5[0-5]))\.(\d|[1-9]\d|1\d\d|2([0-4]\d|5[0-5]))\.(\d|[1-9]\d|1\d\d|2([0-4]\d|5[0-5]))$") == "Yes") {
			return true;
		}
		else {
			return false;
		}
	}
}