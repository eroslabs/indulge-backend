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
    <link href='http://fonts.googleapis.com/css?family=Raleway:400,300,500,200,600,700' rel='stylesheet' type='text/css'>
    <link href="${pageContext.servletContext.contextPath }/css/merchant.css" rel="stylesheet" />
    <link href="${pageContext.servletContext.contextPath }/font-awesome/css/font-awesome.min.css" rel="stylesheet" />
    <link href="${pageContext.servletContext.contextPath }/css/new.css" rel="stylesheet" >
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="${pageContext.servletContext.contextPath }/js/jquery-1.11.1.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="${pageContext.servletContext.contextPath }/js/bootstrap.min.js"></script>
    <script src="${pageContext.servletContext.contextPath }/js/jquery.validate.js"></script>


    <script src="${pageContext.servletContext.contextPath }/js/jquery.nouislider.all.min.js"></script>
	<link href="${pageContext.servletContext.contextPath }/css/jquery.nouislider.css" rel="stylesheet">
	<link href="${pageContext.servletContext.contextPath }/css/jquery.nouislider.pips.min.css" rel="stylesheet">
  </head>
<body>
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
<div class="container-fluid" style="background-color:#f0f0f0">
	<div class="row">
		<div class="col-xs-22 col-sm-14 col-md-12 col-lg-10 col-xs-push-1 col-sm-push-5 col-md-push-6 col-lg-push-7">
    		<div class="row font-type sign-up font-size-24" style="color:#ddcbbd; padding-top:10px; padding-bottom:10px">We make sure that your clients never have to be turned away.</div>
    		<ol class="progress-meter">
    			<li class="progress-point done">Basic</li><li class="progress-point done">Address</li><li class="progress-point done">Contacts</li><li class="progress-point doing">Schedule</li><li class="progress-point todo">Photos</li>
    		</ol>
    		<form:form method="POST" action="saveSchedule" modelAttribute="schedule" class="form-horizontal white-bg" id="creatMerchantForm" style="margin-top:15px;margin-bottom:15px;padding-bottom:30px">
	    		<div class="row row15 font-size-20 location-head font-type" style="background-color:#1fbbad; margin-bottom:15px; text-align:center">
		    			Enter Availability Details
		    	</div>
    			<div class="row row15" style="border-bottom:1px solid #aea190; margin-bottom:10px"></div>
   				<center>
	   				<div class="btn-group" id="weekdays" data-toggle="buttons" style="margin-bottom:20px">
					    <label class="btn btn-default day-pill font-size-20">
					        <input type="checkbox">Sun</label>
					    <label class="btn btn-default day-pill font-size-20">
					        <input type="checkbox">Mon</label>
					    <label class="btn btn-default day-pill font-size-20">
					        <input type="checkbox">Tue</label>
					    <label class="btn btn-default day-pill font-size-20">
					        <input type="checkbox">Wed</label>
					     <label class="btn btn-default day-pill font-size-20">
					        <input type="checkbox">Thur</label>
					     <label class="btn btn-default day-pill font-size-20">
					        <input type="checkbox">Fri</label>
					     <label class="btn btn-default day-pill font-size-20">
					        <input type="checkbox">Sat</label>
					</div>
			        <form:input path="schedule[0].weekSchedule" type="hidden" id="scheduleval0"/>
			        <form:input path="schedule[1].weekSchedule" type="hidden" id="scheduleval1"/>
			        <form:input path="schedule[0].closingTime" type="hidden" id="closingTime0"/>
			        <form:input path="schedule[0].openingTime" type="hidden" id="openingTime0"/>
			        <form:input path="schedule[1].closingTime" type="hidden" id="closingTime1"/>
			        <form:input path="schedule[1].openingTime" type="hidden" id="openingTime1"/>
				</center>
				<div class="row row-15">
					<div class="col-xs-9 col-xs-push-2 font-size-24" style="text-align:center">
						<div class="row row15">
							Opening Time
						</div>
						<div class="row row15" id="lower-value">
						</div>
					</div>
					<div class="col-xs-9 col-xs-push-5 font-size-24" style="text-align:center">
						<div class="row row15">
							Closing Time
						</div>
						<div class="row row15" id="upper-value">
						</div>
					</div>
				</div>
				<div class="col-md-18 col-md-push-3" id="slide">
					<div id="behaviour" style="margin-bottom:40px;"></div>
				</div>
				<div class="row row15">
					<div class="col-xs-12 col-xs-push-3">
						<input type="button" value="+ Add Another Time Slot" class="time-slot" onclick="timeslotadd()" id="addtimebtn">
					</div>
				</div>
					

				<div id="additional-time" style="display:none">
					<center>
	   				<div class="btn-group" id="weekdaysadd" data-toggle="buttons" style="margin-bottom:20px; margin-top:30px">
					    <label class="btn btn-default day-pill font-size-20">
					        <input type="checkbox">Sun</label>
					    <label class="btn btn-default day-pill font-size-20">
					        <input type="checkbox">Mon</label>
					    <label class="btn btn-default day-pill font-size-20">
					        <input type="checkbox">Tue</label>
					    <label class="btn btn-default day-pill font-size-20">
					        <input type="checkbox">Wed</label>
					     <label class="btn btn-default day-pill font-size-20">
					        <input type="checkbox">Thur</label>
					     <label class="btn btn-default day-pill font-size-20">
					        <input type="checkbox">Fri</label>
					     <label class="btn btn-default day-pill font-size-20">
					        <input type="checkbox">Sat</label>
					</div>
					</center>
					<div class="row row-15">
						<div class="col-xs-9 col-xs-push-2 font-size-24" style="text-align:center">
							<div class="row row15">
								Opening Time
							</div>
							<div class="row row15" id="lower-value-add">
							</div>
						</div>
						<div class="col-xs-9 col-xs-push-5 font-size-24" style="text-align:center">
							<div class="row row15">
								Closing Time
							</div>
							<div class="row row15" id="upper-value-add">
							</div>
						</div>
					</div>
					<div class="col-md-18 col-md-push-3" id="slide-add">
						<div id="behaviour-add" style="margin-bottom:40px;"></div>
					</div>
				</div>

				<center>
  				<input type="submit" value="Save and Next" class="signup-button font-size-16 font-type">
				<div class="white-bg col-md-22 col-lg-22 col-xs-22 col-sm-22" style="text-align:right">        
					<a class="font-size-16 font-type" href="inputPhoto"><u>Skip this step</u></a>
				</div>
				</center>
    		</form:form>
  		</div>
  	</div>
</div>
<div id="soft"></div>
<script type="text/javascript">
	$("#weekdays").change(function (e) {
	    var checkedDays = $("#weekdays :checkbox").map(function () {
	        return +$(this).is(':checked');
	    }).get(); 
	    
	    console.log(checkedDays.join(""));
	    $("input#scheduleval0").val(checkedDays.join(""));
	});

	$('#toggler').on('click', function () {
	    console.log(
	        $('#weekdays label').eq(0).button('toggle')
	                .find(':checkbox').prop('checked') // toggles t/f
	    );
	});
</script>
<script type="text/javascript">
	$("#weekdaysadd").change(function (e) {
	    var checkedDays = $("#weekdaysadd :checkbox").map(function () {
	        return +$(this).is(':checked');
	    }).get(); 
	    
	    console.log(checkedDays.join(""));
	    $("input#scheduleval1").val(checkedDays.join(""));
	});

	$('#toggler').on('click', function () {
	    console.log(
	        $('#weekdaysadd label').eq(0).button('toggle')
	                .find(':checkbox').prop('checked') // toggles t/f
	    );
	});
</script>

<script type="text/javascript">
	$("#behaviour").noUiSlider({
		start: [10 , 20 ],
		step: 1,
		behaviour: 'step',
		connect: true,
		range: {
			'min':  7,
			'max':  23
		}
	});
	$("#slide").click(function(){
		$("input#openingTime0").val($("#behaviour").val()[0].replace(".",":"));
		$("input#closingTime0").val($("#behaviour").val()[1].replace(".",":"));
	});
	function filter500( value, type ){
		return value % 2 ? 2 : 1;
	}

	$("#behaviour").noUiSlider_pips({
		mode: 'steps',
		density: 3,
		filter: filter500,
		format: wNumb({
			decimals: 0,
		})
	});
	$("#behaviour").Link('lower').to($('#lower-value'));

	// Do the same for the upper handle.
	$("#behaviour").Link('upper').to($('#upper-value'));

	function timeslotadd()
	{
		document.getElementById("additional-time").style.cssText = "visibility:visible !important;";
		document.getElementById("addtimebtn").style.cssText = "display:none !important;";
	}

		$("#behaviour-add").noUiSlider({
		start: [10 , 20 ],
		step: 1,
		behaviour: 'step',
		connect: true,
		range: {
			'min':  7,
			'max':  23
		}
	});
	$("#slide-add").click(function(){
		$("input#openingTime1").val($("#behaviour-add").val()[0].replace(".",":"));
		$("input#closingTime1").val($("#behaviour-add").val()[1].replace(".",":"));
	});
	function filter500( value, type ){
		return value % 2 ? 2 : 1;
	}

	$("#behaviour-add").noUiSlider_pips({
		mode: 'steps',
		density: 3,
		filter: filter500,
		format: wNumb({
			decimals: 0,
		})
	});
	$("#behaviour-add").Link('lower').to($('#lower-value-add'));

	// Do the same for the upper handle.
	$("#behaviour-add").Link('upper').to($('#upper-value-add'));
</script>

</body>
</html>