<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib  prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">
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
            	<li class="active" style="height:50px;background-color:#f0f0f0"><a href="${pageContext.servletContext.contextPath }/merchant/home" style="line-height:35px; margin-top:-5px"><img src="${pageContext.servletContext.contextPath }/images/Info.png" class="img-responsive" alt="Indulge" style="height:40px; float:left" />&nbsp;&nbsp;Basic Info</a></li>
            	<li><a href="${pageContext.servletContext.contextPath }/merchant/inputDigitalMenu" style="line-height:35px; margin-top:-5px"><img src="${pageContext.servletContext.contextPath }/images/Service-active.png" class="img-responsive" alt="Indulge" style="height:40px; float:left" />&nbsp;&nbsp;Services</a></li>
            	<li><a href="${pageContext.servletContext.contextPath }/merchant/listDeals" style="line-height:35px; margin-top:-5px"><img src="${pageContext.servletContext.contextPath }/images/Deal-active.png" class="img-responsive" alt="Indulge" style="height:40px; float:left" />&nbsp;&nbsp;Deals</a></li>
            	<li><a data-toggle="modal" data-target="#myModalAcc" href="${pageContext.servletContext.contextPath }/j_spring_security_logout" style="line-height:35px; margin-top:-5px"><img src="${pageContext.servletContext.contextPath }/images/account.png" class="img-responsive" alt="Indulge" style="height:40px; float:left" />&nbsp;&nbsp;Logout</a></li>
            </ul>
        </div>
    </div>
  </nav>
	<nav class="navbar navbar-default navbar-fixed-bottom nav-bot" style="border:1px solid;background-color:#735E56">
  		<div class="container-fluid" style="border:1px solid #1fbbad">
  			<center>
  			<div class="col-xs-5" style="font:14px; padding-left:0px; padding-right:0px"><a href="${pageContext.servletContext.contextPath }/merchant/reviews" style="line-height:35px; margin-top:-5px;color:#fff"><img src="${pageContext.servletContext.contextPath }/images/Stats-active.png" class="img-responsive" alt="Indulge" style="height:40px;"/>Stats</a></div>
  			<div class="col-xs-5 active" style="font:14px; padding-left:0px; padding-right:0px;background-color:#f0f0f0"><a href="${pageContext.servletContext.contextPath }/merchant/home" style="line-height:35px; margin-top:-5px; color:#735E56"><img src="${pageContext.servletContext.contextPath }/images/Info.png" class="img-responsive" alt="Indulge" style="height:40px"/>Basic Info</a></div>
  			<div class="col-xs-4" style="font:14px;padding-left:0px; padding-right:0px"><a href="${pageContext.servletContext.contextPath }/merchant/inputDigitalMenu" style="line-height:35px; margin-top:-5px;color:#fff"><img src="${pageContext.servletContext.contextPath }/images/Service-active.png" class="img-responsive" alt="Indulge" style="height:40px" />Services</a></div>
  			<div class="col-xs-5" style="font:14px;padding-left:0px; padding-right:0px"><a href="${pageContext.servletContext.contextPath }/merchant/listDeals" style="line-height:35px; margin-top:-5px; color:#fff"><img src="${pageContext.servletContext.contextPath }/images/Deal-active.png" class="img-responsive" alt="Indulge" style="height:40px" />Deals</div>
  			<div class="col-xs-5" style="font:14px;padding-left:0px; padding-right:0px"><a data-toggle="modal" data-target="#myModalAcc" href="" style="line-height:35px; margin-top:-5px; color: #fff"><img src="${pageContext.servletContext.contextPath }/images/account.png" class="img-responsive" alt="Indulge" style="height:40px" />Account</a></div>
  			</center>
  		</div>
	</nav>
  <div class="row row15" id="merchant-home-body" style="margin-bottom:10px">
      <div class="col-md-21 col-md-push-2 col-sm-21 col-sm-push-2">
    <!-- Nav tabs -->
        <div class="row row15">
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
      <div class="col-md-10 col-md-push-2 col-sm-10 col-sm-push-2">
        <div class="row row15" style=" margin-left:15px; background-color:#B4978D">
          <center>
            <div class="col-md-8 col-sm-8" >
            <img src="<c:if test="${merchant.image ne null and merchant.image != ''}" >../images/merchant/${merchant.image}</c:if>" style="border-radius:75px; height:90px; width:90px; margin-top:20px; margin-bottom:15px; border:1px solid red">
            </div>
          </center>
          <div class="col-md-10 col-sm-10" style="padding-bottom:10px">
          <center>
            <h2>${merchant.name}</h2>
            <p>Individual</p>
            <p>${merchant.locality}, ${merchant.city}</p>
          </center>
          </div>
        </div>
      </div>

      <div class="col-md-10 col-md-push-3 col-sm-10 col-sm-push-3" style="height:100%">
        <div class="row row15 font-size-16 font-type" style="padding-left:15px; padding-right:15px"> Opening Hours <a style="float:right" data-toggle="modal" data-target="#myModalSch">edit</a></div>
        <div class="merchant-home font-size-16 font-type">
	<c:choose>
		<c:when test="${merchant.schedule ne null}">
		<c:forEach var="schedule" items="${merchant.schedule}" varStatus="status">
			${schedule.weekStr} ${schedule.openingTime} - ${schedule.closingTime}<br/>
		</c:forEach>
	</c:when>
	<c:otherwise>
		No schedule specified.
	</c:otherwise>
	</c:choose> 
        </div>
      </div>
  </div>
	<!--<div class="container">
		<div class="row" style="text-align: center;">

			<h2>Welcome to merchant app</h2>
			Name  : <strong>${merchant.name}</strong>
			<br/>Pending Task ( Attract more users): <c:if test="${not merchant.profileComplete}"><a href="inputLocation"> Complete Profile</a></c:if>
			<div style="clear:both;"/>
		</div>
	</div>-->
<div class="row row15">
  <div class="col-md-10 col-md-push-2 col-sm-10 col-sm-push-2">
   <div class="row row15 font-size-16 font-type" style="padding-left:15px; padding-right:15px">Venue Info <a style="float:right" data-toggle="modal" data-target="#myModalAdd">edit</a></div>
    <div class="merchant-home">
      <table class="font-size-16 font-type" style="width:80%">
        <tr>
          <td width="50%" valign="top">Address</td>
          <td width="50%">${merchant.address}</td>
        </tr>
        <tr>
          <td width="50%" height="30px">Locality</td>
          <td width="50%">${merchant.locality}</td>
        </tr>
        <tr>
          <td width="50%" height="30px">Landmark</td>
          <td width="50%">${merchant.landmark}</td>
        </tr>
        <tr>
          <td width="50%" height="30px">City</td>
          <td width="50%">${merchant.city}</td>
        </tr>
        <tr>
          <td width="50%" height="30px">ZipCode</td>
          <td width="50%"></td>
        </tr>
        <tr>
          <td width="50%" height="30px">Accept Debit Cards</td>
          <td width="50%">No</td>
        </tr>
        <tr>
          <td width="50%" height="30px">Have Air Conditioning</td>
          <td width="50%">Yes</td>
        </tr>
      </table>
    </div>
  </div>

  <div class="col-md-10 col-md-push-3 col-sm-10 col-sm-push-3">
    <div class="row row15  font-size-16 font-type" style="padding-left:15px; padding-right:15px"> Contact Info <a style="float:right" data-toggle="modal" data-target="#myModalCon">edit</a></div>
    <div class="merchant-home">
      <table class="font-size-16 font-type" style="width:80%">
        <c:if test="${merchant.phones ne null and  not empty merchant.phones}">
            <c:forEach var="phoneItem" items="${merchant.phones}" varStatus="status"> 
              <tr>
                <td width="50%" height="30px">Phone No.</td>
                <td width="50%">${phoneItem.phone }</td>
              </tr>
            </c:forEach>
        </c:if>
        <c:if test="${merchant.phones == null or  empty merchant.phones}">
            <tr>
              <td width="50%" height="30px">Phone No.</td>
              <td width="50%"></td>
            </tr>
        </c:if>
        <tr>
              <td width="50%" height="30px">Software</td>
              <td width="50%">${merchant.software}</td>
        </tr>
        <tr>
              <td width="50%" height="30px"></td>
              <td width="50%"></td>
        </tr>
        <tr>
              <td width="50%" height="30px"></td>
              <td width="50%"></td>
        </tr>
        <tr>
              <td width="50%" height="30px"></td>
              <td width="50%"></td>
        </tr>
        <tr>
              <td width="50%" height="30px"></td>
              <td width="50%"></td>
        </tr>
        <tr>
              <td width="50%" height="30px"></td>
              <td width="50%"></td>
        </tr>
      </table>
    </div>
  </div>
</div>
<div class="row row15">
  <div class="col-md-21 col-md-push-2 col-sm-21 col-sm-push-2">
    <div class="row row15 font-size-16 font-type" style="padding-left:15px; padding-right:15px">Photos</div>
    <div class="row row15 merchant-home">
    <div class="col-md-6">
    <center>
      <div class="row" style="height:150px;width:150px; margin-top:15px">
                  <div id="file-upload-cont">
                    <input id="file" type="file" name="files" multiple/>
                    <div id="my-button"></div>
                    <input id="overlay"/>
                </div>
      </div>
    </center>
    </div>
      <output id="list"></output>
      <c:forEach var="imageItem" items="${merchant.images}" varStatus="status"> 
      <div class="col-md-6 thumb-home" style="overflow:hidden">
        <img src="${pageContext.servletContext.contextPath}/images/merchant/${imageItem.image}">
      </div>
    </c:forEach>
    </div>
    
  </div>
</div>

<!-- Modal -->
<div class="modal fade" id="myModalSch" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Schedule Details</h4>
      </div>
      <div class="modal-body">
        ...
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>
<div class="modal fade" id="myModalAdd" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header" style="background-color:#1fbbad">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
         <div class="modal-title font-size-20 location-head font-type"  id="myModalLabel">
                <center>Enter Address Info</center>
            </div>
      </div>
      <form:form method="POST" action="saveAddress" modelAttribute="merchant" class="form-horizontal white-bg" id="creatMerchantForm">
      <div class="modal-body" style="text-align:left">
          <div class="form-group">
            <label  class="col-sm-4 control-label font-type font-size-16">Address</label>
            <div class="col-sm-18">
            <textarea id="address" class="form-control signup-field" name="address" placeholder="Address" value="${merchant.address}" style="resize:none"></textarea>
            </div>
          </div>

          <div class="form-group">
            <label class="col-sm-4 control-label font-type font-size-16">Landmark</label>
            <div class="col-sm-18">
            <input id="landmark" class="form-control signup-field" type="text" name="landmark" placeholder="Landmark" value="${merchant.landmark }">
            </div>
          </div>

          <div class="form-group">
            <label class="col-sm-4 control-label font-type font-size-16">City</label>
            <div class="col-sm-18">
            <input id="city" class="form-control signup-field" type="text" name="city" placeholder="City" value="${merchant.city }">
            </div>
          </div>

          <div class="form-group">
            <label class="col-sm-4 control-label font-type font-size-16">State</label>
            <div class="col-sm-18">
            <input id="state" class="form-control signup-field" type="text" name="state" placeholder="State" value="${merchant.state }">
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-4 control-label font-type font-size-16">Pincode</label>
            <div class="col-sm-18">
            <input id="pincode" class="form-control signup-field" type="text" name="pincode" placeholder="Pincode" value="${merchant.pincode }">
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-4 control-label font-type font-size-16">Country</label>
            <div class="col-sm-18">
            <input id="country" class="form-control signup-field" type="text" name="country" placeholder="Country" value="${merchant.country }">
            </div>
          </div>
      </div>
      <div class="modal-footer"  style="background-color:#1fbbad">
        <center><input type="submit" value="Save" class="signup-button font-size-16 font-type"></center>
      </div>
      </form:form>
    </div>
  </div>
</div>
<div class="modal fade" id="myModalSch" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Schedule Details</h4>
      </div>
      <div class="modal-body">
        ...
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>
<div class="modal fade" id="myModalAcc" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header" style="background-color:#1fbbad">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <div class="modal-title font-size-20 location-head font-type"  id="myModalLabel">
                <center>Account Details</center>
            </div>
      </div>
      <div class="modal-body">
        ...
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">
  jQuery(document).ready(function(){
    jQuery("#file-upload-cont").hover(
      function(){
      jQuery("#my-button").css("background","url('../images/location-header-hover.png') center center no-repeat");},
      function(){
      jQuery("#my-button").css("background","url('../images/location-header.png') center center no-repeat");
      }

    );
  });
  </script>
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
          span.innerHTML = ['<img class="col-md-6 thumb-home" src="', e.target.result,
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
</body>
</html>
