component displayname = "ITManagementValidator" output = "false" hint = "IT Management Validator Class" accessors = "true" extends="Validator"
{
	function init() {
		return this;
	}

	function validateComputer(IPAddress, DateIssued, DateDestroyed, DateStocked) {
		if(super.setEmptyStringCondition(arguments.IPAddress) != true) {
			if(super.validateIPAddress(arguments.IPAddress) == true) {
				return validateComputer2(arguments.DateIssued, arguments.DateDestroyed, arguments.DateStocked);
			}
			else {
				return super.validateIpAddress(arguments.IPAddress);
			}
		}
		else {
			return validateComputer2(arguments.DateIssued, arguments.DateDestroyed, arguments.DateStocked);
		}
	}

	function validateComputer2(DateIssued, DateDestroyed, DateStocked) {
		if(setEmptyStringCondition(arguments.DateIssued) != true) {
			if(super.validateDate(arguments.DateIssued) == true) {
				return validateComputer3(arguments.DateDestroyed, arguments.DateStocked);
			}
			else {
				return super.validateDate(arguments.DateIssued);
			}
		}
		else {
			return validateComputer3(arguments.DateDestroyed, arguments.DateStocked);
		}

	}

	function validateComputer3(DateDestroyed, DateStocked) {
		if(super.setEmptyStringCondition(arguments.DateDestroyed) != true) {
			if(super.validateDate(arguments.DateDestroyed) == true) {
				return validateComputer4(arguments.DateStocked);
			}
			else {
				return super.validateDate(arguments.DateDestroyed);
			}
		}
		else {
			return validateComputer4(arguments.DateStocked);
		}
	}

	function validateComputer4(DateStocked) {
		if(super.setEmptyStringCondition(arguments.DateStocked) != true) {
			if(super.validateDate(arguments.DateStocked) == true) {
				return true;
			}
			else {
				return super.validateDate(arguments.DateStocked);
			}
		}
		else {
			return true;
		}
	}

	function validateEquipment(DateIssued, DateDestroyed, DateStocked) {
		return validateComputer2(arguments.DateIssued,arguments.DateDestroyed, arguments.DateStocked);
	}

	function validateOthers(DateIssued, DateDestroyed, DateStocked) {
		return validateComputer2(arguments.DateIssued,arguments.DateDestroyed, arguments.DateStocked);
	}

	function validateHistory(HistoryDate, HistoryTime) {
		if(super.validateDate(arguments.HistoryDate) == true) {
			if(super.validateTime(arguments.HistoryTime) == true) {
				return true;
			}
			else {
				return super.validateTime(arguments.HistoryTime);
			}
		}
		else {
			return super.validateDate(arguments.HistoryDate);
		}
	}

	function validateConsumables(name, minimum_level, maximum_level, remarks) {
		if(super.setEmptyStringCondition(name) == true) {
			
		}
	}
}