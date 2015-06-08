<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">
<head>
<jsp:include page="../views/globalhead.jsp" />
<link href="${pageContext.servletContext.contextPath }/css/new.css"
	rel="stylesheet">
</head>
<body style="background-color: #f0f0f0">
	<div id="loading">
		<img
			src="${pageContext.servletContext.contextPath }/images/ajax-loader.gif"
			id="loading-image" />
	</div>

	<div class="lh20">&nbsp;</div>
	<div class="container-fluid" style="background-color: #f0f0f0">
		<div class="row">
			<center>
				<div
					class="col-xs-22 col-sm-14 col-md-12 col-lg-10 col-xs-push-1 col-sm-push-5 col-md-push-6 col-lg-push-7">

					<div class="row font-type sign-up font-size-24"
						style="color: #ddcbbd; padding-top: 10px; padding-bottom: 10px">Ensure
						that clients can get easily in touch</div>
					<ol class="progress-meter">
						<li class="progress-point done">Basic</li>
						<li class="progress-point done">Address</li>
						<li class="progress-point done">Contacts</li>
						<li class="progress-point done">Schedule</li>
						<li class="progress-point doing">Photos</li>
					</ol>
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

					<form:form method="POST" onsubmit="return validateForm();"
						action="savePhoto" modelAttribute="merchant"
						enctype="multipart/form-data" class="form-horizontal white-bg"
						id="creatMerchantForm"
						style="margin-top:15px;margin-bottom:15px;padding-bottom:30px">
						<div class="row row15 font-size-20 location-head font-type"
							style="background-color: #1fbbad; margin-bottom: 15px">Add
							photos</div>
						<div class="row row15">
							<div class="row">
								<div
									class="col-md-8 col-lg-8 col-sm-12 col-xs-24 col-md-push-8 col-lg-push-8 col-sm-push-6"
									style="height: 150px; width: 150px; margin-top: 15px">
									<div id="file-upload-cont">
										<input type="file" multiple="multiple" name="files" id="file"
											accept="image/*" />
										<div id="my-button"></div>
										<input id="overlay" />
									</div>
								</div>
							</div>
							<div class="row">
								<output id="list"></output>
							</div>
							<c:if
								test="${merchant.images ne null and  not empty merchant.images}">
								<c:forEach var="banner" items="${merchant.images}"
									varStatus="status">
									<div class="col-md-8 col-lg-6 col-sm-12 col-xs-24">
										<img
											src="${pageContext.servletContext.contextPath }/images/${banner.image}"
											style="height: 150px; width: 150px">
									</div>
								</c:forEach>
							</c:if>
						</div>
						<input type="submit" value="Save and Next"
							class="signup-button font-size-16 font-type">
						<div class="white-bg col-md-22 col-lg-22 col-xs-22 col-sm-22"
							style="text-align: right">
							<a class="font-size-16 font-type"
								href="${pageContext.servletContext.contextPath }/merchant/login"><u>Skip
									this step<u></a>
						</div>
					</form:form>
				</div>
			</center>
		</div>
	</div>

	<script type="text/javascript">
		function validateForm() {
			var f = document.getElementById("file");
			if ("" == f.value) {
				alert("Please select atleast one image to upload.");
				return false;
			}
			showLoader();
			return true;
		}
		jQuery(document)
				.ready(
						function() {
							jQuery("#file-upload-cont")
									.hover(
											function() {
												jQuery("#my-button")
														.css("background",
																"url('../images/inputDigitalMenu.png') center center no-repeat");
											},
											function() {
												jQuery("#my-button")
														.css("background",
																"url('../images/inputDigitalMenu.png') center center no-repeat");
											}

									);
						});
	</script>
	<script>
		$('#loading').hide();
		function showLoader() {
			$('#loading').show();
		}
		function handleFileSelect(evt) {
			var files = evt.target.files; // FileList object

			// Loop through the FileList and render image files as thumbnails.
			for ( var i = 0, f; f = files[i]; i++) {

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
						span.innerHTML = [ '<img class="col-md-8 thumb" src="',
								e.target.result, '" title="',
								escape(theFile.name), '"/>' ].join('');
						document.getElementById('list')
								.insertBefore(span, null);
					};
				})(f);

				// Read in the image file as a data URL.
				reader.readAsDataURL(f);
			}
		}
		document.getElementById('file').addEventListener('change',
				handleFileSelect, false);
	</script>


</body>
</html>
