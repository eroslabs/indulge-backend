<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib  prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
      <link href="${pageContext.servletContext.contextPath }/css/bootstrap.css" rel="stylesheet" >
    <link href="${pageContext.servletContext.contextPath }/css/custom.css" rel="stylesheet" >
    <link href='http://fonts.googleapis.com/css?family=Raleway:400,500,500,200,600,500' rel='stylesheet' type='text/css'>
    <link href="${pageContext.servletContext.contextPath }/css/merchant.css" rel="stylesheet" />
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
<body style="background-color:#f0f0f0">
	<nav class="navbar navbar-default navbar-custom navbar-fixed-top nav-top" style="background-color:#735E56">
    <div class="container-fluid">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header page-scroll">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
           <a  class="navbar-brand" style="padding:0px 0px" href="${pageContext.servletContext.contextPath }/merchant/home">
          		<img src="${pageContext.servletContext.contextPath }/images/logo.png" class="img-responsive" alt="Indulge" style="height:50px" /></a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right">
              <li><a href="${pageContext.servletContext.contextPath }/merchant/reviews" style="line-height:35px; margin-top:-5px;"><img src="${pageContext.servletContext.contextPath }/images/Stats-active.png" class="img-responsive" alt="Indulge" style="height:40px; float:left" />&nbsp;&nbsp; Stats</a></li>
            	<li><a href="${pageContext.servletContext.contextPath }/merchant/home" style="line-height:35px; margin-top:-5px"><img src="${pageContext.servletContext.contextPath }/images/Info-active.png" class="img-responsive" alt="Indulge" style="height:40px; float:left" />&nbsp;&nbsp;Basic Info</a></li>
            	<li  class="active" style="height:50px;background-color:#f0f0f0"><a href="${pageContext.servletContext.contextPath }/merchant/inputDigitalMenu" style="line-height:35px; margin-top:-5px"><img src="${pageContext.servletContext.contextPath }/images/service.png" class="img-responsive" alt="Indulge" style="height:40px; float:left" />&nbsp;&nbsp;Services</a></li>
            	<li><a href="${pageContext.servletContext.contextPath }/merchant/listDeals" style="line-height:35px; margin-top:-5px"><img src="${pageContext.servletContext.contextPath }/images/Deal-active.png" class="img-responsive" alt="Indulge" style="height:40px; float:left" />&nbsp;&nbsp;Deals</a></li>
            	<li><a href="${pageContext.servletContext.contextPath }/merchant/createMerchantServices" style="line-height:35px; margin-top:-5px"><img src="${pageContext.servletContext.contextPath }/images/account.png" class="img-responsive" alt="Indulge" style="height:40px; float:left" />&nbsp;&nbsp;Account</a></li>
            </ul>
        </div>
    </div>
  </nav>
	<nav class="navbar navbar-default navbar-fixed-bottom nav-bot">
  		<div class="container-fluid">
  			<center>
  			<div class="col-xs-5" style="font:14px; padding-left:0px; padding-right:0px">Stats</div>
  			<div class="col-xs-5 act" style="font:14px; padding-left:0px; padding-right:0px">Basic Info</div>
  			<div class="col-xs-4" style="font:14px;padding-left:0px; padding-right:0px">Services</div>
  			<div class="col-xs-5" style="font:14px;padding-left:0px; padding-right:0px">Deals</div>
  			<div class="col-xs-5" style="font:14px;padding-left:0px; padding-right:0px">Account</div>
  			</center>
  		</div>
	</nav>
	<div class="lh20">&nbsp;</div>
	<div class="container">
		<!-- Nav tabs -->
		<div class="col-lg-9 col-md-9 col-sm-9 col-xs-12 formRightBody">
			<c:if test="${not empty error_message}">
				<div class="lh10">&nbsp;</div>
				<div class="alert alert-danger">${error_message}</div>
			</c:if>
			<c:if test="${not empty success_message}">
				<div class="lh10">&nbsp;</div>
				<div class="alert alert-success">${success_message}</div>
			</c:if>
		</div>
	</div>
	<div class="container-fluid" style="margin-top:70px">
		<div class="row row15">
		<form:form method="POST" action="saveDigitalMenu" modelAttribute="merchant" enctype="multipart/form-data"  class="form-horizontal" id="uploadMerchantPhoto" >
			<div class="col-lg-16 col-lg-push-4 col-md-18 col-md-push-3 col-sm-20 col-sm-push-2 col-xs-24">
				<div class="row row15 font-size-20" style="padding-left:15px;padding-top:5px; padding-bottom:5px;background-color:#ddcbbd">Menu of services</div>



				<div class="row row15" style="margin-top:15px">
						<div class="col-md-4 col-sm-8 col-xs-12" style="padding-left:0px;padding-right:0px;">
			    			<div id="file-upload-cont">
							    <input id="file" type="file" name="files[]" multiple/>
							    <div id="my-button1"></div>
							    <input id="overlay" name="file"/>
							</div>
						</div>
						<output id="list"></output>
		    	</div><br>
		    	<div class="row row15 font-size-20" style="padding-left:15px;padding-top:5px; padding-bottom:5px;background-color:#ddcbbd">Enter digital menu</div>
			    <div class="row row15 font-size-16" style="padding-left:15px;margin-top:15px; padding-bottom:15px">
			    	Create a digital menu and take advantage of our advanced filters.<a href="${pageContext.servletContext.contextPath}/merchant/inputServices"><br>
			    	Define Services.</a>

			    	<a style="float:right" data-toggle="modal" data-target="#myModalSch">View Digital Menu</a>
		    	</div>

		    	<div class="row row15 font-size-20" style="padding-left:15px;padding-top:5px; padding-bottom:5px;background-color:#ddcbbd">Home Services</div>
		    	<div class="col-sm-16 font-size-16" style="padding-left:15px; padding-top:15px">
			    	<div class="form-group">
			    		<div class="col-xs-14" style="padding-top:15px">
						Go to customer home
						</div>
						<div class="col-xs-10">
							<label>
							    <input type="radio" name="homeService" value="1" <c:if test="${not empty merchant.homeService and merchant.homeService}">
							    	checked
							    	</c:if>>
							    <span onclick="toggle()">Yes</span>
							</label>
							<label>
							    <input type="radio" name="homeService" value="0" <c:if test="${not empty merchant.homeService and merchant.homeService}">
							    	checked
							    	</c:if>>
							    <span>No</span>
							</label>
						</div>
				   	</div>
				   	<div class="form-group" id="rad" style="display:none">
			            <label  class="col-xs-14 control-label font-type font-size-16">Service Radius</label>
			            <div class="col-xs-10">
							<input id="serviceRadius" class="form-control entry-field-service" type="text" name="serviceRadius" value="${merchant.serviceRadius}" placeholder="Distance in K.M.">
						</div>
				   	</div>
				</div>
				<div class="col-sm-8" style="padding-top:15px">
					<center><input type="submit" value="Save" class="save-button font-size-16 font-type"></center>
				</div>

			</div>
		</form:form>
		</div>
	</div>
	<!--
	<div class="container">
		<div class="col-lg-9 col-md-9 col-sm-9 col-xs-12 formRightBody">
		<center><h2>Upload Images</h2></center>
		<c:if test="${not empty error_message}">
			<div class="lh10">&nbsp;</div>
			<div class="alert alert-danger">${error_message}</div>
		</c:if>
		
		<div class="lh20">&nbsp;</div>
		<form:form method="POST" action="saveDigitalMenu" modelAttribute="merchant" enctype="multipart/form-data"  class="form-horizontal" id="uploadMerchantPhoto" >
			<div class="form-group">
				    <label class="col-sm-3 control-label">File</label>
				    <div class="col-sm-7">
				      <input type="file" name="file">
				    </div>
				  </div>
				  <div class="col-sm-7">
				      <input type="file" name="file">
				    </div>
				  </div>
				  <div class="col-sm-7">
				      <input type="file" name="file">
				    </div>
				  </div>
				
		
		
			<div class="form-group">
				    <label class="col-sm-3 control-label">Go To Customer Home*</label>
				    <div class="col-sm-7">
				      <input id="homeService" class="form-control" type="checkbox" name="homeService" >${merchant.homeService}
				    </div>
				  </div>
			<div class="form-group">
				    <label class="col-sm-3 control-label">Service Radius </label>
				    <div class="col-sm-7">
				      <input id="serviceRadius" class="form-control" type="text" name="serviceRadius" value="${merchant.serviceRadius}">
				    </div>
				  </div>
				<div class="form-group">
				    <label class="col-sm-3 control-label">Separate Rate Card</label>
				    <div class="col-sm-7">
				      <input id="separateRateCard" class="form-control" type="checkbox" name="separateRateCard" >
				    </div>
				  </div>
		<div class="form-group">
				    <div class="col-sm-offset-3 col-sm-7">
				      <input type="submit" value="Save" class="btn btn-primary" />
				    </div>
				  </div> 
	</div>
	</div>
	</form:form>
	-->

	<script>
  function handleFileSelect(evt) {
    var files = evt.target.files; // FileList object

    // Loop through the FileList and render image files as thumbnails.
    for (var i = 0, f; f = files[i]; i++) {

      // Only process image files.
      if (!f.type.match('image.*')) {
        continue;
      }

      var reader = new FileReader();

      // Closure to capture the file information.
      reader.onload = (function(theFile) {
        return function(e) {
          // Render thumbnail.
          var span = document.createElement('span');
          span.innerHTML = ['<img class="col-md-4 col-sm-8 col-xs-12 thumb" src="', e.target.result,
                            '" title="', escape(theFile.name), '"/>'].join('');
          document.getElementById('list').insertBefore(span, null);
        };
      })(f);

      // Read in the image file as a data URL.
      reader.readAsDataURL(f);
    }
  }
  document.getElementById('file').addEventListener('change', handleFileSelect, false);
</script>
<script type="text/javascript">
	function toggle(){
		document.getElementById("rad").style.cssText = "visibility:visible !important;";
	}
</script>
	
</body>
</html>