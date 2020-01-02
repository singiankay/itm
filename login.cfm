<cfinclude template="com/config/loginObjects.cfm">
<cfinclude template="com/login/loginController.cfm">
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>IT Management</title>
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <link rel="icon" type="image/ico" href="assets/img/favicon.ico">
  <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
  <link rel="stylesheet" href="plugins/font-awesome-4.7.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="plugins/ionicons-2.0.1/css/ionicons.min.css">
  <link rel="stylesheet" href="assets/css/AdminLTE.min.css">
  <link rel="stylesheet" href="plugins/iCheck/square/blue.css">
  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->
</head>
<body class="hold-transition login-page">
<div class="login-box" style="margin: 0.5% auto !important;">
  <div class="login-logo">
    <a href="./"><img src="assets/img/logo_300x300.png"></a>
  </div>
    <div id="alertContent" class="row">
      <div class="col-xs-12">
        <cfoutput>#Alert#</cfoutput>
      </div>
    </div>
  <!-- /.login-logo -->
  <div class="login-box-body">
    <p class="login-box-msg">Sign in to start your session</p>

    <form action="" method="post">
      <div class="form-group has-feedback">
        <input type="text" class="form-control" placeholder="Username" name="Username">
        <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
      </div>
      <div class="form-group has-feedback">
        <input type="password" class="form-control" placeholder="Password" name="Password">
        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
      </div>
      <div class="row">
        <!-- /.col -->
        <div class="col-xs-12">
          <input type="hidden" name="urlRedirect" value="<cfoutput>#Redirect#</cfoutput>">
          <input type="submit" class="btn btn-primary btn-block btn-flat" name="submitLogin" value="Sign In">
        </div>
        <!-- /.col -->
      </div>
      <div class="social-auth-links text-center">
        <p>- OR -</p>
        <a href="/" class="btn btn-block btn-social btn-github btn-flat"><i class="fa fa-home"></i>Go back to AppServer Home</a>
      </div>
    </form>
  </div>
  <!-- /.login-box-body -->
</div>
<!-- /.login-box -->

<!-- jQuery 2.2.3 -->
<script src="plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="bootstrap/js/bootstrap.min.js"></script>
<!-- iCheck -->
<script src="plugins/iCheck/icheck.min.js"></script>
</body>
</html>
