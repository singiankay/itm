component displayname="Login" output="false" persistent="true" hint="Login class" accessors="true" extends="itmanagement/com/config/Datasource"
{
	variables.attributes.DBNumber = 3;

	function init() {
		variables.instance.dsn = super.setDatasource(variables.attributes.DBNumber);
		return this;
	}

	function getDatasource() {
		variables.instance.dsn = super.setDatasource(variables.attributes.DBNumber);
		return variables.instance.dsn;
	}

	function getEMP33ByUsername(username) {
		var id = getLoginIDByUsername(arguments.username);
		if(id == false) {
			return false;
		}
		else {
			var emp33 = getLoginEMP33ByID(id);
			if(emp33 == false) {
				return false;
			}
			else {
				return emp33;
			}
		}
	}

	function getLoginEMP33ByID(id) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				SELECT Emp33 
				FROM tbl_login 
				WHERE ID = :id 
				LIMIT 1
			");
			sqlQuery.addParam(name="id", value=arguments.id, CFSQLTYPE="CF_SQL_INTEGER");
			var resultset = sqlQuery.execute().getResult();
			if(resultset.recordcount == 1) {
				for(var i=1; i<=resultset.recordcount; i++) {
					var Emp33 = resultset.Emp33;
					return Emp33;
				}
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

	function getLoginIDByUsername(username) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				SELECT ID 
				FROM tbl_login 
				WHERE username = :username 
				LIMIT 1
			");
			sqlQuery.addParam(name="username", value=arguments.username, CFSQLTYPE="CF_SQL_VARCHAR");
			var resultset = sqlQuery.execute().getResult();
			if (resultset.recordcount == 1) {
				for(var i=1; i<=resultset.recordcount; i++) {
					var id_record = resultset.ID;
					return id_record;
				}
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

	function comparePasswords(username, password) {
		if(hash(arguments.password,'sha') == getPasswordByUsername(arguments.username) ) {
			return true;
		}
		else {
			return false;
		}
	}

	function getPasswordByUsername(username) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				SELECT Password 
				FROM tbl_login 
				WHERE username = :username 
				LIMIT 1
			");
			sqlQuery.addParam(name="username", value=arguments.username, CFSQLTYPE="CF_SQL_VARCHAR");
			var resultset = sqlQuery.execute().getResult();
			if (resultset.recordcount == 1) {
				for(var i=1; i<=resultset.recordcount; i++) {
					var password = resultset.Password;
					return password;
				}
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

	function getLoginDataByID() {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				SELECT ID, Emp33, EmployeeID, Username, Password, password_2016, Email, Captcha, internal, myphone, mymobile, skype, Active, econtacts, date_saved, iseforms, isememo, isexternal  
				FROM tbl_login 
				WHERE ID = :id 
				LIMIT 1
			");
			sqlQuery.addParam(name="id", value=arguments.id, CFSQLTYPE="CF_SQL_INTEGER");
			var resultset = sqlQuery.execute().getResult();
			for(var i=1; i<=resultset.recordcount; i++) {
				var result = StructNew();
				result.ID = resultset.ID;
				result.Emp33 = resultset.Emp33;
				result.EmployeeID = resultset.EmployeeID;
				result.Username = resultset.Username;
				result.Password = resultset.Password;
				result.Password = resultset.Password;
				result.password_2016 = resultset.password_2016;
				result.Email = resultset.Email;
				result.Captcha = resultset.Captcha;
				result.internal = resultset.internal;
				result.myphone = resultset.myphone;
				result.mymobile = resultset.mymobile;
				result.skype = resultset.skype;
				result.Active = resultset.Active;
				result.econtacts = resultset.econtacts;
				result.econtacts = resultset.date_saved;
				result.econtacts = resultset.iseforms;
				result.econtacts = resultset.isememo;
				result.econtacts = resultset.isexternal;
			}

			return result;
					
		}
		catch (customExcp e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
	}

	function getLoginDataByUsername(username) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				SELECT ID, Emp33, EmployeeID, Username, Password, password_2016, Email, Captcha, internal, myphone, mymobile, skype, Active, econtacts, date_saved, iseforms, isememo, isexternal  
				FROM tbl_login 
				WHERE ID = :id 
				LIMIT 1
			");
			sqlQuery.addParam(name="id", value=arguments.id, CFSQLTYPE="CF_SQL_INTEGER");
			var resultset = sqlQuery.execute().getResult();
			for(var i=1; i<=resultset.recordcount; i++) {
				var result = StructNew();
				result.ID = resultset.ID;
				result.Emp33 = resultset.Emp33;
				result.EmployeeID = resultset.EmployeeID;
				result.Username = resultset.Username;
				result.Password = resultset.Password;
				result.Password = resultset.Password;
				result.password_2016 = resultset.password_2016;
				result.Email = resultset.Email;
				result.Captcha = resultset.Captcha;
				result.internal = resultset.internal;
				result.myphone = resultset.myphone;
				result.mymobile = resultset.mymobile;
				result.skype = resultset.skype;
				result.Active = resultset.Active;
				result.econtacts = resultset.econtacts;
				result.econtacts = resultset.date_saved;
				result.econtacts = resultset.iseforms;
				result.econtacts = resultset.isememo;
				result.econtacts = resultset.isexternal;
			}

			return result;
					
		}
		catch (customExcp e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
	}
}