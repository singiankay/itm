component displayname = "Validator" output = "false" hint = "Input Validator Class" accessors = "true" extends="Alerts"
{
	function init() {
		return this;
	}

	function validateDate(str) {
		if(isDate(arguments.str) == "No") {
			return super.setAlertMessage("Error", "Input Data is of Invalid Date Format.");
		}
		else {
			return true;
		}
	}

	function validateTime(str) {
		if(isDate(arguments.str) == "No") {
			return super.setAlertMessage("Error", "Input Data is of Invalid Time Format.");
		}
		else {
			return true;
		}
	}

	function validateIPAddress(str) {
		if(isValid("regex",arguments.str,"^(\d|[1-9]\d|1\d\d|2([0-4]\d|5[0-5]))\.(\d|[1-9]\d|1\d\d|2([0-4]\d|5[0-5]))\.(\d|[1-9]\d|1\d\d|2([0-4]\d|5[0-5]))\.(\d|[1-9]\d|1\d\d|2([0-4]\d|5[0-5]))$") == "No") {
			return super.setAlertMessage("Error", "Input Data is of Invalid IP Address Format.");
		}
		else {
			return true;
		}
	}

	function setEmptyString() {
		return "";
	}

	function setCheckboxValue(str="") {
		if(arguments.str == "on") {
			return 1;
		}
		else {
			return 0;
		}
	}
	function getCheckboxValue(status) {
		if(arguments.status == 1) {
			return "checked";
		}
		else {
			return "";
		}
	}

	function setEmptyStringCondition(str) {
		if(arguments.str == "") {
			return true;
		}
		else {
			return false;
		}
	}

	function setEmptyStringOrDate(str) {
		if (setEmptyStringCondition(arguments.str)== true) {
			return arguments.str;
		}
		else {
			return CreateODBCDateTime(arguments.str);
		}
	}
}