<!-- Left side column. contains the logo and sidebar -->
<aside class="main-sidebar">

  <!-- sidebar: style can be found in sidebar.less -->
  <section class="sidebar">

    <!-- Sidebar user panel (optional) -->
    <div class="user-panel">
      <div class="pull-left image">
        <img src="<cfoutput>#Session.picture#</cfoutput>" class="img-circle" alt="User Image">
      </div>
      <div class="pull-left info">
        <cfoutput><p>#Session.username#</p></cfoutput>
        <p class="text-green">Welcome!</p>
<!---         <a href="#"><i class="fa fa-circle text-success"></i> Online</a> --->
      </div>
    </div>

    <!-- Sidebar Menu -->
    <ul class="sidebar-menu">
      <li class="header">NAVIGATION</li>
      <!-- Optionally, you can add icons to the links -->
      <cfif listlast(cgi.script_name,"/") EQ "index.cfm">
        <li class="active"><a href="./index.cfm"><i class="fa fa-database"></i> <span>Asset Records</span></a></li>
      <cfelse>
        <li><a href="./index.cfm"><i class="fa fa-database"></i> <span>Asset Records</span></a></li>
      </cfif>
      <cfif listlast(cgi.script_name, "/") EQ "computers.cfm">
        <li class="active"><a href="computers.cfm"><i class="fa fa-laptop"></i> <span>Computers</span></a></li>
      <cfelse>
        <li><a href="computers.cfm" ><i class="fa fa-laptop"></i> <span>Computers</span></a></li>
      </cfif>
      <cfif listlast(cgi.script_name, "/") EQ "equipment.cfm">
        <li class="active"><a href="equipment.cfm"><i class="fa fa-wrench"></i> <span>Equipment</span></a></li>
      <cfelse>
        <li><a href="equipment.cfm"><i class="fa fa-wrench"></i> <span>Equipment</span></a></li>
      </cfif>
      <cfif listlast(cgi.script_name, "/") EQ "others.cfm">
        <li class="active"><a href="others.cfm"><i class="fa fa-ellipsis-h"></i> <span>Others</span></a></li>
      <cfelse>
        <li><a href="others.cfm"><i class="fa fa-ellipsis-h"></i> <span>Others</span></a></li>
      </cfif>
      <cfif listlast(cgi.script_name, "/") EQ "consumables.cfm" OR listlast(cgi.script_name, "/") EQ "consumables-config.cfm">
        <!--- <li class="active"><a href="consumables.cfm"><i class="fa fa-shopping-cart"></i> <span>Consumables</span></a></li> --->
        <li class="treeview active">
          <a href="#"><i class="fa fa-shopping-cart"></i> <span>Consumables</span>
                <span class="pull-right-container">
                  <i class="fa fa-angle-left pull-right"></i>
                </span>
              </a>
          <ul class="treeview-menu">
            <cfif listlast(cgi.script_name, "/") EQ "consumables.cfm">
              <li class="active"><a href="consumables.cfm">Report</a></li>
            <cfelse>
              <li><a href="consumables.cfm">Report</a></li>
            </cfif>
            <cfif listlast(cgi.script_name, "/") EQ "consumables-config.cfm">
              <li class="active"><a href="consumables-config.cfm">Configuration</a></li>
            <cfelse>
              <li><a href="consumables-config.cfm">Configuration</a></li>
            </cfif>
          </ul>
        </li>
      <cfelse>
        <li class="treeview">
          <a href="#"><i class="fa fa-shopping-cart"></i> <span>Consumables</span>
                <span class="pull-right-container">
                  <i class="fa fa-angle-left pull-right"></i>
                </span>
              </a>
          <ul class="treeview-menu">
            <li><a href="consumables.cfm">Report</a></li>
            <li><a href="consumables-config.cfm">Configuration</a></li>
          </ul>
        </li>
        <!--- <li><a href="consumables.cfm"><i class="fa fa-shopping-cart"></i> <span>Consumables</span></a></li> --->
      </cfif>
      <cfif listlast(cgi.script_name, "/") EQ "import.cfm">
        <li class="active"><a href="import.cfm"><i class="fa fa-upload"></i> <span>Import</span></a></li>
      <cfelse>
        <li><a href="import.cfm"><i class="fa fa-upload"></i> <span>Import</span></a></li>
      </cfif>

<!---       <cfif listlast(cgi.script_name, "/") EQ "schedule.cfm">
        <li class="active"><a href="schedule.cfm?year=<cfoutput>#year(now())#</cfoutput>&group=MD"><i class="fa  fa-calendar"></i> <span>Schedule</span></a></li>
      <cfelse>
        <li><a href="schedule.cfm?year=<cfoutput>#year(now())#</cfoutput>&group=MD"><i class="fa  fa-calendar"></i> <span>Schedule</span></a></li>
      </cfif> --->

      <li 
          <cfif listlast(cgi.script_name, "/") EQ "schedule.cfm" OR listlast(cgi.script_name, "/") EQ "sched_summary.cfm" OR listlast(cgi.script_name, "/") EQ "sched_graph.cfm"> 
          class="treeview active"
          <cfelse>
          class="treeview"
          </cfif>
        
      >
          <a href="#"><i class="fa fa-calendar"></i> <span>Annual Maintenance</span>
                <span class="pull-right-container">
                  <i class="fa fa-angle-left pull-right"></i>
                </span>
              </a>
          <ul class="treeview-menu">
              <li <cfif listlast(cgi.script_name, "/") EQ "schedule.cfm"> class="active" </cfif> ><a href="schedule.cfm?year=<cfoutput>#year(now())#</cfoutput>&group=MD">Records</a></li>
              <li <cfif listlast(cgi.script_name, "/") EQ "sched_summary.cfm"> class="active" </cfif> ><a href="sched_summary.cfm?year=<cfoutput>#year(now())#</cfoutput>">Plan</a></li>
              <li <cfif listlast(cgi.script_name, "/") EQ "sched_graph.cfm"> class="active" </cfif> ><a href="sched_graph.cfm?year=<cfoutput>#year(now())#</cfoutput>">Summary</a></li>
          </ul>
      </li>

      <cfif listlast(cgi.script_name, "/") EQ "attendance.cfm">
        <li class="active"><a href="attendance.cfm?year=<cfoutput>#year(now())#</cfoutput>"><i class="fa  fa-calendar-check-o"></i> <span>Attendance</span></a></li>
      <cfelse>
        <li><a href="attendance.cfm?year=<cfoutput>#year(now())#</cfoutput>"><i class="fa  fa-calendar-check-o"></i> <span>Attendance</span></a></li>
      </cfif>      


    </ul>
    <!-- /.sidebar-menu -->
  </section>
  <!-- /.sidebar -->
</aside>