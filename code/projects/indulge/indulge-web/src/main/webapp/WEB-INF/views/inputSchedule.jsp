<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib  prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<head>
<jsp:include page="../views/globalhead.jsp" />
<link href="${pageContext.servletContext.contextPath }/css/new.css"
	rel="stylesheet">
<script
	src="${pageContext.servletContext.contextPath }/js/jquery-ui.min.js"></script>
<link
	href="${pageContext.servletContext.contextPath }/css/jquery-ui.min.css"
	rel="stylesheet">
<link
	href="${pageContext.servletContext.contextPath }/css/jquery.nouislider.pips.min.css"
	rel="stylesheet">
</head>
<body style="background-color: #f0f0f0;">
<div class="container-fluid" style="background-color:#f0f0f0">
	<div class="row">
		<div class="col-xs-22 col-sm-14 col-md-12 col-lg-10 col-xs-push-1 col-sm-push-5 col-md-push-6 col-lg-push-7">
    		<div class="row font-type sign-up font-size-24" style="color:#ddcbbd; padding-top:10px; padding-bottom:10px">We make sure that your clients never have to be turned away.</div>
    		<ol class="progress-meter">
    			<li class="progress-point done">Basic</li><li class="progress-point done">Address</li><li class="progress-point done">Contacts</li><li class="progress-point doing">Schedule</li><li class="progress-point todo">Photos</li>
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
    		
    		<form:form method="POST" action="saveSchedule"
					modelAttribute="schedule" onsubmit="return validateForm();"
					class="form-horizontal white-bg" id="creatMerchantForm"
					style="margin-top:15px;margin-bottom:15px;padding-bottom:30px">
					<div class="row row15 font-size-20 location-head font-type"
						style="background-color: #1fbbad; margin-bottom: 15px; text-align: center">
						Enter Availability Details</div>
					<center>
						<div class="btn-group" id="weekdays" data-toggle="buttons"
							style="margin-bottom: 20px">
							<label class="btn btn-default day-pill font-size-20"> <input
								type="checkbox" checked="">Sun
							</label> <label class="btn btn-default day-pill font-size-20"> <input
								type="checkbox" checked="">Mon
							</label> <label class="btn btn-default day-pill font-size-20"> <input
								type="checkbox" checked="">Tue
							</label> <label class="btn btn-default day-pill font-size-20"> <input
								type="checkbox" checked="">Wed
							</label> <label class="btn btn-default day-pill font-size-20"> <input
								type="checkbox" checked="">Thur
							</label> <label class="btn btn-default day-pill font-size-20"> <input
								type="checkbox" checked="">Fri
							</label> <label class="btn btn-default day-pill font-size-20"> <input
								type="checkbox" checked="">Sat
							</label>
						</div>
						<form:input path="schedule[0].weekSchedule" type="hidden"
							id="scheduleval0" />
						<form:input path="schedule[1].weekSchedule" type="hidden"
							id="scheduleval1" />
						<form:input path="schedule[0].closingTime" type="hidden"
							id="closingTime0" value="20:00" />
						<form:input path="schedule[0].openingTime" type="hidden"
							id="openingTime0" value="7:00" />
						<form:input path="schedule[1].closingTime" type="hidden"
							id="closingTime1" />
						<form:input path="schedule[1].openingTime" type="hidden"
							id="openingTime1" />
					</center>
					<div class="row row-15">
						<div class="col-xs-9 col-xs-push-2 font-size-24"
							style="text-align: center">
							Opening Time
						</div>
						<div class="col-xs-9 col-xs-push-5 font-size-24"
							style="text-align: center">
							Closing Time
						</div>
					</div>
					<div class="select-time">
					<div class="col-xs-9 col-xs-push-3 font-size-20">
						<select id="openingTime1Select">
						<option value="7:00">7:00 AM</option>
						<option value="7:30">7:30 AM</option>
						<option value="8:00">8:00 AM</option>
						<option value="8:30">8:30 AM</option>
						<option value="9:00">9:00 AM</option>
						<option value="9:30">9:30 AM</option>
						<option value="10:00">10:00 AM</option>
						<option value="10:30">10:30 AM</option>
						<option value="11:00">11:00 AM</option>
						<option value="11:30">11:30 AM</option>
						<option value="12:00">12:00 AM</option>
						<option value="01:00">1:00 PM</option>
						<option value="01:30">1:30 PM</option>
						<option value="02:00">2:00 PM</option>
						<option value="02:30">2:30 PM</option>
						<option value="03:00">3:00 PM</option>
						<option value="03:30">3:30 PM</option>
						<option value="04:00">4:00 PM</option>
						<option value="04:30">4:30 PM</option>
						<option value="05:00">5:00 PM</option>
						<option value="05:30">5:30 PM</option>
						<option value="06:00">6:30 PM</option>
						<option value="06:30">6:30 PM</option>
						<option value="07:00">7:00 PM</option>
						<option value="07:30">7:30 PM</option>
						<option value="08:00">8:00 PM</option>
						<option value="08:30">8:30 PM</option>
						<option value="09:00">9:00 PM</option>
						<option value="09:30">9:30 PM</option>
						<option value="10:00">10:00 PM</option>
						<option value="10:30">10:30 PM</option>
						<option value="11:00">11:00 PM</option>
						</select>
					</div>
					<div class="col-xs-9 col-xs-push-7 font-size-20">
						<select name="closingTime" id="closingTime1Select">
						<option value="7:00">7:00 AM</option>
						<option value="7:30">7:30 AM</option>
						<option value="8:00">8:00 AM</option>
						<option value="8:30">8:30 AM</option>
						<option value="9:00">9:00 AM</option>
						<option value="9:30">9:30 AM</option>
						<option value="10:00">10:00 AM</option>
						<option value="10:30">10:30 AM</option>
						<option value="11:00">11:00 AM</option>
						<option value="11:30">11:30 AM</option>
						<option value="12:00">12:00 AM</option>
						<option value="01:00">1:00 PM</option>
						<option value="01:30">1:30 PM</option>
						<option value="02:00">2:00 PM</option>
						<option value="02:30">2:30 PM</option>
						<option value="03:00">3:00 PM</option>
						<option value="03:30">3:30 PM</option>
						<option value="04:00">4:00 PM</option>
						<option value="04:30">4:30 PM</option>
						<option value="05:00">5:00 PM</option>
						<option value="05:30">5:30 PM</option>
						<option value="06:00">6:30 PM</option>
						<option value="06:30">6:30 PM</option>
						<option value="07:00">7:00 PM</option>
						<option value="07:30">7:30 PM</option>
						<option value="08:00">8:00 PM</option>
						<option value="08:30">8:30 PM</option>
						<option value="09:00">9:00 PM</option>
						<option value="09:30">9:30 PM</option>
						<option value="10:00">10:00 PM</option>
						<option value="10:30">10:30 PM</option>
						<option value="11:00">11:00 PM</option>
						</select>
					</div>
					</div>
					

					<div class="row row15">
						<div class="col-xs-12 col-xs-push-3">
							<input type="button" value="+ Add Another Time Slot"
								class="time-slot" onclick="timeslotadd()" id="addtimebtn">
						</div>
					</div>

					<div id="additional-time" style="display: none">
						<center>
							<div class="btn-group" id="weekdaysadd" data-toggle="buttons"
								style="margin-bottom: 20px; margin-top: 30px">
								<label class="btn btn-default day-pill font-size-20"> <input
									type="checkbox" checked="">Sun
								</label> <label class="btn btn-default day-pill font-size-20"> <input
									type="checkbox" checked="">Mon
								</label> <label class="btn btn-default day-pill font-size-20"> <input
									type="checkbox" checked="">Tue
								</label> <label class="btn btn-default day-pill font-size-20"> <input
									type="checkbox" checked="">Wed
								</label> <label class="btn btn-default day-pill font-size-20"> <input
									type="checkbox" checked="">Thur
								</label> <label class="btn btn-default day-pill font-size-20"> <input
									type="checkbox" checked="">Fri
								</label> <label class="btn btn-default day-pill font-size-20"> <input
									type="checkbox" checked="">Sat
								</label>
							</div>
						</center>
						<div class="row row-15">
							<div class="col-xs-9 col-xs-push-2 font-size-24"
								style="text-align: center">Opening Time</div>
							<div class="col-xs-9 col-xs-push-5 font-size-24"
								style="text-align: center">Closing Time</div>
						</div>
						<div class="select-time">
					<div class="col-xs-9 col-xs-push-3 font-size-20">
						<select id="openingTime2Select">
						<option value="7:00">7:00 AM</option>
						<option value="7:30">7:30 AM</option>
						<option value="8:00">8:00 AM</option>
						<option value="8:30">8:30 AM</option>
						<option value="9:00">9:00 AM</option>
						<option value="9:30">9:30 AM</option>
						<option value="10:00">10:00 AM</option>
						<option value="10:30">10:30 AM</option>
						<option value="11:00">11:00 AM</option>
						<option value="11:30">11:30 AM</option>
						<option value="12:00">12:00 AM</option>
						<option value="13:00">1:00 PM</option>
						<option value="13:30">1:30 PM</option>
						<option value="14:00">2:00 PM</option>
						<option value="14:30">2:30 PM</option>
						<option value="15:00">3:00 PM</option>
						<option value="15:30">3:30 PM</option>
						<option value="16:00">4:00 PM</option>
						<option value="16:30">4:30 PM</option>
						<option value="17:00">5:00 PM</option>
						<option value="17:30">5:30 PM</option>
						<option value="18:00">6:30 PM</option>
						<option value="18:30">6:30 PM</option>
						<option value="19:00">7:00 PM</option>
						<option value="19:30">7:30 PM</option>
						<option value="20:00">8:00 PM</option>
						<option value="20:30">8:30 PM</option>
						<option value="21:00">9:00 PM</option>
						<option value="21:30">9:30 PM</option>
						<option value="22:00">10:00 PM</option>
						<option value="22:30">10:30 PM</option>
						<option value="23:00">11:00 PM</option>
						</select>
						</div>
						<div class="col-xs-9 col-xs-push-7 font-size-20">
						<select id="closingTime2Select">
						<option value="7:00">7:00 AM</option>
						<option value="7:30">7:30 AM</option>
						<option value="8:00">8:00 AM</option>
						<option value="8:30">8:30 AM</option>
						<option value="9:00">9:00 AM</option>
						<option value="9:30">9:30 AM</option>
						<option value="10:00">10:00 AM</option>
						<option value="10:30">10:30 AM</option>
						<option value="11:00">11:00 AM</option>
						<option value="11:30">11:30 AM</option>
						<option value="12:00">12:00 AM</option>
						<option value="13:00">1:00 PM</option>
						<option value="13:30">1:30 PM</option>
						<option value="14:00">2:00 PM</option>
						<option value="14:30">2:30 PM</option>
						<option value="15:00">3:00 PM</option>
						<option value="15:30">3:30 PM</option>
						<option value="16:00">4:00 PM</option>
						<option value="16:30">4:30 PM</option>
						<option value="17:00">5:00 PM</option>
						<option value="17:30">5:30 PM</option>
						<option value="18:00">6:30 PM</option>
						<option value="18:30">6:30 PM</option>
						<option value="19:00">7:00 PM</option>
						<option value="19:30">7:30 PM</option>
						<option value="20:00">8:00 PM</option>
						<option value="20:30">8:30 PM</option>
						<option value="21:00">9:00 PM</option>
						<option value="21:30">9:30 PM</option>
						<option value="22:00">10:00 PM</option>
						<option value="22:30">10:30 PM</option>
						<option value="23:00">11:00 PM</option>
						</select>
						</div>
					</div>
					</div>
					<center>
						<input type="submit" value="Save and Next"
							class="signup-button font-size-16 font-type white-text">
						<div class="white-bg col-md-22 col-lg-22 col-xs-22 col-sm-22"
							style="text-align: right">
							<a class="font-size-16 font-type" href="inputPhoto"><u>Skip
									this step</u></a>
						</div>
					</center>
				</form:form>
			</div>
				
					

				
				
  		</div>
  	</div>
<div id="soft"></div>

<script type="text/javascript">
		$('input:checkbox').removeAttr('checked');
		$("#weekdays").change(function(e) {
			var checkedDays = $("#weekdays :checkbox").map(function() {
				return +$(this).is(':checked');
			}).get();

			$("input#scheduleval0").val(checkedDays.join(""));
			if ($("input#scheduleval0").val() == '1111111') {
				$('#additional-time').css("display", "none");
				$('#addtimebtn').css("display", "none");
			} else {
				$('#addtimebtn').css("display", "block");
			}
		});

		$('#toggler').on(
				'click',
				function() {
					console.log($('#weekdays label').eq(0).button('toggle')
							.find(':checkbox').prop('checked') // toggles t/f
					);
				});
	</script>
	<script type="text/javascript">
		$("#weekdaysadd").change(function(e) {
			var checkedDays = $("#weekdaysadd :checkbox").map(function() {
				return +$(this).is(':checked');
			}).get();

			$("input#scheduleval1").val(checkedDays.join(""));
		});

		$('#toggler').on(
				'click',
				function() {
					console.log($('#weekdaysadd label').eq(0).button('toggle')
							.find(':checkbox').prop('checked') // toggles t/f
					);
				});
	</script>

	<script type="text/javascript">
		function timeslotadd() {
			document.getElementById("additional-time").style.cssText = "visibility:visible !important;";
			document.getElementById("addtimebtn").style.cssText = "display:none !important;";
		}

		function validateForm() {
			$("input[id=openingTime0]").val($( "#openingTime1Select option:selected" ).val());
			$("input[id=openingTime1]").val($( "#openingTime2Select option:selected" ).val());
			$("input[id=closingTime0]").val($( "#closingTime1Select option:selected" ).val());
			$("input[id=closingTime1]").val($( "#closingTime2Select option:selected" ).val());
			if (document.getElementById('scheduleval0').value == '') {
				alert("Please select weekdays.");
				return false;
			}
			if (document.getElementById('scheduleval1') != "undefined"
					&& document.getElementById('scheduleval1').value != ''
					&& document.getElementById('scheduleval0').value != '') {
				var arr = document.getElementById('scheduleval0').value
						.split("");
				var arr1 = document.getElementById('scheduleval1').value
						.split("");
				for ( var i = 0; i < arr.length; i++) {
					if (arr[i] == '1' && arr1[i] == '1') {
						alert('Please check schedule days. You cannot have different schedule for any weekday');
						return false;
					}
				}
			}

			return true;
		}

		$(document).ready(function() {

			$('.ui-slider-handle').height(25);
			$('.ui-slider-handle').width(30);
			$('.ui-slider-horizontal').height(15);

		});
	</script>


</body>
</html>
