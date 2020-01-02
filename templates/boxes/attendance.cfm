
<cfoutput>
  <cfset listyear = "2017,2018,2019,2020">


<div class="box">
  <div class="box-header">
    <h3 class="box-title">

    </h3>
      <div class="col-lg-2">
        <select class="form-control" id="slcYear">
            <cfloop from="2017" to="#year(now())#" index="year">
                <cfoutput><option value="#year#" #year eq url.year? 'selected' : ''# >#year#</option></cfoutput>
            </cfloop>
          </select>
      </div>
      <div class="col-lg-3">
        <button type="button" class="btn btn-primary" onclick="updateAttendance(#url.year#)">Update</button>
      </div>    

  </div>
  <!-- /.box-header -->
  <div class="box-body">
    <div id="div-attendance">
      
    </div>
  </div>
  <!-- /.box-body -->
  <div class="overlay" id="loadingSpinner">
    <i class="fa fa-refresh fa-spin"></i>
  </div>
</div>
<!-- /.box -->


</cfoutput>