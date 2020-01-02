
<cfoutput>
  <cfset listyear = "2017,2018,2019,2020">

  <cfquery name="getGroups" datasource="itmanagement">
    SELECT group_name FROM tbl_computer_group WHERE active = 1
  </cfquery>
</cfoutput>

<div class="box">
  <div class="box-header">
    <h3 class="box-title">
      <div class="col-lg-12">
          <table class="table">
            <tr>
              <td>Year:</td>
              <td><select class="form-control sched_param" id="slcYear">
                <cfloop from="2017" to="#year(now())#" index="year">
                    <cfoutput><option value="#year#" #year eq url.year? 'selected' : ''# >#year#</option></cfoutput>
                </cfloop>
              </select></td>
              <td>Group:</td>
              <td><select class="form-control sched_param" id="slcGroup">
                <cfoutput query="getGroups">
                    <option value="#getGroups.group_name#" <cfif getGroups.group_name eq url.group> selected </cfif>>#getGroups.group_name#</option>
                </cfoutput>
              </select>
            </td>
            <td>
              <button class="btn btn-primary"  type="button" data-toggle="modal" data-target="#addComputerModal" ><i class="fa fa-tv"></i> Add Computer</button>
            </td>
            <td>
              <button type="button" class="btn btn-block btn-danger" onclick="multipleDelete()"><i class="fa fa-trash"></i> Delete Selected</button>
            </td>
            <td>
              <cfif URL.group neq 'SERVER'>
                 <button type="button" class="btn btn-block bg-purple" onclick="updateMultipleSched($('#slcYear').val(),$('#slcGroup').val())"><i class="fa fa-calendar-check-o"></i>  Multiple Schedule</button>
              </cfif>
            </td>

            <td>
               <!--- <button type="button" class="btn btn-block btn-success" onclick="updateMultipleActual($('#slcYear').val(),$('#slcGroup').val())"><i class="fa fa-edit"></i>  Multiple Update</button> --->
<!---                 <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-eye"></i> View </span>
                    <select class="form-control">
                      <option value="1">Main Schedule</option>
                      <option value="2">Summary</option>
                      <option value="3">Charts</option>
                    </select>
                </div> --->
            </td>



<!---       <div class="col-lg-2">
     
      </div>
      <div class="col-lg-2">
       
      </div> --->

            </tr>
          </table>

      </div>
    </h3>

  </div>
  <!-- /.box-header -->
  <div class="box-body">
    <table id="Schedules" class="table table-bordered table-hover" style="cursor:pointer">
      <thead>
      <tr>
        <th style="width: 80px"></th>
        <th>Computer Name</th>
        <th>Schedule</th>
        <th>Actual Date of Maintenance</th>
        <th>Performed By</th>
        <th>Attachment</th>      
      </tr>
      </thead>
      <tbody data-link="row" class="rowlink" id="scheduleRecords"></tbody>
      <tfoot>
      <tr>
        <th></th>
        <th>Computer Name</th>
        <th>Schedule</th>
        <th>Actual Date of Maintenance</th>
        <th>Performed By</th>
        <th>Attachment</th>  
      </tr>
      </tfoot>
    </table>
  </div>
  <!-- /.box-body -->
  <div class="overlay" id="loadingSpinner">
    <i class="fa fa-refresh fa-spin"></i>
  </div>
</div>
<!-- /.box -->