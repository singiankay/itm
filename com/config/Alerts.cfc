component displayname = "Alerts" output = "false" hint = "Alert Class" accessors = "true"
{
	function init() {
		return this;
	}

	function setAlertMessage(alertType , alertMessage) {
		if(arguments.alertType == "Success") {
			return setSuccessMessage(arguments.alertMessage);
		}
		else if(arguments.alertType == "Warning") {
			return setWarningMessage(arguments.alertMessage);
		}
		else if(arguments.alertType == "Error") {
			return setErrorMessage(arguments.alertMessage);
		}
		else if(arguments.alertType == "Info") {
			return setInfoMessage(arguments.alertMessage);
		}
		else {
			return "";
		}
	}

	function setSuccessMessage(alertMessage) {
		var Message = '<div class="alert alert-success alert-dismissible"><button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button><h4><i class="icon fa fa-check"></i> Success!</h4>'&arguments.alertMessage&'</div>';
		return Message;
	}

	function setWarningMessage(alertMessage) {
		var Message = '<div class="alert alert-warning alert-dismissible"><button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button><h4><i class="icon fa fa-warning"></i> Alert!</h4>'&arguments.alertMessage&'</div>';
		return Message;
	}

	function setErrorMessage(alertMessage) {
		var Message = '<div class="alert alert-danger alert-dismissible"><button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button><h4><i class="icon fa fa-ban"></i> Error!</h4>'&arguments.alertMessage&'</div>';
		return Message;
	}

	function setInfoMessage(alertMessage) {
		var Message = '<div class="alert alert-info alert-dismissible"><button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button><h4><i class="icon fa fa-info"></i> Alert!</h4>'&arguments.alertMessage&'</div>';
		return Message;
	}
}