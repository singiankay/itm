/*
	Database Connection For IT Management
 */
component output="false" hint="Database Connection Settings" displayname="Datasource" accessors="true" persistent="true"
{
	property name="dsn";
	property name="itmanagement";
	property name="fixedasset";
	property name="login";
	property name="hris";

	variables.instance = {
		dsn="",
		itmanagement="itmanagement",
		fixedasset="fixedasset",
		login="login",
		hris="employee_db"
	};

	// variables.instance = {
	// 	Datasource = "",
	// 	itmanagement = "itmanagement",
	// 	fixedasset = "fixedasset",
	// 	login = "login",
	// 	hris = "employee_db"
	// };

	function init() {
		return this;
	}

	function setDatasource(dsn=1) {

		if(arguments.dsn == 1) {
			return variables.instance.itmanagement;
		}
		else if(arguments.dsn == 2) {
			return variables.instance.fixedasset;
		}
		else if(arguments.dsn == 3) {
			return variables.instance.login;
		}
		else if(arguments.dsn == 4) {
			return variables.instance.hris;
		}
		else {
			return false;
		}
	}
}