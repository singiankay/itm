<div class="content-wrapper">
  <section class="content-header">
    <h1>Import Manager</h1>
  </section>
  <section class="content">
    <div id="alertContent" class="row">
      <div class="col-xs-12">
        <cfoutput>#Alert#</cfoutput>
      </div>
    </div>
    <div class="row">
      <div class="col-md-12">
        <div class="box box-primary">
          <div class="box-header with-border">
            <h3 class="box-title">Import Computers</h3>
          </div>
          <form role="form" method="POST" enctype="multipart/form-data">
            <div class="box-body">
              <div class="form-group">
                <label for="importFileComputer">Import CSV/XLSX</label>
                <input type="file" accept=".csv" name="importFileComputer" id="importFileComputer">
              </div>
              <div class="btn-group form-group">
                <input type="reset" class="btn btn-success" value="Reset" id="resetImportComputer">
                <input type="button" class="btn btn-warning" name="verifyComputer" id="verifyImportComputer" value="Verify">
                <!--- <input type="button" id="uploadImportComputer" class="btn btn-primary" name="uploadImportComputer" value="Upload"> --->
                <input type="button" id="uploadImportComputer" class="btn btn-primary disabled" name="uploadImportComputer" value="Upload" disabled="disabled">
              </div>
              <div>
                <h3>Staging Table</h3>
                <ul>
                  <li>
                    <p><span class="text-blue">Verify</span> - inspects the data to be imported. Errors will be listed. Upload button will not be enabled unless all errors are cleared</p>
                  </li>
                  <li>
                    <p><span class="text-blue">Upload</span> - uploads the verified data to the database. Status of the import process will be shown.</p>
                  </li>
                </ul>
                <table id="importComputerTable" class="table table-condensed table-bordered table-hover table-striped nowrap">
                  <thead>
                    <tr>
                      <th>Asset ID</th>
                      <th>Asset Tag</th>
                      <th>Type</th>
                      <th>Computer Name</th>
                      <th>IP Address</th>
                      <th>Processor</th>
                      <th>Memory</th>
                      <th>Operating System</th>
                      <th>Office</th>
                      <th>Graphics Card</th>
                      <th>Date Issued</th>
                      <th>Remarks</th>
                      <th>Is Active</th>
                      <th>Status</th>
                    </tr>
                  </thead>
                  <tbody id="importComputerTableBody"></tbody>
                </table>
              </div>
              <div>
                <p>Errors: <span class="text-red" id="importErrorCounter">0</span></p>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
  </section>
</div>
<!--- <cfinclude template="../forms/form_equipmentmodal.cfm"> --->