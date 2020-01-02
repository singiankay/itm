component displayname = "AssetManagement" output = "false" hint = "AssetManagement class" accessors = "true" extends="itmanagement/com/config/Datasource"
{

	variables.attributes.DBNumber = 2;

	function init() {
		variables.instance.dsn = super.setDatasource(variables.attributes.DBNumber);
		return this;
	}

	function getAllRecords() {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				SELECT id_record, asset_tag, invoice_post, description 
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
		catch (customExcp e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
	}

	function getITAssetRecords() {
		try {
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
		catch (customExcp e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
	}

	function updateITManagementID(ITManagementID, AssetID) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				UPDATE tbl_assets 
				SET id_itmanagement = :id_itmanagement 
				WHERE id_record = :id_record 
			");
			sqlQuery.addParam(name="id_itmanagement", value=arguments.ITManagementID, CFSQLTYPE="CF_SQL_INTEGER");
			sqlQuery.addParam(name="id_record", value=arguments.AssetID, CFSQLTYPE="CF_SQL_INTEGER");
			var resultset = sqlQuery.execute();
			return true;
		}
		catch (customExcp e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
	}

	function unlinkAssetManagement(AssetID) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				UPDATE tbl_assets 
				SET id_itmanagement = :id_itmanagement 
				WHERE id_record = :id_record 
			");
			sqlQuery.addParam(name="id_itmanagement", value=0, CFSQLTYPE="CF_SQL_INTEGER");
			sqlQuery.addParam(name="id_record", value=arguments.AssetID, CFSQLTYPE="CF_SQL_INTEGER");
			var resultset = sqlQuery.execute();
			return true;
		}
		catch (customExcp e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
	}
}