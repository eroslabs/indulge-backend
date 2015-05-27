<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
      <link href="${pageContext.servletContext.contextPath }/css/bootstrap.css" rel="stylesheet" >
    <link href='http://fonts.googleapis.com/css?family=Raleway:400,500,500,200,600,500' rel='stylesheet' type='text/css'>
    <link href="${pageContext.servletContext.contextPath }/css/merchant-min.css" rel="stylesheet" />
    <link href="${pageContext.servletContext.contextPath }/font-awesome/css/font-awesome.min.css" rel="stylesheet" />
    
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="${pageContext.servletContext.contextPath }/js/jquery-1.11.1.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="${pageContext.servletContext.contextPath }/js/bootstrap.min.js"></script>
    <script src="${pageContext.servletContext.contextPath }/js/jquery.validate.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
<body>
 
<div class="lh20">&nbsp;</div>
  <div class="container-fluid">
    <div class="container-fluid" id="header">
      <div class="row row15">
        <div class="col-xs-3 header-columns"><a  href="${pageContext.servletContext.contextPath }/html/howitwork.html">How it Works</a></div>
        <div class="col-xs-3 header-columns"><a  href="${pageContext.servletContext.contextPath }/html/benefits.html">Benefits</a></div>
        <div class="col-xs-2 header-columns"><a  href="${pageContext.servletContext.contextPath }/html/pricing.html">Pricing</a></div>
        <div class="col-xs-8 header-image">
          <center>
          <a  href="#">
                <img src="${pageContext.servletContext.contextPath }/images/erosimg/logo1.png" style="height:50px" class="img-responsive" alt="Indulge"/></a></center>
            </div>
        <div class="col-sm-2 header-columns"><a  href="${pageContext.servletContext.contextPath }/html/faq.html">FAQ's</a></div>
			<div class="col-sm-3 header-columns"><a  href="${pageContext.servletContext.contextPath }/merchant/login">Login</a></div>
			<div class="col-sm-3 header-columns"><a  href="${pageContext.servletContext.contextPath }/register/input">Join Us</a></div>
      </div>
     <div class="row row15">
		<c:if test="${not empty error_message}">
			<div class="lh10">&nbsp;</div>
			<div class="alert alert-danger">${error_message}</div>
		</c:if>
		<c:if test="${not empty success_message}">
			<div class="lh10">&nbsp;</div>
			<div class="alert alert-success">${success_message}</div>
		</c:if>
	<div class="row row15">
		<c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION}">
			<div class="lh10">&nbsp;</div>
	        <div class="alert alert-danger">Unsuccessful Login : <c:out value="${SPRING_SECURITY_LAST_EXCEPTION.message}"/>.</div>
		</c:if>
	</div>
	</div>
    <div class = "row row15" style="border:1px solid #aea190; margin-top:30px;">
      <div class="col-md-15" style="padding:0px">
        <div style="background: url('${pageContext.servletContext.contextPath }/images/erosimg/front.png') center center no-repeat;background-size:cover;height:480px;width:100%;border-bottom: solid 4px #1fbbad; padding-top:250px">
          <center>
            <span style="font-size:36px;color:#ffffff;font-weight:bold;">LOOKING FOR MORE CUSTOMERS ?</span><br>
            <span style="font-size:25px;color:#DDCBDD;font:Arial">Join India's fastest growing beauty and wellness marketplace</span><br><br>
            <div class="col-md-8 col-md-push-8 col-sm-10 col-sm-push-7 col-xs-12 col-xs-push-6 button" style="font-size: 20px; color: rgb(255, 255, 255); padding-top: 10px; padding-bottom: 10px;">SIGN UP FOR FREE</div>
          </center>
        </div>
      </div>
      <div class="col-md-9" style="background-color:#1fbbad; border:1px solid #aea190; padding:0px;height:480px">
        <form class="form-signin col-xs-18 col-xs-push-3" name='form' action='${pageContext.servletContext.contextPath }/j_spring_security_check' method='POST' style="margin-top:100px; padding:30px; padding-bottom:15px; background-color:#acddcf">
              <div class="form-group">
                <label class="sr-only">Email address</label>
                <input type="text" autofocus="" required="" placeholder="Email or Phone no." class="form-control sign-in-username sign-in-place font-size-20" name='username' value='' >
              </div>
              <div class="form-group">
                <label class="sr-only">Password</label>
                <input type="password" required="" placeholder="Password" class="form-control sign-in-pass sign-in-place font-size-16" name='password'>
              </div>
              <div class="form-group font-size-16" style="text-align:right">
               <a href="${pageContext.servletContext.contextPath}/register/inputforgot"> Forgot Password ?</a>
              </div>
              <button type="submit" class="btn btn-lg btn-primary btn-block btn-login" name="submit">Login</button>
              <div class="form-group font-size-20" style="text-align:center; margin-top:10px">
                <a href="${pageContext.servletContext.contextPath}/register/input" style="text-decoration:none;">Don't have an account ? Sign Up.</a>
              </div>
        </form>
      </div>
    </div>
    <div class = "row row15">
      <center>
        <span style="font-size:30px;">BENEFITS</span><br>
      </center>
      <div class="col-md-20 col-md-push-2 col-sm-22 col-sm-push-1" style="margin-top:60px;">
        <center>
          <div class="col-sm-12 col-md-8">
            <div style="background:url('${pageContext.servletContext.contextPath }/images/erosimg/ic1.png') top center no-repeat;background-size:142px 142px;height:200px;">
              <span style="font-size:26px;font-weight: bold; color: rgb(115, 94, 86);"><br><br><br><br>EASY REGISTRATION</span>
            </div>
          </div>
          <div class="col-sm-12 col-md-8">
            <div style="background:url('${pageContext.servletContext.contextPath }/images/erosimg/ic2.png') top center no-repeat;background-size:165px 160px;height:200px;">
              <span style="font-size:26px;font-weight: bold; color: rgb(115, 94, 86);"><br><br><br><br>GROWING USER BASE</span>
            </div>
          </div>
          <div class="col-sm-12 col-md-8">
            <div style="background:url('${pageContext.servletContext.contextPath }/images/erosimg/ic3.png') top center no-repeat;background-size:165px 160px;height:200px;">
              <span style="font-size:26px;font-weight: bold; color: rgb(115, 94, 86);"><br><br><br><br>REAL TIME DEALS</span>
            </div>
          </div>
          <div class="col-sm-12 col-md-8">
            <div style="background:url('${pageContext.servletContext.contextPath }/images/erosimg/ic4.png') top center no-repeat;background-size:142px 142px;height:200px;">
              <span style="font-size:26px;font-weight: bold; color: rgb(115, 94, 86);"><br><br><br><br>RECOMMENDATIONS</span>
            </div>
          </div>
          <div class="col-sm-12 col-md-8">
            <div style="background:url('${pageContext.servletContext.contextPath }/images/erosimg/ic5.png') top center no-repeat;background-size:165px 160px;height:200px;">
              <span style="font-size:26px;font-weight: bold; color: rgb(115, 94, 86);"><br><br><br><br>UNLIMITED DEALS</span>
            </div>
          </div>
          <div class="col-sm-12 col-md-8">
            <div style="background:url('${pageContext.servletContext.contextPath }/images/erosimg/ic6.png') top center no-repeat;background-size:165px 160px;height:200px;">
              <span style="font-size:26px;font-weight: bold; color: rgb(115, 94, 86);"><br><br><br><br>CUSTOMER SUPPORT</span>
            </div>
          </div>
        </center>
      </div>
    </div>
    <br>
    <div class="row row15" style="background: #1fbbad;margin-top:50px;">
      <center>
        <h1 style="color:#ffffff;font-size:47px"><br>WHO SHOULD JOIN</h1>
        <br><br>
        <span style="color: rgb(240, 240, 240);font-size:24px">All Individuals, Salons and Spas that provide any of the following</span><br>
        <span style="color: rgb(240, 240, 240);font-size:24px">services and are interested in expanding their client base</span><br>
      </center>
      <span class="MerchantIcons col-md-24 col-sm-24" style="margin-bottom:50px;">
        <div class="col-md-3 col-sm-6"><div style="background:url('${pageContext.servletContext.contextPath }/images/erosimg/mic1.png') center center no-repeat;background-size:100px 100px;height:120px;width:90%"></div> </div>
        <div class="col-md-3 col-sm-6"><div style="background:url('${pageContext.servletContext.contextPath }/images/erosimg/mic1.png') center center no-repeat;background-size:100px 100px;height:120px;width:90%"></div> </div>
        <div class="col-md-3 col-sm-6"><div style="background:url('${pageContext.servletContext.contextPath }/images/erosimg/mic1.png') center center no-repeat;background-size:100px 100px;height:120px;width:90%"></div> </div>
        <div class="col-md-3 col-sm-6"><div style="background:url('${pageContext.servletContext.contextPath }/images/erosimg/mic1.png') center center no-repeat;background-size:100px 100px;height:120px;width:90%"></div> </div>
        <div class="col-md-3 col-sm-6"><div style="background:url('${pageContext.servletContext.contextPath }/images/erosimg/mic1.png') center center no-repeat;background-size:100px 100px;height:120px;width:90%"></div> </div>
        <div class="col-md-3 col-sm-6"><div style="background:url('${pageContext.servletContext.contextPath }/images/erosimg/mic1.png') center center no-repeat;background-size:100px 100px;height:120px;width:90%"></div> </div>
        <div class="col-md-3 col-sm-6"><div style="background:url('${pageContext.servletContext.contextPath }/images/erosimg/mic1.png') center center no-repeat;background-size:100px 100px;height:120px;width:90%"></div> </div>
        <div class="col-md-3 col-sm-6"><div style="background:url('${pageContext.servletContext.contextPath }/images/erosimg/mic1.png') center center no-repeat;background-size:100px 100px;height:120px;width:90%"></div> </div>
      </span>
    </div>

    <div class="row row15" style="background: #f0f0f0;">
      <center>
        <h1 style="color: rgb(115, 94, 86);font-size:47px;"><br>HOW IT WORKS<br><br></h1>
      
      <div class="row row15">
        
        <div class="col-md-push-2 col-md-4 col-sm-push-2 col-sm-4" style="margin-bottom:50px;">
          <div class="circle" style="height:200px;width:200px;background:#DDCBBD;"> </div>
        </div>
        
        <div class="col-md-push-6 col-md-4 col-sm-push-6 col-sm-4"  style="margin-bottom:50px">
          <div class="circle" style="height:200px;width:200px;background:#DDCBBD;"> </div>
        </div>
        
        <div class="col-md-push-10 col-md-4 col-sm-push-10 col-sm-4"  style="margin-bottom:50px">
          <div class="circle" style="height:200px;width:200px;background:#DDCBBD;"> </div>
        </div>
      </div>
      </center>
      


    </div>
    <div class="row row15" style="background: #735e56;">
      <center>
        <br><br>
        <h3 style="color:#ffffff">Important Links<br></h3>
        <span style="color: rgb(239, 231, 222);font-size: 22px;">How it works | Benefits | Pricing | FAQ's | Privacy Policy | Contact Us<br><br></span>
      </center>
    </div>
  </div>
</body>
</html>