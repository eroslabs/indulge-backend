<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">
<head>
<jsp:include page="../views/globalhead.jsp" />
</head>
<body style="background-color: #fff">
	<jsp:include page="../views/postmerchantHeader.jsp" />
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
	<div class="container-fluid" style="margin-top: 70px">
		<div class="row row15">
			<form:form method="POST" action="saveDigitalMenu"
				modelAttribute="merchant" enctype="multipart/form-data"
				class="form-horizontal" id="uploadMerchantPhoto">
				<div
					class="col-lg-16 col-lg-push-4 col-md-18 col-md-push-3 col-sm-20 col-sm-push-2 col-xs-24">
					<div class="row row15 font-size-20"
						style="padding-left: 15px; padding-top: 5px; padding-bottom: 5px; background-color: #f0f0f0;">Home
						Services</div>
					<div class="col-sm-16 font-size-16"
						style="padding-left: 15px; padding-top: 20px">
						<div class="form-group">
							<label class="col-xs-9 control-label font-size-16"
								style="text-align: left;">Go to customer home</label>
							<div class="col-xs-10">
								<label> <input type="radio" name="homeService" value="1"
									<c:if test="${not empty merchant.homeService and merchant.homeService}">
							    	checked
							    	</c:if>>
									<span onclick="toggle(true)">Yes</span>
								</label> <label> <input type="radio" name="homeService"
									value="0"
									<c:if test="${not empty merchant.homeService and not merchant.homeService}">
							    	checked
							    	</c:if>>
									<span onclick="toggle(false)">No</span>
								</label>
							</div>
						</div>
						<div class="form-group" id="rad"
							<c:if test="${empty merchant.homeService or not merchant.homeService}">
							    	style="display:none"
							    	</c:if>>
							<label class="col-xs-9 control-label font-size-16"
								style="text-align: left;">Service Radius</label>
							<div class="col-xs-10">
								<input id="serviceRadius"
									class="form-control entry-field-service" type="text"
									name="serviceRadius"
									value="<c:if test='${merchant.serviceRadius ne 0}' >${merchant.serviceRadius}</c:if>"
									placeholder="Distance in K.M.">
							</div>
						</div>
					</div>
					<div class="col-sm-8" style="padding-top: 20px">
						<center>
							<input type="submit" value="Save Changes"
								class="btn btn-lg btn-green" style="width: 100%;">
						</center>
					</div>
				</div>
				<div
					class="col-lg-16 col-lg-push-4 col-md-18 col-md-push-3 col-sm-20 col-sm-push-2 col-xs-24">





					<div class="row row15 font-size-20"
						style="padding-left: 15px; padding-top: 5px; padding-bottom: 5px; background-color: #f0f0f0;">Menu
						of services</div>



					<div class="row row15" style="margin-top: 20px">
						<div class="col-md-4 col-sm-8 col-xs-12"
							style="padding-left: 0px; padding-right: 0px;">
							<div id="file-upload-cont">
								<input id="file" type="file" name="file" multiple />
								<div id="my-button1"></div>
								<input id="overlay" name="file" />
							</div>
						</div>
						<output id="list"></output>
						<c:forEach var="menu" items="${merchant.menus}" varStatus="state">
							<c:forEach var="banner" items="${menu.image}" varStatus="status">

								<div class="col-md-8 col-lg-6 col-sm-12 col-xs-24"
									style="overflow: hidden">
									<a href="#" onclick="return deleteImage(${menu.id} , this);"
										class="white-text font-size-16"
										style="position: relative; left: 43px; top: 28px;"><i
										class="icon-trash"></i> Delete</a> <img
										src="${pageContext.servletContext.contextPath}/images/merchant/${menu.image}"
										style="height: 150px; width: 150px">
								</div>

							</c:forEach>
						</c:forEach>
					</div>
					<br>
					<div class="row row15 font-size-20"
						style="padding-left: 15px; padding-top: 5px; padding-bottom: 5px; background-color: #f0f0f0;">Enter
						digital menu</div>
					<div class="row row15 font-size-16"
						style="padding-left: 15px; margin-top: 20px; padding-bottom: 15px">
						Create a digital menu and take advantage of our advanced filters.<a
							href="${pageContext.servletContext.contextPath}/merchant/inputServices"><br>
							Define Services.</a>
						<c:if test="${not empty merchant.services}">
							<a style="float: right" data-toggle="modal"
								data-target="#myModalSch">View Digital Menu</a>
						</c:if>
					</div>

				</div>
			</form:form>
		</div>
	</div>
	<div class="modal fade" id="myModalSch" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header" style="background-color: #1fbbad">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4
						class="modal-title white-text text-center text-uppercase font-size-24"
						id="myModalLabel" style="padding: 15px;">
						<i style="font-weight: bold">${merchant.name} Rate Card</i>
					</h4>
				</div>
				<div class="modal-body menu-gradient"
					style="border: 15px double #757474;">
					<div class="row text-uppercase hidden-xs">
						<label class="col-sm-3">Category</label> <label class="col-sm-5">Service
							Name</label> <label class="col-sm-6">Service Type</label> <label
							class="col-sm-4">Home Service</label> <label class="col-sm-3">Gender</label>
						<label class="col-sm-3">Price</label>
					</div>
					<c:forEach var="service" items="${merchant.services}"
						varStatus="state">
						<div class="row hidden-xs"
							style="padding: 10px 0; border-bottom: 1px solid #ccc;">
							<div class="col-sm-3">${service.categoryName}</div>
							<div class="col-sm-5">${service.serviceName}</div>
							<div class="col-sm-6">${service.name}</div>
							<div class="col-sm-4 text-center">
								<c:if test="${service.homeService==1 or service.homeService==2}">
									<i class="icon-check"></i>
								</c:if>
								<c:if test="${service.homeService==0}">
									<i class="icon-remove"></i>
								</c:if>
							</div>
							<div class="col-sm-3 text-center">
								<c:if test="${service.gender==1}">
									<i class="icon-female"></i>
								</c:if>
								<c:if test="${service.gender==0}">
									<i class="icon-male"></i>
								</c:if>
								<c:if test="${service.gender==2}">
									<i class="icon-male"></i>
									<i class="icon-female"></i>
								</c:if>
							</div>
							<div class="col-sm-3">INR ${service.price}/-</div>
						</div>
					</c:forEach>
					<c:forEach var="service" items="${merchant.services}"
						varStatus="state">
						<div class="row visible-xs"
							style="padding: 10px 0; border-bottom: 1px solid #979797;">
							<label class="col-xs-12">Service Type</label>
							<div class="col-sm-6 col-xs-12">${service.name}</div>
						</div>
						<div class="row visible-xs"
							style="padding: 10px 0; border-bottom: 1px solid #979797;">
							<label class="col-xs-12">Home Service</label>
							<div class="col-sm-4 col-xs-12 text-center">
								<c:if test="${service.homeService==1 or service.homeService==2}">
									<i class="icon-check"></i>
								</c:if>
								<c:if test="${service.homeService==0}">
									<i class="icon-remove"></i>
								</c:if>
							</div>
						</div>
						<div class="row visible-xs"
							style="padding: 10px 0; border-bottom: 1px solid #979797;">
							<label class="col-xs-12">Gender</label>
							<div class="col-sm-3 col-xs-12 text-center">
								<c:if test="${service.gender==1}">
									<i class="icon-female"></i>
								</c:if>
								<c:if test="${service.gender==0}">
									<i class="icon-male"></i>
								</c:if>
								<c:if test="${service.gender==2}">
									<i class="icon-male"></i>
									<i class="icon-female"></i>
								</c:if>
							</div>
						</div>
						<div class="row visible-xs"
							style="padding: 10px 0; border-bottom: 2px solid #333;">
							<label class="col-xs-12">Price</label>
							<div class="col-sm-3 col-xs-12">INR ${service.price}/-</div>
						</div>
					</c:forEach>
				</div>
				<div class="modal-footer nopadding"
					style="background-color: #1fbbad; color: #fff;">
					<center>
						<button type="button" class="signup-button font-size-16 font-type"
							data-dismiss="modal">Close</button>
					</center>
				</div>
			</div>
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
	function toggle(stat){
		if(stat){
			document.getElementById("rad").style.cssText = "visibility:visible !important;";
		}else{
			document.getElementById("rad").style.cssText = "display:none";
			document.getElementById("serviceRadius").value='';
		}
		
	}
	function deleteImage(imageid, image){
		if(confirm('Are you sure you want to delete?')){
        $.ajax( "deleteMenuImage?imageId="+imageid )
        .done(function() {
          $(image).parent("div").remove();
        })
        .fail(function() {
          alert( "error" );
        });
		}
        }
    
    $('.header-services').addClass('active');
  </script>
</body>
</html>
