component displayname = "Consumables" output = "false" hint = "Consumables class" accessors = "true" extends="/itmanagement/com/itmanagement/ITManagement"
{	
	actions = ["stock", "withdraw"];

	function init() {
		variables.instance.dsn = super.getDatasource();
		return this;
	}

	function getDatasource() {
		variables.instance.dsn = super.getDatasource();
		return variables.instance.dsn;
	}

	function getActions() {
		return actions;
	}

	function getConsumables() {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				SELECT id, name, minimum_level, maximum_level, remarks, date_created, date_updated 
				  FROM tbl_consumables 
				 WHERE is_active = :is_active 
			");
			sqlQuery.addParam(name="is_active", value="1", CFSQLTYPE="CF_SQL_INTEGER");
			var resultset = sqlQuery.execute().getResult();
			return resultset;
		}
		catch (any e) {
			writeOutput("Error");
		   writeDump(e); // have a look at the contents of this
		}
	}

	function getConsumableName(id) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				SELECT name 
				  FROM tbl_consumables 
				 WHERE is_active = :is_active 
				   AND id = :id
			");
			sqlQuery.addParam(name="is_active", value="1", CFSQLTYPE="CF_SQL_INTEGER");
			sqlQuery.addParam(name="id", value=arguments.id, CFSQLTYPE="CF_SQL_INTEGER");
			var resultset = sqlQuery.execute().getResult();
			for(result in resultset) {
				return resultset.name;
			}
		}
		catch (any e) {
			writeOutput("Error");
		   writeDump(e); // have a look at the contents of this
		}
	}

	function getConsumablesKnob() {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				SELECT id AS consumables_id, name, minimum_level, maximum_level, remarks,
					  (
						 IFNULL((SELECT SUM(quantity) 
						   FROM tbl_consumables_items 
						  WHERE action = :add 
						    AND is_active = :is_active 
						    AND fk_consumables_id = consumables_id), 0) 
						 -
						 IFNULL((SELECT SUM(quantity) 
						   FROM tbl_consumables_items 
						  WHERE action = :subtract 
						    AND is_active = :is_active 
						    AND fk_consumables_id = consumables_id), 0) 
					  ) AS qty_on_hand 
				  FROM tbl_consumables 
				 WHERE is_active = :is_active 
				 ORDER BY name 
			");
			sqlQuery.addParam(name="is_active", value="1", CFSQLTYPE="CF_SQL_INTEGER");
			sqlQuery.addParam(name="add", value="stock", CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="subtract", value="withdraw", CFSQLTYPE="CF_SQL_VARCHAR");
			var resultset = sqlQuery.execute().getResult();
			return resultset;
		}
		catch (any e) {
			writeOutput("Error");
		   writeDump(e); // have a look at the contents of this
		}
	}

	function getConsumableItems(id) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				SELECT id, fk_consumables_id, description, action, quantity, remarks, date_recorded 
				  FROM tbl_consumables_items 
				 WHERE is_active = :is_active 
				   AND fk_consumables_id = :id 
				 ORDER BY date_recorded 
			");
			sqlQuery.addParam(name="is_active", value="1", CFSQLTYPE="CF_SQL_INTEGER");
			sqlQuery.addParam(name="id", value=arguments.id, CFSQLTYPE="CF_SQL_INTEGER");
			var resultset = sqlQuery.execute().getResult();
			return resultset;
		}
		catch (any e) {
			writeOutput("Error");
		   writeDump(e); // have a look at the contents of this
		}
	}

	function getConsumableByID(id) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				SELECT id, name, minimum_level, maximum_level, remarks 
				  FROM tbl_consumables 
				 WHERE is_active = :is_active 
				   AND id = :id
			");
			sqlQuery.addParam(name="is_active", value="1", CFSQLTYPE="CF_SQL_INTEGER");
			sqlQuery.addParam(name="id", value=arguments.id, CFSQLTYPE="CF_SQL_INTEGER");
			var resultset = sqlQuery.execute().getResult();
			var consumable = structNew();
			for(result in resultset) {
				consumable['id'] = resultset.id;
				consumable['name'] = resultset.name;
				consumable['minimum_level'] = resultset.minimum_level;
				consumable['maximum_level'] = resultset.maximum_level;
				consumable['remarks'] = resultset.remarks;
			}
			return consumable;
		}
		catch (any e) {
			writeOutput("Error");
		   writeDump(e); // have a look at the contents of this
		}
	}

	function getConsumableItemByID(id) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				SELECT id, fk_consumables_id, description, action, quantity, remarks, date_recorded  
				  FROM tbl_consumables_items 
				 WHERE is_active = :is_active 
				   AND id = :id 
			");
			sqlQuery.addParam(name="is_active", value="1", CFSQLTYPE="CF_SQL_INTEGER");
			sqlQuery.addParam(name="id", value=arguments.id, CFSQLTYPE="CF_SQL_INTEGER");
			var resultset = sqlQuery.execute().getResult();
			var consumableItem = structNew();
			for(result in resultset) {
				consumableItem['id'] = resultset.id;
				consumableItem['fk_consumables_id'] = resultset.fk_consumables_id;
				consumableItem['description'] = resultset.description;
				consumableItem['action'] = resultset.action;
				consumableItem['quantity'] = resultset.quantity;
				consumableItem['remarks'] = resultset.remarks;
				consumableItem['date_recorded'] = resultset.date_recorded;
			}
			return consumableItem;
		}
		catch (any e) {
			writeOutput("Error");
		   writeDump(e); // have a look at the contents of this
		}
	}

	function createConsumable(data) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				INSERT INTO tbl_consumables (name, minimum_level, maximum_level, remarks) 
				VALUES (:name, :minimum_level, :maximum_level, :remarks)
			");
			sqlQuery.addParam(name="name", value=arguments.data.name, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="minimum_level", value=arguments.data.MinimumLevel, CFSQLTYPE="CF_SQL_INTEGER");
			sqlQuery.addParam(name="maximum_level", value=arguments.data.MaximumLevel, CFSQLTYPE="CF_SQL_INTEGER");
			sqlQuery.addParam(name="remarks", value=arguments.data.remarks, CFSQLTYPE="CF_SQL_LONGVARCHAR");
			var resultset = sqlQuery.execute();
			return true;
		}
		catch (any e) {
			writeOutput("Error");
		   writeDump(e); // have a look at the contents of this
		}
		return false;
	}

	function updateConsumable(updateStruct) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				UPDATE tbl_consumables 
				   SET name = :name, minimum_level = :minimum_level, maximum_level = :maximum_level, remarks = :remarks 
				 WHERE id = :id
			");
			sqlQuery.addParam(name="name", value=arguments.updateStruct.Name, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="minimum_level", value=arguments.updateStruct.MinimumLevel, CFSQLTYPE="CF_SQL_INTEGER");
			sqlQuery.addParam(name="maximum_level", value=arguments.updateStruct.MaximumLevel, CFSQLTYPE="CF_SQL_INTEGER");
			sqlQuery.addParam(name="remarks", value=arguments.updateStruct.Remarks, CFSQLTYPE="CF_SQL_LONGVARCHAR");
			sqlQuery.addParam(name="id", value=arguments.updateStruct.ID, CFSQLTYPE="CF_SQL_INTEGER");
			var resultset = sqlQuery.execute();
			return true;
		}
		catch (any e) {
			writeOutput("Error");
		   writeDump(e); // have a look at the contents of this
		}
	}

	function deleteConsumable(id) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				UPDATE tbl_consumables 
				   SET is_active = :is_active 
				 WHERE id = :id
			");
			sqlQuery.addParam(name="is_active", value="0", CFSQLTYPE="CF_SQL_INTEGER");
			sqlQuery.addParam(name="id", value=arguments.id, CFSQLTYPE="CF_SQL_INTEGER");
			var resultset = sqlQuery.execute();
			return true;
		}
		catch (any e) {
			writeOutput("Error");
		   writeDump(e); // have a look at the contents of this
		}
	}

	function createConsumableItem(createStruct) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				INSERT INTO tbl_consumables_items (description, action, quantity, date_recorded, remarks, fk_consumables_id)
				VALUES (:description, :action, :quantity, :date_recorded, :remarks, :fk_consumables_id)
			");
			sqlQuery.addParam(name="description", value=arguments.createStruct.description, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="action", value=arguments.createStruct.action, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="quantity", value=arguments.createStruct.quantity, CFSQLTYPE="CF_SQL_INTEGER");
			sqlQuery.addParam(name="date_recorded", value=arguments.createStruct.date_recorded, CFSQLTYPE="CF_SQL_DATE");
			sqlQuery.addParam(name="remarks", value=arguments.createStruct.remarks, CFSQLTYPE="CF_SQL_LONGVARCHAR");
			sqlQuery.addParam(name="fk_consumables_id", value=arguments.createStruct.fk_consumables_id, CFSQLTYPE="CF_SQL_INTEGER");
			var resultset = sqlQuery.execute();
			return true;
		}
		catch (any e) {
			writeOutput("Error");
		   writeDump(e); // have a look at the contents of this
		}
	}

	function updateConsumableItem(updateStruct) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				UPDATE tbl_consumables_items 
				   SET description = :description, action = :action, quantity = :quantity, date_recorded = :date_recorded, remarks = :remarks 
				 WHERE id = :id
			");
			sqlQuery.addParam(name="description", value=arguments.updateStruct.description, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="action", value=arguments.updateStruct.action, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="quantity", value=arguments.updateStruct.quantity, CFSQLTYPE="CF_SQL_INTEGER");
			sqlQuery.addParam(name="date_recorded", value=arguments.updateStruct.date_recorded, CFSQLTYPE="CF_SQL_DATE");
			sqlQuery.addParam(name="remarks", value=arguments.updateStruct.remarks, CFSQLTYPE="CF_SQL_LONGVARCHAR");
			sqlQuery.addParam(name="id", value=arguments.updateStruct.id, CFSQLTYPE="CF_SQL_INTEGER");
			var resultset = sqlQuery.execute();
			return true;
		}
		catch (any e) {
			writeOutput("Error");
		   writeDump(e); // have a look at the contents of this
		}
	}

	function deleteConsumableItem(id) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				UPDATE tbl_consumables_items 
				   SET is_active = :is_active 
				 WHERE id = :id
			");
			sqlQuery.addParam(name="is_active", value="0", CFSQLTYPE="CF_SQL_INTEGER");
			sqlQuery.addParam(name="id", value=arguments.id, CFSQLTYPE="CF_SQL_INTEGER");
			var resultset = sqlQuery.execute();
			return true;
		}
		catch (any e) {
			writeOutput("Error");
		   writeDump(e); // have a look at the contents of this
		}
	}
}