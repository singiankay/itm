component displayname = "Schedules" output = "false" hint = "Schedules class" accessors = "true" extends="itmanagement/com/config/Datasource"
{

	variables.attributes.DBNumber = 1;

	function init() {
		variables.instance.dsn = super.setDatasource(variables.attributes.DBNumber);
		return this;
	}

function getAllRecords(computer_group,sched_year) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				SELECT c.computer_name, c.computer_group, c.id_record
				FROM tbl_computer_copy c
				LEFT JOIN tbl_schedules s ON c.id_record = s.computer_id 
				WHERE c.is_active = 1
				AND c.computer_group = :computer_group 
				AND s.sched_year = :sched_year
			");
			sqlQuery.addParam(name="computer_group", value=arguments.computer_group, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="sched_year", value=arguments.sched_year, CFSQLTYPE="CF_SQL_VARCHAR");
			var resultset = sqlQuery.execute().getResult();
			return resultset;
		}
		catch (customExcp e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
	}

function getList(group) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				SELECT DISTINCT tbl_computer_copy.id_record
				FROM tbl_computer_copy 
				WHERE is_active = 1
				AND computer_group = :computer_group
				ORDER BY computer_name ASC
			");
			sqlQuery.addParam(name="computer_group", value=arguments.group, CFSQLTYPE="CF_SQL_VARCHAR");
			var resultset = sqlQuery.execute().getResult();
			result = valueList(resultset.id_record);
			return result;
		}
		catch (customExcp e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
}

function getScheduleRecord(computer_id) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				SELECT sched_date, sched_year, computer_id, performed_by, attachment, date_actual, week_no, id
				FROM tbl_schedules
				WHERE computer_id = :computer_id
			");
			sqlQuery.addParam(name="computer_id", value=arguments.computer_id, CFSQLTYPE="CF_SQL_VARCHAR");
			var resultset = sqlQuery.execute().getResult();
			return resultset;
		}
		catch (customExcp e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
}

function getListWithSchedule(group,year) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				SELECT DISTINCT tbl_computer_copy.id_record
				FROM tbl_computer_copy 
				WHERE is_active = 1
				AND computer_group = :computer_group
				ORDER BY computer_name ASC
			");
			sqlQuery.addParam(name="computer_group", value=arguments.group, CFSQLTYPE="CF_SQL_VARCHAR");
			var resultset = sqlQuery.execute().getResult();
			result = valueList(resultset.id_record);
			return result;
		}
		catch (customExcp e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
}

function GetDateByWeek(year,week) {
	result = StructNew();
	result.FirstDayOfYear = CreateDate(arguments.year,1,1);
	result.FirstDayOfCalendarYear = (result.FirstDayOfYear-DayOfWeek(result.FirstDayOfYear)+1);
	result.FirstDayOfWeek = (result.FirstDayOfCalendarYear+(arguments.week - 1) * 7);
	return DateFormat(result.FirstDayOfWeek, "mmmm dd, yyyy");
}

function getComputers(computer_group,sched_year) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				SELECT DISTINCT tbl_schedules.id as sched_id, computer_name, computer_group, id_record
				FROM tbl_computer_copy 
				LEFT JOIN tbl_schedules
				ON tbl_computer_copy.id_record = tbl_schedules.computer_id
				WHERE is_active = 1
				AND computer_group = :computer_group 
				ORDER BY -tbl_schedules.week_no DESC
			");
			sqlQuery.addParam(name="computer_group", value=arguments.computer_group, CFSQLTYPE="CF_SQL_VARCHAR");
			var resultset = sqlQuery.execute().getResult();
			return resultset;
		}
		catch (customExcp e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
	}


// function getForSchedule(computer_group) {
// 	  try {
// 			var sqlQuery = new Query();
// 			sqlQuery.setDatasource(variables.instance.dsn);
// 			sqlQuery.setSQL("
// 				SELECT computer_name, computer_group, id_record, week_no
// 				FROM tbl_computer_copy c 
// 				LEFT JOIN tbl_schedules s 
// 				ON s.computer_id = c.id_record
// 				WHERE c.is_active = 1
// 				AND c.computer_group = :computer_group
// 				AND s.week_no IS NULL
// 			");
// 			sqlQuery.addParam(name="computer_group", value=arguments.computer_group, CFSQLTYPE="CF_SQL_VARCHAR");
// 			var resultset = sqlQuery.execute().getResult();
// 			return resultset;
// 		}
// 		catch (customExcp e) {
// 		    writeOutput("Error");
// 		    writeDump(e); // have a look at the contents of this
// 		}
// }

function getForSchedule(list,computer_group) {
	  try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				SELECT computer_name, computer_group, id_record
				FROM tbl_computer_copy 
				WHERE is_active = 1
				AND FIND_IN_SET(id_record,:list) = 0
				AND computer_group = :computer_group
				ORDER BY computer_name ASC
			");
			sqlQuery.addParam(name="list", value=arguments.list, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="computer_group", value=arguments.computer_group, CFSQLTYPE="CF_SQL_VARCHAR");
			var resultset = sqlQuery.execute().getResult();
			return resultset;
		}
		catch (customExcp e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
}



function getForUpdating(year,computer_group) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				SELECT computer_name, computer_group, id_record, s.id as sched_id
				FROM tbl_computer_copy c
				LEFT JOIN tbl_schedules s
				ON s.computer_id = c.id_record
				WHERE is_active = 1
				AND sched_year = :year
				AND computer_group = :computer_group
				AND week_no IS NOT NULL
				AND date_actual IS NULL
				ORDER BY computer_name ASC
			");
			sqlQuery.addParam(name="year", value=arguments.year, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="computer_group", value=arguments.computer_group, CFSQLTYPE="CF_SQL_VARCHAR");
			var resultset = sqlQuery.execute().getResult();
			return resultset;
		}
		catch (customExcp e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
}

function getComputerByID(id) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				SELECT computer_name, id_record, computer_group
				FROM tbl_computer_copy
				WHERE is_active = 1
				AND id_record = :id 
			");
			sqlQuery.addParam(name="id", value=arguments.id, CFSQLTYPE="CF_SQL_VARCHAR");
			var resultset = sqlQuery.execute().getResult();
			return resultset;
		}
		catch (customExcp e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
	}


function getScheduleByComputer(computer_id,sched_year) {
	try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				SELECT id, week_no, sched_year, date_actual, performed_by, attachment, CONCAT(emp3,' ',emp2) as performer_name, sched_date
				FROM tbl_schedules LEFT JOIN
				hris.m_employee ON performed_by = emp33
				WHERE 1=1
				AND computer_id = :computer_id
				AND sched_year = :sched_year
				LIMIT 1
	 ");
			sqlQuery.addParam(name="computer_id", value=arguments.computer_id, CFSQLTYPE="CF_SQL_INTEGER");
			sqlQuery.addParam(name="sched_year", value=arguments.sched_year, CFSQLTYPE="CF_SQL_INTEGER");
			var resultset = sqlQuery.execute().getResult();
			return resultset;
		}
		catch (customExcp e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
}


function saveSched(computer_id,sched) {
	try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				INSERT INTO tbl_schedules
				(week_no,sched_year,sched_date,computer_id)
				VALUES
				(:week_no,:sched_year,:sched_date,:computer_id)
	 ");
			sqlQuery.addParam(name="week_no", value=arguments.sched.week_no, CFSQLTYPE="CF_SQL_INTEGER");
			sqlQuery.addParam(name="sched_year", value=arguments.sched.sched_year, CFSQLTYPE="CF_SQL_INTEGER");
			sqlQuery.addParam(name="sched_date", value=dateformat(arguments.sched.sched_date,"yyyy-mm-dd"), CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="computer_id", value=arguments.computer_id, CFSQLTYPE="CF_SQL_INTEGER");
			var resultset = sqlQuery.execute();
			// return resultset;
		}
		catch (customExcp e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}

}


function setActualDate(data) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				UPDATE tbl_schedules
					SET date_actual = :date_actual,
							performed_by = :performed_by,
							attachment = :attachment
				WHERE id = :id
	 ");
			sqlQuery.addParam(name="date_actual", value=arguments.data.date_actual, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="performed_by", value=arguments.data.performed_by, CFSQLTYPE="CF_SQL_INTEGER");
			sqlQuery.addParam(name="attachment", value=arguments.data.attachment, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="id", value=arguments.data.id, CFSQLTYPE="CF_SQL_INTEGER");
			var resultset = sqlQuery.execute();
			// return resultset;
		}
		catch (customExcp e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
}


function deleteComputer(id){
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				UPDATE tbl_computer_copy
					SET is_active = 0
					WHERE id_record = :id
	 ");
			sqlQuery.addParam(name="id", value=arguments.id, CFSQLTYPE="CF_SQL_INTEGER");
			var resultset = sqlQuery.execute();
			// return resultset;
		}
		catch (customExcp e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
}

function deleteSchedule(id) {
	try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
						DELETE FROM tbl_schedules WHERE id = :id

	 ");
			sqlQuery.addParam(name="id", value=arguments.id, CFSQLTYPE="CF_SQL_INTEGER");
			var resultset = sqlQuery.execute();
			// return resultset;
		}
		catch (customExcp e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
}

function checkComputer(id) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				SELECT computer_name
				  FROM tbl_computer_copy
				 WHERE computer_name = :id
	 ");
			sqlQuery.addParam(name="id", value=arguments.id, CFSQLTYPE="CF_SQL_VARCHAR");
			var resultset = sqlQuery.execute().getResult();
			return resultset;
		}
		catch (customExcp e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
}


function saveComputer(data) {
	try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				INSERT INTO tbl_computer_copy
				(computer_name, computer_group, is_active)
				VALUES
				(:computer_name,:computer_group,:is_active)
	 ");
			sqlQuery.addParam(name="computer_name", value=arguments.data.computer_name, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="computer_group", value=arguments.data.computer_group, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="is_active", value=arguments.data.is_active, CFSQLTYPE="CF_SQL_INTEGER");
			var resultset = sqlQuery.execute();
			// return resultset;
		}
		catch (customExcp e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
}

function getWeeks(year) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				SELECT week_no
				FROM tbl_schedules
				WHERE sched_year = :sched_year
				GROUP BY week_no
				ORDER BY week_no ASC
	 ");
			sqlQuery.addParam(name="sched_year", value=arguments.year, CFSQLTYPE="CF_SQL_INTEGER");
			var resultset = sqlQuery.execute().getResult();
			return resultset;
		}
		catch (customExcp e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
}

function getScheduleByWeek(week,year) {
	try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
				SELECT week_no, computer_id, date_actual, performed_by, a.attachment, b.computer_name
				FROM tbl_schedules a 
				LEFT JOIN tbl_computer_copy b
				ON a.computer_id = b.id_record
				WHERE a.week_no = :week_no
				AND a.sched_year = :year
				ORDER BY b.computer_name ASC
	 ");
			sqlQuery.addParam(name="week_no", value=arguments.week, CFSQLTYPE="CF_SQL_INTEGER");
			sqlQuery.addParam(name="year", value=arguments.year, CFSQLTYPE="CF_SQL_INTEGER");
			var resultset = sqlQuery.execute().getResult();
			return resultset;
		}
		catch (customExcp e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
}

function getCount(year) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
					SELECT 
					(
						SELECT count(id) FROM tbl_schedules WHERE date_actual IS NULL
						AND sched_year = :year
					) as unmaintained,

					(
						SELECT count(id) FROM tbl_schedules WHERE date_actual IS NOT NULL
						AND sched_year = :year
					) as maintained

					FROM tbl_schedules
					WHERE sched_year = :year
					LIMIT 1
	 ");
			sqlQuery.addParam(name="year", value=arguments.year, CFSQLTYPE="CF_SQL_INTEGER");
			var resultset = sqlQuery.execute().getResult();
			return resultset;
		}
		catch (customExcp e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
}

function getAnalysis(month,year) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
					SELECT *
					FROM tbl_analysis
					WHERE sched_year = :year
					AND sched_month = :month
					LIMIT 1
	 ");
			sqlQuery.addParam(name="year", value=arguments.year, CFSQLTYPE="CF_SQL_INTEGER");
			sqlQuery.addParam(name="month", value=arguments.month, CFSQLTYPE="CF_SQL_INTEGER");
			var resultset = sqlQuery.execute().getResult();
			return resultset;
		}
		catch (customExcp e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
}

function saveAnalysis(data) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
					INSERT INTO tbl_analysis
					(analysis, sched_month, sched_year)
					VALUES
					(:analysis, :month, :year)
	 ");
			sqlQuery.addParam(name="year", value=arguments.data.year, CFSQLTYPE="CF_SQL_INTEGER");
			sqlQuery.addParam(name="month", value=arguments.data.month, CFSQLTYPE="CF_SQL_INTEGER");
			sqlQuery.addParam(name="analysis", value=arguments.data.analysis, CFSQLTYPE="CF_SQL_VARCHAR");
			var resultset = sqlQuery.execute();
			return resultset;
		}
		catch (customExcp e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
}

function addToChecklist(year,computer_id) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
					INSERT INTO tbl_checklist
					(computer_id, year)
					VALUES
					(:computer_id, :year)
	 ");
			sqlQuery.addParam(name="year", value=arguments.year, CFSQLTYPE="CF_SQL_INTEGER");
			sqlQuery.addParam(name="computer_id", value=arguments.computer_id, CFSQLTYPE="CF_SQL_INTEGER");
			var resultset = sqlQuery.execute();
			return resultset;
		}
		catch (customExcp e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
}

function getChecklist(year,computer_id) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
					SELECT *
					FROM tbl_checklist
					WHERE year = :year
					AND computer_id = :computer_id
					LIMIT 1
	 ");
			sqlQuery.addParam(name="year", value=arguments.year, CFSQLTYPE="CF_SQL_INTEGER");
			sqlQuery.addParam(name="computer_id", value=arguments.computer_id, CFSQLTYPE="CF_SQL_INTEGER");
			var resultset = sqlQuery.execute().getResult();
			return resultset;
		}
		catch (customExcp e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
}


function updateChecklist(data) {
		try {
			var sqlQuery = new Query();
			sqlQuery.setDatasource(variables.instance.dsn);
			sqlQuery.setSQL("
					UPDATE tbl_checklist
						SET
							basic_ip = :basic_ip,
							basic_mac = :basic_mac,
							basic_remarks = :basic_remarks,
							a1_os_installed = :a1,
							a1_remarks = :a1_remarks,
							a2_updates_installed = :a2,
							a2_remarks = :a2_remarks,
							a3_kernel_reboot = :a3,
							a3_remarks = :a3_remarks,
							b_control_panel = :b,
							b_remarks = :b_remarks,
							c1_remote_console = :c1,
							c1_remarks = :c1_remarks,
							c2_remote_reboot = :c2,
							c2_remarks = :c2_remarks,
							c3_rescue_mode = :c3,
							c3_remarks = :c3_remarks,
							d1_resource_disk = :d1,
							d1_remarks = :d1_remarks,
							d2_resource_cpu = :d2,
							d2_remarks = :d2_remarks,
							d3_resource_ram = :d3,
							d3_remarks = :d3_remarks,
							d4_resource_network = :d4,
							d4_remarks = :d4_remarks,
							d5_resource_strain = :d5,
							d5_remarks = :d5_remarks,
							e_troubleshoot_cpu = :e,
							e_remarks = :e_remarks,
							f_troubleshoot_ram = :f,
							f_remarks = :f_remarks,
							g_troubleshoot_network = :g,
							g_remarks = :g_remarks,
							h_freeup_storage = :h,
							h_remarks = :h_remarks,
							i_backup_working = :i,
							i_remarks = :i_remarks,
							j1_user_old_emp = :j1,
							j1_remarks = :j1_remarks,
							j2_user_web_files = :j2,
							j2_remarks = :j2_remarks,
							j3_user_data = :j3,
							j3_remarks = :j3_remarks,
							k_malware_scan = :k,
							k_remarks = :k_remarks,
							l_change_password = :l,
							l_remarks = :l_remarks,
							m1_raid_disk = :m1,
							m1_remarks = :m1_remarks,
							m2_raid_driver = :m2,
							m2_remarks = :m2_remarks,
							m3_raid_consistency = :m3,
							m3_remarks = :m3_remarks,
							m4_raid_replace = :m4,
							m4_remarks = :m4_remarks,
							n1_cable_secure = :n1,
							n1_remarks = :n1_remarks,
							n2_twisted = :n2,
							n2_remarks = :n2_remarks,
							n3_condition = :n3,
							n3_remarks = :n3_remarks
				WHERE computer_id = :computer_id 
				AND year = :year

	 ");
			sqlQuery.addParam(name="year", value=arguments.data.year, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="computer_id", value=arguments.data.computer_id, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="basic_mac", value=arguments.data.basic_mac, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="basic_ip", value=arguments.data.basic_ip, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="basic_remarks", value=arguments.data.basic_remarks, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="a1_remarks", value=arguments.data.a1_remarks, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="a2_remarks", value=arguments.data.a2_remarks, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="a3_remarks", value=arguments.data.a3_remarks, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="b_remarks", value=arguments.data.b_remarks, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="c1_remarks", value=arguments.data.c1_remarks, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="c2_remarks", value=arguments.data.c2_remarks, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="c3_remarks", value=arguments.data.c3_remarks, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="d1_remarks", value=arguments.data.d1_remarks, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="d2_remarks", value=arguments.data.d2_remarks, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="d3_remarks", value=arguments.data.d3_remarks, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="d4_remarks", value=arguments.data.d4_remarks, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="d5_remarks", value=arguments.data.d5_remarks, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="e_remarks", value=arguments.data.e_remarks, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="f_remarks", value=arguments.data.f_remarks, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="g_remarks", value=arguments.data.g_remarks, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="h_remarks", value=arguments.data.h_remarks, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="i_remarks", value=arguments.data.i_remarks, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="j1_remarks", value=arguments.data.j1_remarks, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="j2_remarks", value=arguments.data.j2_remarks, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="j3_remarks", value=arguments.data.j3_remarks, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="k_remarks", value=arguments.data.k_remarks, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="l_remarks", value=arguments.data.l_remarks, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="m1_remarks", value=arguments.data.m1_remarks, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="m2_remarks", value=arguments.data.m2_remarks, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="m3_remarks", value=arguments.data.m3_remarks, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="m4_remarks", value=arguments.data.m4_remarks, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="n1_remarks", value=arguments.data.n1_remarks, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="n2_remarks", value=arguments.data.n2_remarks, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="n3_remarks", value=arguments.data.n3_remarks, CFSQLTYPE="CF_SQL_VARCHAR");

			sqlQuery.addParam(name="a1", value=arguments.data.a1, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="a2", value=arguments.data.a2, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="a3", value=arguments.data.a3, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="b", value=arguments.data.b, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="c1", value=arguments.data.c1, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="c2", value=arguments.data.c2, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="c3", value=arguments.data.c3, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="d1", value=arguments.data.d1, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="d2", value=arguments.data.d2, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="d3", value=arguments.data.d3, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="d4", value=arguments.data.d4, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="d5", value=arguments.data.d5, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="e", value=arguments.data.e, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="f", value=arguments.data.f, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="g", value=arguments.data.g, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="h", value=arguments.data.h, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="i", value=arguments.data.i, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="j1", value=arguments.data.j1, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="j2", value=arguments.data.j2, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="j3", value=arguments.data.j3, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="k", value=arguments.data.k, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="l", value=arguments.data.l, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="m1", value=arguments.data.m1, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="m2", value=arguments.data.m2, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="m3", value=arguments.data.m3, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="m4", value=arguments.data.m4, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="n1", value=arguments.data.n1, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="n2", value=arguments.data.n2, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.addParam(name="n3", value=arguments.data.n3, CFSQLTYPE="CF_SQL_VARCHAR");
			sqlQuery.execute();
		}
		catch (customExcp e) {
		    writeOutput("Error");
		    writeDump(e); // have a look at the contents of this
		}
}




}