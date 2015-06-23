<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<head>
<jsp:include page="../views/globalhead.jsp" />
<script
	src="${pageContext.servletContext.contextPath }/js/jquery.nouislider.all.min.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<link href="${pageContext.servletContext.contextPath }/css/new.css"
	rel="stylesheet">
<link
	href="${pageContext.servletContext.contextPath }/css/jquery.nouislider.css"
	rel="stylesheet">
<link
	href="${pageContext.servletContext.contextPath }/css/jquery.nouislider.pips.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
</head>
<body style="background-color: #f0f0f0">
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

	<div
		class="col-xs-22 col-sm-20 col-md-16 col-lg-14 col-xs-push-1 col-sm-push-2 col-md-push-4 col-lg-push-5">
		<div class="row font-type sign-up font-size-24"
			style="color: #8B7973;">Post A New Deal</div>
		<form:form action="saveDeal" method="post" id="createDealForm"
			modelAttribute="deal" class="form-horizontal"
			style="margin-bottom:10px; margin-top:20px">
			<div id="viewservices">
				<center>
					<ol class="progress-meter">
						<li class="progress-point doing">Services</li>
						<li class="progress-point todo">Price</li>
						<li class="progress-point todo">Validity</li>
						<li class="progress-point todo">Confirmation</li>
					</ol>
				</center>
				<c:if test="${categories ne null and not empty categories}">
					<div class="row row15" style="margin-top: 35px;">
						<center>
							<div class="row row15 font-size-24"
								style="padding: 10px; text-align: center; color: #fff; background-color: #1fbbad">
								Select Services</div>
						</center>
					</div>
					<div class="row row15 services_input white-bg">
						<div class="col-xs-12 font-size-20" style="padding: 0px">
							<input type="button" id="Choose_cat" onclick="showcategories()"
								value="Choose complete categories" class="active">
						</div>
						<div class="col-xs-12 font-size-20" style="padding: 0px">
							<input type="button" id="Choose_serve" onclick="showservices()"
								value="Choose individual services">

						</div>
					</div>
					<div class="row row15 white-bg" id="categories"
						style="min-height: 200px">
						<c:forEach var="category" items="${categories}" varStatus="stats">
							<c:forEach var="serviceCat" items="${uniqueCategory}"
								varStatus="status">
								<c:if test="${serviceCat == category.id}">

									<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 text-center"
										style="margin: 10px 0;">
										<div class="btn-group" id="cats" data-toggle="buttons"
											style="width: 100%">
											<label class="btn btn-default"
												style="width: 30%; padding: 0px; height: 60px; vertical-align: middle; border: none; margin-left: 34%; border-radius: 50px !important">
												<input type="checkbox" value="${category.id}"
												name="categoryId"><img
												src="../images/${category.image}" height="50px"
												style="margin-top: 5px; margin-bottom: 5px;">
											</label>
										</div>
										<span class="text-uppercase brown-text">${category.name}</span>
									</div>
								</c:if>
							</c:forEach>
						</c:forEach>
					</div>

					<div class="row row15 white-bg" id="services" style="display: none">
						<div class="col-md-18 col-md-push-3 ptb-10">
							<input id="browser1inp" type="text"
								class="form-control postdeal-field"
								placeholder="Enter Service or Service Type">
						</div>
						<div class="col-md-18 col-md-push-3 ptb-10">
							<input id="browser2inp" type="text"
								class="form-control postdeal-field"
								placeholder="Enter Service or Service Type">
						</div>
						<div class="col-md-18 col-md-push-3 ptb-10">
							<input id="browser3inp" type="text"
								class="form-control postdeal-field"
								placeholder="Enter Service or Service Type">
						</div>
					</div>
				</c:if>
				<center style="padding: 20px 0;" class=" white-bg">
					<input type="button" onclick="submitservice()"
						class="btn btn-lg btn-green text-uppercase" value="Save and Next">
				</center>
				<input type="hidden" id="servicetype1" name="serviceTypeId">
				<input type="hidden" id="servicetype2" name="serviceTypeId">
				<input type="hidden" id="servicetype3" name="serviceTypeId">
				<input type="hidden" id="service1" name="serviceId"> <input
					type="hidden" id="service2" name="serviceId"> <input
					type="hidden" id="service3" name="serviceId">
			</div>
			<div id="enteramount" style="display: none">
				<center>
					<ol class="progress-meter">
						<li class="progress-point done">Services</li>
						<li class="progress-point doing">Price</li>
						<li class="progress-point todo">Validity</li>
						<li class="progress-point todo">Confirmation</li>
					</ol>
				</center>
				<c:if test="${categories ne null and not empty categories}">
					<div class="row row15">
						<center>
							<div class="row row15 font-size-24"
								style="padding: 10px; text-align: center; color: #fff; background-color: #1fbbad">
								Select Services</div>
						</center>
					</div>
					<div class="col-sm-24 white-bg" style="min-height: 200px;">
						<div class="form-group ptb-10">
							<label class="col-sm-7 control-label">Flat Off (in Rs)*</label>
							<div class="col-sm-15">
								<input id="flatOff" class="form-control signup-field"
									type="text" name="flatOff" onblur="testField(this);">
							</div>
						</div>
						<div class="form-group ptb-10">
							<label class="col-sm-7 control-label">Percent Off (in %)*</label>
							<div class="col-sm-15">
								<input id="percentOff" class="form-control signup-field"
									type="text" name="percentOff" onblur="testField(this);">
							</div>
						</div>
					</div>
				</c:if>
				<center class="white-bg" style="padding-bottom: 25px;">
					<input type="button" onclick="return submitamount();"
						class="btn btn-lg btn-green text-uppercase" value="Save and Next">
				</center>
			</div>
			<div id="entervalidity" style="display: none">
				<center>
					<ol class="progress-meter">
						<li class="progress-point done">Services</li>
						<li class="progress-point done">Price</li>
						<li class="progress-point doing">Validity</li>
						<li class="progress-point todo">Confirmation</li>
					</ol>
				</center>
				<div class="white-bg">
					<c:if test="${categories ne null and not empty categories}">
						<div class="row row15">
							<center>
								<div class="row row15 font-size-24"
									style="padding: 10px; text-align: center; color: #fff; background-color: #1fbbad">
									Select Services</div>
							</center>
						</div>
						<div class="row"
							style="border-bottom: 1px dashed #333; margin: 0; padding-bottom: 15px;">
							<div class="form-group col-sm-12 ptb-10" style="margin: 0;">
								<div class="col-xs-8">
									<input type="radio" class="form-control"
										style="box-shadow: none;" name="recurring" value="false"
										id="onetime" onclick="hidedaypill()">
								</div>
								<label for="onetime"
									class="control-label col-sm-14 font-size-20 brown-text"
									style="text-align: left">One - Time</label>
							</div>
							<div class="form-group col-sm-12 ptb-10" style="margin: 0;">
								<div class="col-xs-8">
									<input type="radio" class="form-control"
										style="box-shadow: none;" name="recurring" value="true"
										id="everytime" onclick="showdaypill()" checked="checked">
								</div>
								<label for="everytime"
									class="control-label col-sm-14 font-size-20 brown-text"
									style="text-align: left">Recurring</label>
							</div>
							<div class="col-sm-12 text-center text-green font-size-16">
								Single time period<br> eg dec 24 2-4pm
							</div>
							<div class="col-sm-12 text-center text-green font-size-16">
								Multiple time slots<br> eg thur 2-4pm
							</div>
						</div>
						<div class="row row15">
							<center>
								<div class="btn-group" id="weekdays" data-toggle="buttons"
									style="margin-top: 30px; margin-bottom: 30px">
									<label class="btn btn-default day-pill font-size-20"> <input
										type="checkbox">Sun
									</label> <label class="btn btn-default day-pill font-size-20">
										<input type="checkbox">Mon
									</label> <label class="btn btn-default day-pill font-size-20">
										<input type="checkbox">Tue
									</label> <label class="btn btn-default day-pill font-size-20">
										<input type="checkbox">Wed
									</label> <label class="btn btn-default day-pill font-size-20">
										<input type="checkbox">Thur
									</label> <label class="btn btn-default day-pill font-size-20">
										<input type="checkbox">Fri
									</label> <label class="btn btn-default day-pill font-size-20">
										<input type="checkbox">Sat
									</label>
								</div>
								<input id="days" type="hidden" name="days">
							</center>
						</div>
						<div class="row row-15">
							<div class="col-xs-9 col-xs-push-2 font-size-20 ptb-10"
								style="text-align: center">
								<div class="row row15">Opening Time</div>
								<div class="row row15" id="lower-value">7:00 AM</div>
							</div>
							<div class="col-xs-9 col-xs-push-5 font-size-20 ptb-10"
								style="text-align: center">
								<div class="row row15">Closing Time</div>
								<div class="row row15" id="upper-value">11:00 PM</div>
							</div>
						</div>
						<input type="hidden" id="openingtime" value="10:00">
						<input type="hidden" id="closingtime" value="20:00">
						<div class="col-md-18 col-md-push-3 ptb-10" id="slide"
							style="margin-bottom: 25px;">
							<div id="behaviour" style="margin-bottom: 40px;"></div>
						</div>

						<div class="form-group ptb-10">
							<label class="col-sm-9 control-label">Valid From*</label>
							<div class="col-sm-14">
								<input type='text' style="width: 50%; margin-right: 15px;"
									id='fromDate' class="form-control pull-left signup-field"
									style="margin-right:15px" readonly /> <input type="hidden"
									name="validFrom" id="validFrom">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-9 control-label">Valid Till*</label>
							<div class="col-sm-14">
								<input id="tillDate" style="width: 50%; margin-right: 15px;"
									class="form-control pull-left signup-field" type="text"
									readonly /> <input type="hidden" name="validTill"
									id="validTill">
							</div>
						</div>
					</c:if>
					<center style="padding-bottom: 25px; padding-top: 20px;">
						<input type="submit" onclick="return appendtry();"
							class="btn btn-lg btn-green text-uppercase" value="Save and Next">
					</center>
				</div>
			</div>
		</form:form>
	</div>
	<script type="text/javascript">
		function showcategories() {
			$("#categories").css("display", "block");
			$("#Choose_cat").addClass("active");
			$("#services").css("display", "none");
			$("#Choose_serve").removeClass("active");

		}
		function showservices() {
			$("#categories").css("display", "none");
			$("#Choose_serve").addClass("active");
			$("#Choose_cat").removeClass("active");
			$("#services").css("display", "block");
			$('#categories input[type=checkbox]').attr('checked', false);
		}
		function showchecked() {
			var checkedValues = $('input:checkbox:checked').map(function() {
				return this.value;
			}).get().length;
		}
		function submitservice() {

			var checkedValues = $('input:checkbox:checked').map(function() {
				return this.value;
			}).get().length;
			var value1 = $('#browser1inp').val();
			var value2 = $('#browser2inp').val();
			var value3 = $('#browser3inp').val();
			if (value1 == '' && value2 == '' && value3 == ''
					&& checkedValues == 0) {
				alert("Please enter atleast one service or select one category");
				return false;
			}
			if ((value1 != '' && value2 != '' && value3 != '') && (value1 == value2 || value1 == value3 || value1 == value2) ) {
			alert("Please select different services.");
			return false;
		}
			$("#viewservices").css("display", "none");
			$("#enteramount").css("display", "block");
		}
		function submitamount() {
			if ($("#flatOff").val().trim() == ''
					&& $("#percentOff").val().trim() == '') {
				alert("Please enter flat off or percent off");
				return false;
			}
			if ($("#flatOff").val().trim() != ''
					&& $("#percentOff").val().trim() != '') {
				alert("Please enter either flat off or percent off");
				return false;
			}
			$("#enteramount").css("display", "none");
			$("#entervalidity").css("display", "block");
		}
	</script>
	<script type="text/javascript">
		$("#weekdays").change(function(e) {
			var checkedDays = $("#weekdays :checkbox").map(function() {
				return +$(this).is(':checked');
			}).get();

			console.log(checkedDays.join(""));
			$("#days").val(checkedDays.join(""));
		});

		$('#toggler').on(
				'click',
				function() {
					console.log($('#weekdays label').eq(0).button('toggle')
							.find(':checkbox').prop('checked') // toggles t/f
					);
				});
		function showdaypill() {
			$("#weekdays").show();
		}

		function hidedaypill() {
			$("#weekdays").hide();
		}
	</script>
	<script type="text/javascript">
		$("#behaviour").noUiSlider({
			start : [ 7, 23 ],
			step : .5,
			behaviour : 'step',
			connect : true,
			range : {
				'min' : 6,
				'max' : 24
			}
		});
		$("#behaviour").on({
            slide: function() {
					var lowerTime = $("#behaviour").val()[0].split(".");
					if(lowerTime[1] == 50){
						lowerTime[1] = 30;
					}
					$("#openingtime").val(
							lowerTime[0]+":"+lowerTime[1]);
					
					if (lowerTime[0] >= 12) {
						if (lowerTime[0] > 12) {
						lowerTime[0] = lowerTime[0] - 12;
						}
						
						$('#lower-value').text(
								lowerTime[0] + ":" + lowerTime[1] + " PM");
					} else {
						$('#lower-value').text(
								lowerTime[0] + ":" + lowerTime[1] + " AM");
					}

					var upperTime = $("#behaviour").val()[1].split(".");
					if(upperTime[1] == 50){
						upperTime[1] = 30;
					}
					$("#closingtime").val(
							upperTime[0]+":"+upperTime[1]);
					if (upperTime[0] >= 12) {
						if (upperTime[0] > 12) {
							upperTime[0] = upperTime[0] - 12;
						}
						$('#upper-value').text(
								upperTime[0] + ":" + upperTime[1] + " PM");
					} else {
						$('#upper-value').text(
								upperTime[0] + ":" + upperTime[1] + " AM");
					}
					
					
				}});
		function filter500(value, type) {
			return value % 1 !=0 ? 0 : 1;
		}

		$("#behaviour").noUiSlider_pips({
			mode : 'steps',
			density : 1,
			filter : filter500,
			format : wNumb({
				decimals : 0,
			})
		});

		// Do the same for the upper handle.
	</script>
	<script type="text/javascript">
		$(document)
				.ready(
						function() {

							$("#fromDate").datepicker({
												showOn : 'button',
												buttonText : 'Show Date',
												buttonImageOnly : true,
												buttonImage : 'http://jqueryui.com/resources/demos/datepicker/images/calendar.gif',
												dateFormat : 'dd/mm/yy',
												constrainInput : true
											});

							$(".ui-datepicker-trigger").mouseover(function() {
								$(this).css('cursor', 'pointer');
							});

						});
	</script>
	<script type="text/javascript">
		$(document)
				.ready(
						function() {

							$("#tillDate")
									.datepicker(
											{
												showOn : 'button',
												buttonText : 'Show Date',
												buttonImageOnly : true,
												buttonImage : 'http://jqueryui.com/resources/demos/datepicker/images/calendar.gif',
												dateFormat : 'dd/mm/yy',
												constrainInput : true
											});

							$(".ui-datepicker-trigger").mouseover(function() {
								$(this).css('cursor', 'pointer');
							});

						});
	</script>
	<script type="text/javascript">
		function appendtry() {
			if ($("#fromDate").val() == '' || $("#tillDate").val() == '') {
				alert("Please select valid dates");
				return false;
			}
			var start = parseDate($("#fromDate").val());
			var endDate = parseDate($("#tillDate").val());
			var today = new Date();
			today.setHours(0, 0, 0, 0);
			if (start < today || endDate < today) {
				alert("Start/End date cannot be before current date.");
				return false;
			}
			if (start > endDate || start == endDate) {
				alert("Start date should be less than end date.");
				return false;
			}
			if ($('input:radio[name=recurring]:checked').val() == 'true') {
				if ($("#days").val() == '') {
					alert("Please select weekdays");
					return false;
				}
			}
			$("#validFrom").val(
					$("#fromDate").val() + " " + $("#openingtime").val());
			$("#validTill").val(
					$("#tillDate").val() + " " + $("#closingtime").val());
			return true;
		}

		function parseDate(str1) {
			// str1 format should be dd/mm/yyyy. Separator can be anything e.g. / or -. It wont effect
			var dt1 = parseInt(str1.substring(0, 2));
			var mon1 = parseInt(str1.substring(3, 5));
			var yr1 = parseInt(str1.substring(6, 10));
			var date1 = new Date(yr1, mon1 - 1, dt1);
			return date1;
		}
	</script>
<script type="text/javascript">
function testField(field) {
    var regExpr = new RegExp("^[0-9]+$");
    if (!regExpr.test(field.value)) {
      alert("Please enter a numeric value only!!");
      field.value = "";
    }
}


$(function() {
  	var availableTags = [
<c:forEach var="category" items="${categories}" varStatus="stat">
<c:forEach var="service" items="${category.services}"
	varStatus="state">
	<c:forEach var="serviceCat" items="${uniqueService}"
		varStatus="status">
		<c:if test="${serviceCat == service.id}">
		{key: "${service.id}" , value:"${service.name} - All" },
			<c:forEach var="serviceType" items="${services}"
				varStatus="serviceStatus">
				<c:if test="${service.id==serviceType.serviceId}">
					{key: "${serviceType.id}" , value:"${serviceType.name}" },
					</c:if>
			</c:forEach>
		</c:if>
	</c:forEach>
</c:forEach>
</c:forEach>
];
  	
  	$( "#browser1inp" ).autocomplete({
        minLength: 0,
        source: availableTags,
        focus: function( event, ui ) {
          $( "#browser1inp" ).val( ui.item.value );
          return false;
        },
        select: function( event, ui ) {
          $( "#browser1inp" ).val( ui.item.value );
          var keyVal = ui.item.value;
          if(keyVal.indexOf('All') != -1){
        	  $( "#service1" ).val( ui.item.key);
          }else{
          	$( "#servicetype1" ).val( ui.item.key);
          }
          return false;
        } 
  	  });
   
  	$( "#browser2inp" ).autocomplete({
        minLength: 0,
        source: availableTags,
        focus: function( event, ui ) {
          $( "#browser2inp" ).val( ui.item.value );
          return false;
        },
        select: function( event, ui ) {
          $( "#browser2inp" ).val( ui.item.value );
          var keyVal = ui.item.value;
          if(keyVal.indexOf('All') != -1){
        	  alert(ui.item.key);
        	  $( "#service2" ).val( ui.item.key);
          }else{
          	$( "#servicetype2" ).val( ui.item.key);
          }
          return false;
        } 
  	  });
  	$( "#browser3inp" ).autocomplete({
        minLength: 0,
        source: availableTags,
        focus: function( event, ui ) {
          $( "#browser3inp" ).val( ui.item.value );
          return false;
        },
        select: function( event, ui ) {
          $( "#browser3inp" ).val( ui.item.value );
          var keyVal = ui.item.value;
          alert(keyVal);
          if(keyVal.indexOf('All') != -1){
        	  
        	  $( "#service3" ).val( ui.item.key);
          }else{
          	$( "#servicetype3" ).val( ui.item.key);
          }
          return false;
        } 
  	  });
    });
</script>

</body>
</html>
