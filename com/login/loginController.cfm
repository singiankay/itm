<cfif structKeyExists(URL, "Redirect")>
  <cfset Redirect = URL.Redirect />
<cfelse>
  <cfset Redirect = "" />
</cfif>
<cfif structKeyExists(URL, "logout")>
  <cfif URL.logout EQ true>
    <cfset structClear(session) />
  </cfif>
</cfif>
<cfif structKeyExists(Session, "loggedin" )>
  <cfif Session.loggedin EQ true>
    <cflocation url="index.cfm" addtoken=false />
  </cfif>
</cfif>
<cfscript>
  if(structKeyExists(FORM, "submitLogin")) {
    RedirectToPage = FORM.urlRedirect;
    Username = FORM.Username;
    Password = FORM.Password;
    allowedPositionArray = objHRIS.getAllowedPosition();
    EMP33 = objLogin.getEMP33ByUsername(FORM.Username);
    if(EMP33 == false) {
      Alert = objAlerts.setAlertMessage("Error", "Username not found");
    }
    else {
      if(objLogin.comparePasswords(Username,Password) == true) {
        isAllowed = false;
        Login = objHRIS.getEmployeeLoginByemp33(EMP33);
        if(arrayContains(allowedPositionArray, Login.EMP37) == "YES") {
          isAllowed = true;
        }
        if(isAllowed == true) {
          lock scope="Session" timeout="1800" type="exclusive" {
            session.loggedin = true;
            session.username = FORM.username;
            session.lastname =  Login.EMP2;
            session.firstname =  Login.EMP3;
            session.middlename =  Login.EMP4;
            session.position =  Login.EMP5;
            session.datehired =  Login.EMP6;
            session.loginid = Login.EMP33;
            if(Login.EMP23 == "") {
              session.Picture = "http://npi-appserver/employee/econtacts/img/void.png";
            }
            else {
              session.Picture = "http://npi-appserver/employee/personnel/"&Login.EMP23;
            }
          }
          if(CompareNoCase(RedirectToPage, "") == 0) {
            // location(url="index.cfm",addtoken=false);
            location(url="computers.cfm",addtoken=false);
          }
          else {
            // location(url=RedirectToPage,addtoken=false);
            location(url="computers.cfm",addtoken=false);
          }
        }
        else {
          Alert = objAlerts.setAlertMessage("Error", "You are not authorized to access this application!");
        }
      }
      else {
        Alert = objAlerts.setAlertMessage("Error", "Password does not match");
      }
    }
  }
</cfscript>