<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">
<html lang="en">
<head>
<jsp:include page="../views/globalhead.jsp" />
</head>
<body>

	<!--1fbbad ddcbbd f0f0f0-->

	<div class="container-fluid" style="background-color: #f0f0f0">
		<div class="row">
			<center>
				<div
					class="col-xs-22 col-sm-14 col-md-12 col-lg-10 col-xs-push-1 col-sm-push-5 col-md-push-6 col-lg-push-7">
					<div class="row font-type sign-up font-size-32"
						style="color: #ddcbbd">Sign Up</div>
					<div class="row"
						style="padding-top: 8px; margin: 15px 0px 0px 0px; background-color: #ddcbbd"></div>
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
					<form:form method="POST" action="saveMerchantBasicProfile"
						modelAttribute="merchant" class="form-horizontal white-bg"
						id="creatMerchantForm" style="padding-top:15px">
						<div style="width: 70%" class="registration-page">
							<center>
								<div class="input-group" id="signup1">
									<span class="input-group-addon"> <i class="icon-user"></i>
									</span> <input id="name" class="form-control" type="text" name="name"
										placeholder="Merchant Name" value="${merchant.name}">
								</div>


								<div class="input-group">
									<span class="input-group-addon"> <i class="icon-globe"></i>
									</span> <input type="text" name="city" class="form-control" id="city"
										placeholder="City" list="browser" value="${merchant.city}">
									<datalist id="browser">
										<c:forEach var="state" items="${states}" varStatus="status">
											<c:forEach var="city" items="${state.cities}"
												varStatus="stat">
												<div id="row">
													<option value="${city.cityName}">${city.cityName}</option>
												</div>
											</c:forEach>
										</c:forEach>
									</datalist>
								</div>


								<div class="input-group">
									<span class=" input-group-addon"> <i
										class="icon-map-marker"></i>
									</span> <input type="text" name="locality" class="form-control"
										id="locality" placeholder="Locality"
										value="${merchant.locality}">
								</div>

								<div class="input-group">
									<span class="input-group-addon"> <i class="icon-home"></i>
									</span> <select id="merchantType" name="merchantType"
										class="form-control" placeholder="Type">
										<option value="0">Merchant</option>
										<option value="1">Individual</option>
									</select>
								</div>


								<div class="input-group">
									<span class="input-group-addon"> <i
										class="icon-envelope"></i>
									</span> <input id="email" name="email" type="text"
										class="form-control" placeholder="Email Id"
										value="${merchant.email}">
								</div>

								<div class="input-group">
									<span class="input-group-addon"> <i class="icon-phone"></i>
									</span> <input id="phone" name="phone" type="text"
										class="form-control" placeholder="Phone No. e.g 0990000000"
										value="${merchant.phone}">
								</div>

								<div class="input-group">
									<span class=" input-group-addon"> <i class="icon-lock"></i>
									</span> <input id="passPhrase" type="password" name="passPhrase"
										class="form-control" placeholder="Password">
								</div>
								<div class="input-group">
									<span class="input-group-addon"> <i class="icon-link"></i>
									</span> <input id="refer" name="refer" type="text"
										class="form-control" placeholder="Referred By"
										value="${merchant.refer}">
								</div>
							</center>
						</div>
						<input type="hidden" name="state" value="Delhi" />
						<input type="hidden" name="country" value="India" />
						<div class="row font-type font-size-16 signup-terms">By
							signing up, I agree to to Indulge's Terms of Service</div>

						<input type="submit" value="Create Account"
							class="signup-button font-size-16 font-type white-text">

					</form:form>
					<div class="font-size-32 white-bg"
						style="margin-bottom: 15px; padding-top: 15px; padding-bottom: 15px">
						Already a member ? <a
							href="${pageContext.servletContext.contextPath }/merchant/login"
							style="color: #ddcbbd">Login Now.</a>
					</div>
				</div>
			</center>
		</div>
	</div>

	<!-- Bootstrap Core JavaScript -->
	<script type="text/javascript">
		function validateEmail(sEmail) {
			var filter = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
			if (filter.test(sEmail)) {
				return true;
			} else {
				return false;
			}
		}
		jQuery(function() {
			jQuery("#name")
					.validate(
							{
								expression : "if ((jQuery.trim(VAL)).length > 3 && (jQuery.trim(VAL)).length < 100) return true; else {$('div#uploading').hide(); return false;}",
								message : "Name should be greater than 3 and less than 100 Chars"
							});
			jQuery("#email")
					.validate(
							{
								expression : "if(VAL=='' || validateEmail(VAL)) return true; else {$('div#uploading').hide(); return false;}",
								message : "Please Enter the valid email address."
							});
			jQuery("#passPhrase")
					.validate(
							{
								expression : "if ((jQuery.trim(VAL)).length != 0 && (jQuery.trim(VAL)).length > 3) return true; else {$('div#uploading').hide(); return false;}",
								message : "Password can not left blank and should be greater than 3 chars."
							});

			jQuery("#phone")
					.validate(
							{
								expression : "if ((jQuery.trim(VAL)).length == 11 && jQuery.isNumeric(VAL)  ) return true; else {$('div#uploading').hide(); return false;}",
								message : "Contact number should be of 11 numeric digits"
							});
			jQuery("#city")
					.validate(
							{
								expression : "if ((jQuery.trim(VAL)).length > 3 ) return true; else {$('div#uploading').hide(); return false;}",
								message : "City can not left blank & should be a valid city."
							});
			jQuery("#locality")
					.validate(
							{
								expression : "if ((jQuery.trim(VAL)).length > 3) return true; else {$('div#uploading').hide(); return false;}",
								message : "Locality can not left blank & should be altleast 3 chars."
							});

		});
	</script>
	<script
		src="${pageContext.servletContext.contextPath }/js/bootstrap.js"></script>
	<jsp:include page="../views/includeScript.jsp" />
</body>
</html>
