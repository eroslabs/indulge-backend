<nav class="navbar navbar-default header2 hidden-xs" style="background-color:#735E56; border-radius: 0;">
  <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="#" style="padding-top:10px;" ><img src="${pageContext.servletContext.contextPath }/images/logo.png" style="width:200px; height:31px" alt="Indulge"/></a></a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav navbar-right">
        <li class="header-stats"><a href="${pageContext.servletContext.contextPath }/merchant/reviews" class="header2"><span class="glyphicon glyphicon-home"></span><span> Stats</span></a></li>
        <li class="header-info"><a href="${pageContext.servletContext.contextPath }/merchant/home" class="header2"><span class="icon-user"></span> <span>Basic Info</span></a></li>
        <li class="header-services"><a href="${pageContext.servletContext.contextPath }/merchant/inputDigitalMenu" class="header2"><i class="icon-list-ol"></i> <span>Services</span></a></li>
        <li class="header-deals"><a href="${pageContext.servletContext.contextPath }/merchant/listDeals" class="header2"><span class="icon-tag"></span> <span>Deals</span></a></li>
        <!-- <li class="header-account" style="border:none;"><a data-toggle="modal" data-target="#myModalAcc" href="" class="header2"><span class="icon-user"></span> <span>Account</span></a></li> -->
        <li class="header-account dropdown" style="border:none;">
          <a id="dropdownMenu1" data-toggle="dropdown" aria-expanded="true" href="" class="header2"><span class="icon-user"></span> <span>Account</span></a>
          <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
            <li><a data-toggle="modal" data-target="#myModalPass" href="" class="header2">Change Password</a></li>
            <li><a href="${pageContext.servletContext.contextPath }/j_spring_security_logout" style="line-height:35px; margin-top:-5px">Logout</a></li>
          </ul>
        </li>
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>

<nav class="navbar navbar-default header2 visible-xs" style="background-color:#735E56; border-radius: 0;">
  <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-2">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="#" style="padding-top:10px;" ><img src="${pageContext.servletContext.contextPath }/images/logo.png" style="width:200px; height:31px" alt="Indulge"/></a></a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-2">
      <ul class="nav navbar-nav navbar-right">
        <li class="header-stats" style="border:none;"><a href="${pageContext.servletContext.contextPath }/merchant/reviews" class="header2"><span class="glyphicon glyphicon-home"></span><span> Stats</span></a></li>
        <li class="header-info" style="border:none;"><a href="${pageContext.servletContext.contextPath }/merchant/home" class="header2"><span class="glyphicon glyphicon-home"></span> <span>Basic Info</span></a></li>
        <li class="header-services" style="border:none;"><a href="${pageContext.servletContext.contextPath }/merchant/inputDigitalMenu" class="header2"><i class="icon-list-ol"></i> <span>Services</span></a></li>
        <li class="header-deals"  style="border:none;"><a href="${pageContext.servletContext.contextPath }/merchant/listDeals" class="header2"><span class="glyphicon glyphicon-home"></span> <span>Deals</span></a></li>
        <li class="header-account dropdown" style="border:none;">
          <a id="dropdownMenu1" data-toggle="dropdown" aria-expanded="true" href="" class="header2"><span class="icon-user"></span> <span>Account</span></a>
          <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
            <li><a href="${pageContext.servletContext.contextPath }/j_spring_security_logout" style="line-height:35px; margin-top:-5px" class="white-text">Logout</a></li>
            <li><a data-toggle="modal" data-target="#myModalPass" href="" class="header2 white-text">Change Password</a></li>
          </ul>
        </li>
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>

<div class="modal fade" id="myModalPass" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
         <div class="modal-dialog">
            <div class="modal-content">
               <div class="modal-header" style="background-color:#1fbbad">
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                  <div class="modal-title font-size-20 location-head font-type"  id="myModalLabel">
                     <center>Change Password</center>
                  </div>
               </div>
               <form method="POST" action="changePassword" onsubmit="return validateChangePassForm();" class="form-horizontal white-bg" id="changePasswordForm">
                  <div class="modal-body" style="text-align:left">
                    <div class="form-group">
                       <label  class="col-sm-7 control-label font-type font-size-16">Old Password</label>
                       <div class="col-sm-17">
                          <input id="oldPassphrase" type="text" class="form-control signup-field" name="oldPassphrase" placeholder="Old Password"  value="${phone.phone}">
                       </div>
                    </div>
                     <div class="form-group">
                        <label class="col-sm-7 control-label font-type font-size-16">New Password</label>
                        <div class="col-sm-17">
                           <input id="passphrase" class="form-control signup-field" type="text" name="passphrase" placeholder="New Password" value="${merchant.software}">
                        </div>
                     </div>
                  </div>
                  <div class="modal-footer nopadding"  style="background-color:#1fbbad; color: #fff;">
                     <center><input type="submit" value="Save" class="signup-button font-size-16 font-type"></center>
                  </div>
               </form>
            </div>
         </div>
      </div>
      <script  type="text/javascript">
      function validateChangePassForm(){
	if(document.getElementById('oldPassphrase').value == '' || document.getElementById('passphrase').value == '' || document.getElementById('oldPassphrase').value.length <= 3 ){
		alert("Invalid values!! Password should not be blank and should be greater than 3 Char.");
		return false;
	}
	return true;
}
      </script>