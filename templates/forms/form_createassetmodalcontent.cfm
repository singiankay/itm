 <div class="box-body">
	<CFIF structKeyExists(url, "option") and url.option EQ "Computer">
		<div class="form-group">
	  	<div class="col-sm-offset-3 col-sm-9">
		    <div class="checkbox">
	        <label><input type="checkbox" name="isActive" class="flat-red">&nbsp;Is Active?</label>
	      </div>
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="ComputerType" class="col-sm-3 control-label">Computer Type&#42;</label>
	    <div class="col-sm-9">
	      <input type="text" class="form-control" id="ComputerType" name="ComputerType" placeholder="Computer Type" maxlength="50" required="required">
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="ComputerName" class="col-sm-3 control-label">Computer Name&#42;</label>
	    <div class="col-sm-9">
	      <input type="text" class="form-control" id="ComputerName" name="ComputerName" placeholder="Computer Name" maxlength="50" required="required">
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="IPAddress" class="col-sm-3 control-label">IP Address</label>
	    <div class="col-sm-4">
	        <div class="input-group">
	          <div class="input-group-addon">
	            <i class="fa fa-laptop"></i>
	          </div>
	          <input type="text" class="form-control" id="IPAdress" name="IPAddress" data-inputmask="'alias': 'ip'" data-mask id="IPAddress">
	        </div>
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="ComputerProcessor" class="col-sm-3 control-label">Computer Processor</label>
	    <div class="col-sm-9">
	      <input type="text" class="form-control" id="ComputerProcessor" name="ComputerProcessor" placeholder="Computer Processor" maxlength="50">
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="Memory" class="col-sm-3 control-label">Memory</label>
	    <div class="col-sm-9">
	      <input type="text" class="form-control" id="Memory" name="Memory" placeholder="Memory" maxlength="50">
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="OperatingSystem" class="col-sm-3 control-label">Operating System</label>
	    <div class="col-sm-9">
	      <input type="text" class="form-control" id="OperatingSystem" name="OperatingSystem" placeholder="Operating System" maxlength="50">
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="Office" class="col-sm-3 control-label">Office</label>
	    <div class="col-sm-9"> 
	      <input type="text" class="form-control" id="ComputerType" name="Office" placeholder="Office" maxlength="50">
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="GraphicsCard" class="col-sm-3 control-label">Graphics Card</label>
	    <div class="col-sm-9">
	      <input type="text" class="form-control" id="GraphicsCard" name="GraphicsCard" placeholder="Graphics Card" maxlength="50">
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="DateIssued" class="col-sm-3 control-label">Date Issued</label>
	    <div class="col-sm-4">
	    	<div class="input-group">
          <div class="input-group-addon">
            <i class="fa fa-calendar"></i>
          </div>
          <input type="text" class="form-control" id="DateIssued" name="DateIssued" data-inputmask="'alias': 'mm/dd/yyyy'" data-mask>
        </div>
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="DateDestroyed" class="col-sm-3 control-label">Date Destroyed</label>
	    <div class="col-sm-4">
	    	<div class="input-group">
          <div class="input-group-addon">
            <i class="fa fa-calendar"></i>
          </div>
          <input type="text" class="form-control" id="DateDestroyed" name="DateDestroyed" data-inputmask="'alias': 'mm/dd/yyyy'" data-mask>
        </div>
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="DateStocked" class="col-sm-3 control-label">Date Stocked</label>
	    <div class="col-sm-4">
	    	<div class="input-group">
          <div class="input-group-addon">
            <i class="fa fa-calendar"></i>
          </div>
          <input type="text" class="form-control" id="DateStocked" name="DateStocked" data-inputmask="'alias': 'mm/dd/yyyy'" data-mask>
        </div>
	    </div>
	  </div>
	  <div class="form-group">
	  	<label for="Attachment" class="col-sm-3 control-label">Attachment</label>
	  	<div class="col-sm-9">
	  		<input id="Attachment" type="file" class="file" name="Attachment">
	  	</div>
	  </div>
	  <div class="form-group">
	    <label for="Remarks" class="col-sm-3 control-label">Remarks</label>
	    <div class="col-sm-9">
	    	<textarea class="form-control" rows="6" id="Remarks" name="Remarks" placeholder="Remarks ..."></textarea>
	    </div>
	  </div>
	<CFELSEIF structKeyExists(url, "option") and url.option EQ "Equipment">
		<div class="form-group">
	  	<div class="col-sm-offset-3 col-sm-9">
		    <div class="checkbox">
	        <label><input type="checkbox" id="isActive" name="isActive" class="flat-red">&nbsp;Is Active?</label>
	      </div>
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="Brand" class="col-sm-3 control-label">Brand</label>
	    <div class="col-sm-9">
	      <input type="text" class="form-control" id="Brand" name="Brand" placeholder="Brand" maxlength="50">
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="Model" class="col-sm-3 control-label">Model&#42;</label>
	    <div class="col-sm-9">
	      <input type="text" class="form-control" id="Model" name="Model" placeholder="Model" required="required" maxlength="50">
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="Provider" class="col-sm-3 control-label">Provider</label>
	    <div class="col-sm-9">
	      <input type="text" class="form-control" id="Provider" name="Provider" placeholder="Provider" maxlength="50">
	    </div>
	  </div>
		<div class="form-group">
	    <label for="DateIssued" class="col-sm-3 control-label">Date Issued</label>
	    <div class="col-sm-4">
	    	<div class="input-group">
          <div class="input-group-addon">
            <i class="fa fa-calendar"></i>
          </div>
          <input type="text" class="form-control" id="DateIssued" name="DateIssued" data-inputmask="'alias': 'mm/dd/yyyy'" data-mask>
        </div>
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="DateDestroyed" class="col-sm-3 control-label">Date Destroyed</label>
	    <div class="col-sm-4">
	    	<div class="input-group">
          <div class="input-group-addon">
            <i class="fa fa-calendar"></i>
          </div>
          <input type="text" class="form-control" id="DateDestroyed" name="DateDestroyed" data-inputmask="'alias': 'mm/dd/yyyy'" data-mask>
        </div>
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="DateStocked" class="col-sm-3 control-label">Date Stocked</label>
	    <div class="col-sm-4">
	    	<div class="input-group">
          <div class="input-group-addon">
            <i class="fa fa-calendar"></i>
          </div>
          <input type="text" class="form-control" id="DateStocked" name="DateStocked" data-inputmask="'alias': 'mm/dd/yyyy'" data-mask>
        </div>
	    </div>
	  </div>
	  <div class="form-group">
	  	<label for="Attachment" class="col-sm-3 control-label">Attachment</label>
	  	<div class="col-sm-9">
	  		<input id="Attachment" type="file" class="file" name="Attachment">
	  	</div>
	  </div>
	  <div class="form-group">
	    <label for="Remarks" class="col-sm-3 control-label">Remarks</label>
	    <div class="col-sm-9">
	    	<textarea class="form-control" rows="6" id="Remarks" name="Remarks" placeholder="Remarks ..."></textarea>
	    </div>
	  </div>
	<CFELSEIF structKeyExists(url, "option") and  url.option EQ "Others">
	  <div class="form-group">
	  	<div class="col-sm-offset-3 col-sm-9">
		    <div class="checkbox">
	        <label><input type="checkbox" id="isActive" name="isActive" class="flat-red">&nbsp;Is Active?</label>
	      </div>
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="Brand" class="col-sm-3 control-label">Brand</label>
	    <div class="col-sm-9">
	      <input type="text" class="form-control" id="Brand" name="Brand" placeholder="Brand" maxlength="50">
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="Model" class="col-sm-3 control-label">Model&#42;</label>
	    <div class="col-sm-9">
	      <input type="text" class="form-control" id="Model" name="Model" placeholder="Model" required="required" maxlength="50">
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="DateIssued" class="col-sm-3 control-label">Date Issued</label>
	    <div class="col-sm-4">
	    	<div class="input-group">
          <div class="input-group-addon">
            <i class="fa fa-calendar"></i>
          </div>
          <input type="text" class="form-control" id="DateIssued" name="DateIssued" data-inputmask="'alias': 'mm/dd/yyyy'" data-mask>
        </div>
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="DateDestroyed" class="col-sm-3 control-label">Date Destroyed</label>
	    <div class="col-sm-4">
	    	<div class="input-group">
          <div class="input-group-addon">
            <i class="fa fa-calendar"></i>
          </div>
          <input type="text" class="form-control" id="DateDestroyed" name="DateDestroyed" data-inputmask="'alias': 'mm/dd/yyyy'" data-mask>
        </div>
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="DateStocked" class="col-sm-3 control-label">Date Stocked</label>
	    <div class="col-sm-4">
	    	<div class="input-group">
          <div class="input-group-addon">
            <i class="fa fa-calendar"></i>
          </div>
          <input type="text" class="form-control" id="DateStocked" name="DateStocked" data-inputmask="'alias': 'mm/dd/yyyy'" data-mask>
        </div>
	    </div>
	  </div>
	  <div class="form-group">
	  	<label for="Attachment" class="col-sm-3 control-label">Attachment</label>
	  	<div class="col-sm-9">
	  		<input id="Attachment" type="file" class="file" name="Attachment">
	  	</div>
	  </div>
	  <div class="form-group">
	    <label for="Remarks" class="col-sm-3 control-label">Remarks</label>
	    <div class="col-sm-9">
	    	<textarea class="form-control" rows="6" id="Remarks" name="Remarks" placeholder="Remarks ..."></textarea>
	    </div>
	  </div>
	<CFELSE>
	<div class="alert alert-danger alert-dismissible">
	  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
	  <h4><i class="icon fa fa-ban"></i> Alert!</h4>
	  Data did not load. Please reselect Asset Type.
	</div>
	</CFIF>
</div>