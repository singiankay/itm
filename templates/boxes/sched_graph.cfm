
<cfoutput>
  <cfset listyear = "2017,2018,2019,2020">
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
            <td>

            </td>
            </tr>
          </table>
      </div>
    </h3>

  </div>
  <!-- /.box-header -->
  <div class="box-body" id="div_graph">
    
  </div>
  <!-- /.box-body -->
<!---   <div class="overlay" id="loadingSpinner">
    <i class="fa fa-refresh fa-spin"></i>
  </div> --->
</div>
<!-- /.box -->