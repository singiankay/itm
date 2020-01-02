component displayname = "HRIS" output = "false" hint = "HRIS class" accessors = "true" extends="itmanagement/com/config/Datasource"
{

	variables.attributes.DBNumber = 4;

	EmployeeMIS = [13,14,38,57,83];
	// EmployeeMIS = [13];


	function init() {
		variables.instance.dsn = super.setDatasource(variables.attributes.DBNumber);
		return this;
	}

	function getDatasource() {
		variables.instance.dsn = super.setDatasource(variables.attributes.DBNumber);
		return variables.instance.dsn;
	}

	function getAllowedPosition() {
		return EmployeeMIS;
	}

	function getEmployeeLoginByemp33(EMP33) {
		
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				SELECT EMP33, EMP37, EMP2, EMP3, EMP4, EMP5, EMP6, EMP23 
				FROM m_employee 
				WHERE EMP33 = :EMP33 
				LIMIT 1
			");
			sqlQuery.addParam(name="EMP33", value=arguments.EMP33, CFSQLTYPE="CF_SQL_INTEGER");
			var resultset = sqlQuery.execute().getResult();
			for(var i=1; i<=resultset.recordcount; i++) {
				var result = StructNew();
				result.EMP33 = resultset.EMP33;
				result.EMP37 = resultset.EMP37;
				result.EMP2 = resultset.EMP2;
				result.EMP3 = resultset.EMP3;
				result.EMP4 = resultset.EMP4;
				result.EMP5 = resultset.EMP5;
				result.EMP6 = resultset.EMP6;
				result.EMP23 = resultset.EMP23;
			}
			return result;		
		}
		catch (customExcp e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
	}

	/*
	 *	RETURNS m_employee table
	 * 
	 * Tablecolumns
	 * 	EMP0 = ID
	 *  	EMP33 = ID_INTEGER
	 *   	EMP35 = eFORMS
	 *    EMP1 = EMPLOYEE NUMBER
	 *    EMP2 = LAST NAME
	 *    EMP3 = FIRSTNAME
	 *    EMP4 = MIDDLENAME
	 *    EMP5 = POSITION
	 *    EMP5_ID = POSITION IDRECORD
	 *    EMP29 = COURSE
	 *    EMP6 = DATE HIRED
	 *    EMP7 = EMPLOYEE STATUS ID
	 *    EMP8 = SBMA ID TYPE ID
	 *    EMP9 = SBMA EXPIRATION DATE
	 *    EMP10 = BIRTHDATE
	 *    EMP11 = GENDER
	 *    EMP12 = BLOOD TYPE ID
	 *    EMP13 = CONTACT NUMBER
	 *    EMP14 = MARITAL STATUS ID
	 *    EMP15 = ADDRESS
	 *    EMP16 = CONTACT PERSON
	 *    EMP17 = CONTACT NUMBER
	 *    EMP18 = EMERGENCY ADDRESS
	 *    EMP19 = TIN#
	 *    EMP20 = SS #
	 *    EMP21 = PHILHEALTH
	 *    EMP22 = PAGIBIG
	 *    EMP23 = IMAGE Path
	 *    EMP24 = DEPARTMENT ID
	 *    EMP25 = UPDATE DATE
	 *    EMP26 = ENCODER
	 *    EMP27 = ACTIVE/INACTIVE
	 *    EMP28 = ENDO
	 *    EMP30
	 *    EMP31
	 *    EMP32
	 *    EMP34
	 *    EMP36
	 *    EMP37 = position id
	 *    EMP38 = SECTION ID
	 *    EMP39 = Not Viewable on HRIS
	 *    EMP40 = Job Grade
	 *    EMP41 = Building
	 *    EMP42 = Area
	 *    EMP43 = Location
	 *    EMP44 = Contact 2
	 *
	 * PARAMS
	 * 	@EMP33 - Foreign Key
	 */
	
	function getMEmployeeDataByEMP33(EMP33) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				SELECT EMP0, EMP33, EMP35, EMP1, EMP2, EMP3, EMP4, EMP5, EMP5_ID, EMP29, EMP6, EMP7, EMP8, EMP9, EMP10, EMP11, EMP12, EMP13, EMP14, EMP15, EMP16, EMP17, EMP18, EMP19, EMP20, EMP21, EMP22, EMP23, EMP24, EMP25, EMP26, EMP27, EMP28, EMP30, EMP31, EMP32, EMP34, EMP36, EMP37,EMP38, EMP39, EMP40, EMP41, EMP42, EMP43, EMP44 
				FROM m_employee 
				WHERE EMP33 = :EMP33 
				LIMIT 1
			");
			sqlQuery.addParam(name="id", value=arguments.id, CFSQLTYPE="CF_SQL_INTEGER");
			var resultset = sqlQuery.execute().getResult();
			for(var i=1; i<=resultset.recordcount; i++) {
				var result = StructNew();

				result.EMP0 = resultset.EMP0;
				result.EMP33 = resultset.EMP33;
				result.EMP35 = resultset.EMP35;
				result.EMP1 = resultset.EMP1;
				result.EMP2 = resultset.EMP2;
				result.EMP3 = resultset.EMP3;
				result.EMP4 = resultset.EMP4;
				result.EMP5 = resultset.EMP5;
				result.EMP5_ID = resultset.EMP5_ID;
				result.EMP29 = resultset.EMP29;
				result.EMP6 = resultset.EMP6;
				result.EMP7 = resultset.EMP7;
				result.EMP8 = resultset.EMP8;
				result.EMP9 = resultset.EMP9;
				result.EMP10 = resultset.EMP10;
				result.EMP11 = resultset.EMP11;
				result.EMP12 = resultset.EMP12;
				result.EMP13 = resultset.EMP13;
				result.EMP14 = resultset.EMP14;
				result.EMP15 = resultset.EMP15;
				result.EMP16 = resultset.EMP16;
				result.EMP17 = resultset.EMP17;
				result.EMP18 = resultset.EMP18;
				result.EMP19 = resultset.EMP19;
				result.EMP20 = resultset.EMP20;
				result.EMP21 = resultset.EMP21;
				result.EMP22 = resultset.EMP22;
				result.EMP23 = resultset.EMP23;
				result.EMP24 = resultset.EMP24;
				result.EMP25 = resultset.EMP25;
				result.EMP26 = resultset.EMP26;
				result.EMP27 = resultset.EMP27;
				result.EMP28 = resultset.EMP28;
				result.EMP29 = resultset.EMP29;
				result.EMP30 = resultset.EMP30;
				result.EMP31 = resultset.EMP31;
				result.EMP32 = resultset.EMP32;
				result.EMP34 = resultset.EMP34;
				result.EMP36 = resultset.EMP36;
				result.EMP37 = resultset.EMP37;
				result.EMP38 = resultset.EMP38;
				result.EMP39 = resultset.EMP39;
				result.EMP40 = resultset.EMP40;
				result.EMP41 = resultset.EMP41;
				result.EMP42 = resultset.EMP42;
				result.EMP43 = resultset.EMP43;
				result.EMP44 = resultset.EMP44;
			}

			return result;
					
		}
		catch (customExcp e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
	}
}