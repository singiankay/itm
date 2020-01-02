<cfinclude template="../../com/config/initObjects.cfm">
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>IT Management</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <link rel="icon" type="image/ico" href="assets/img/favicon.ico">
  <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
<!---   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css"> --->
  <link rel="stylesheet" href="plugins/font-awesome-4.7.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="plugins/bootstrap-touchspin/jquery.bootstrap-touchspin.min.css">
  <link rel="stylesheet" href="plugins/ionicons-2.0.1/css/ionicons.min.css">
  <link rel="stylesheet" href="assets/css/AdminLTE.min.css">
  <link rel="stylesheet" href="plugins/datatables/dataTables.bootstrap.css">
  <!--- <link rel="stylesheet" href="plugins/datatables/jquery.dataTables.min.css"> --->
  <!--- <link rel="stylesheet" href="plugins/jasny-bootstrap/css/jasny-bootstrap.min.css"> --->
  <link rel="stylesheet" href="plugins/iCheck/all.css">
  <link rel="stylesheet" href="plugins/timepicker/bootstrap-timepicker.min.css">
  <link rel="stylesheet" href="plugins/bootstrap-fileinput/css/fileinput.min.css">
  <link rel="stylesheet" href="assets/css/toastr.css">
  <link rel="stylesheet" href="assets/css/custom.css">

  <!-- Theme style -->

  <link rel="stylesheet" href="assets/css/skins/skin-blue.min.css">

  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->
</head>

<body class="hold-transition skin-blue sidebar-collapse sidebar-mini">
<div class="wrapper">

  <!-- Main Header -->
  <header class="main-header">

    <!-- Logo -->
    <a href="./index.cfm" class="logo">
      <!-- mini logo for sidebar mini 50x50 pixels -->
      <span class="logo-mini"><b>ITM</b></span>
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg"><b>IT</b> Management</span>
    </a>

    <!-- Header Navbar -->
    <nav class="navbar navbar-static-top" role="navigation">
      <!-- Sidebar toggle button-->
      <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
        <span class="sr-only">Toggle navigation</span>
      </a>
      <!-- Navbar Right Menu -->
      <div class="navbar-custom-menu">
        <ul class="nav navbar-nav">

          <!-- User Account Menu -->
          <li class="dropdown user user-menu">
            <!-- Menu Toggle Button -->
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <!-- The user image in the navbar-->
              <img src="<cfoutput>#Session.picture#</cfoutput>" class="user-image" alt="User Image">
              <!-- hidden-xs hides the username on small devices so only the image appears. -->
              <span class="hidden-xs"><cfoutput>#Session.username#</cfoutput></span>
            </a>
            <ul class="dropdown-menu">
              <!-- The user image in the menu -->
              <li class="user-header">
                <img src="<cfoutput>#Session.picture#</cfoutput>" class="img-circle" alt="User Image">

                <p>
                  <cfoutput>#Session.firstname&" "&Session.lastname&" - "&Session.position#</cfoutput>
                  <cfoutput><small>Member since #DateFormat(Session.datehired, "mmm yyyy")#</small></cfoutput>
                </p>
              </li>
              <!-- Menu Body -->

              <!-- Menu Footer-->
              <li class="user-footer">
                <div class="pull-left">
                  <a href="/" class="btn btn-default btn-flat">Go to NPI Appserver</a>
                </div>
                <div class="pull-right">
                  <a href="login.cfm?logout=true" class="btn btn-default btn-flat">Sign out</a>
                </div>
              </li>
            </ul>
          </li>
        </ul>
      </div>
    </nav>
  </header>