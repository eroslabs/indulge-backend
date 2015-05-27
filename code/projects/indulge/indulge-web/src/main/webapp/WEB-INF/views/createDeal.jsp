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
    
    <link href='http://fonts.googleapis.com/css?family=Raleway:400,300,500,200,600,700' rel='stylesheet' type='text/css'>
    <link href="${pageContext.servletContext.contextPath }/css/merchant-min.css" rel="stylesheet" />
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

	<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
	<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
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
            	<li><a href="${pageContext.servletContext.contextPath }/merchant/inputDigitalMenu" style="line-height:35px; margin-top:-5px"><img src="${pageContext.servletContext.contextPath }/images/Service-active.png" class="img-responsive" alt="Indulge" style="height:40px; float:left" />&nbsp;&nbsp;Services</a></li>
            	<li class="active" style="height:50px;background-color:#f0f0f0"><a href="${pageContext.servletContext.contextPath }/merchant/listDeals" style="line-height:35px; margin-top:-5px"><img src="${pageContext.servletContext.contextPath }/images/Deal.png" class="img-responsive" alt="Indulge" style="height:40px; float:left" />&nbsp;&nbsp;Deals</a></li>
            	<li><a href="${pageContext.servletContext.contextPath }/merchant/createMerchantServices" style="line-height:35px; margin-top:-5px"><img src="${pageContext.servletContext.contextPath }/images/account.png" class="img-responsive" alt="Indulge" style="height:40px; float:left" />&nbsp;&nbsp;Account</a></li>
            </ul>
        </div>
    </div>
  </nav>
	
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

	<div class="col-xs-22 col-sm-20 col-md-16 col-lg-14 col-xs-push-1 col-sm-push-2 col-md-push-4 col-lg-push-5">
    	<div class="row font-type sign-up font-size-24 location-header">Post A New Deal</div>
    		<form:form action="saveDeal" method="post" id="createDealForm" modelAttribute="deal" class="form-horizontal white-bg" style="margin-bottom:20px; margin-top:20px"  >
    			<div id="viewservices">
	    			<center>
			    		<ol class="progress-meter">
			    			<li class="progress-point doing">Services</li><li class="progress-point todo">Price</li><li class="progress-point todo">Validity</li><li class="progress-point todo">Confirmation</li>
			    		</ol>
			    	</center>
	    			<c:if test="${categories ne null and not empty categories}">
						<div class="row row15">
							<center>
								<div class="row row15 font-size-24" style="padding:10px;text-align:center; color:#fff; background-color:#1fbbad">
								Select Services
								</div>
							</center>
						</div>
						<div class="row row15">
							<div class="col-xs-12 font-size-20" style="padding:0px">
								<input type="button" style="text-align:center; padding:10px 0px 10px 0px; border:1px solid #1fbbad; width:100%" onclick="showcategories()" value="Category">
							</div>
							<div class="col-xs-12 font-size-20" style="padding:0px">
								<input type="button" style="text-align:center; padding:10px 0px 10px 0px; border:1px solid #1fbbad; width:100%" onclick="showservices()" value="Service or Service Type">
								
							</div>
						</div>
						<div class="row row15" id="categories">
							<c:forEach var="category" items="${categories}" varStatus="stats">
								<c:forEach var="serviceCat" items="${uniqueCategory}" varStatus="status">
									<c:if test="${serviceCat == category.id}">

										<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
										<center>
											<input type='checkbox' value="${category.id}" name="categoryId"/>
											<img src="../images/${category.image}" height="50px" style="border-radius:30px; margin-top:5px; margin-bottom:5px; border:1px solid">
										</center>
										</div>
										
									</c:if>
								</c:forEach>
							</c:forEach>
						</div>

						<div class="row row15" id="services" style="display:none">
							<datalist id="browser">
								<c:forEach var="category" items="${categories}" varStatus="stat">
									<c:forEach var="service" items="${category.services}" varStatus="state">
										<c:forEach var="serviceCat" items="${uniqueService}" varStatus="status">
											<c:if test="${serviceCat == service.id}">
												<option value="${service.name} - All" id="${service.id}"> ${service.name} - All</option>
												<c:forEach var="serviceType" items="${services}" varStatus="serviceStatus">
													<c:if test="${service.id==serviceType.serviceId}">
														<option value="${serviceType.name}" id="${serviceType.id}">--${serviceType.name}</option>
														${serviceType.serviceName}
														${serviceType.name}
														{serviceType.categoryName}
													</c:if>
												</c:forEach>	
											</c:if>
										</c:forEach>
									</c:forEach>
								</c:forEach>	
							</datalist>	
							<div class="col-md-18 col-md-push-3">
								<input id="browser1inp" list="browser" class="form-control postdeal-field" placeholder="Enter Service or Service Type">
							</div>
							<div class="col-md-18 col-md-push-3">
								<input id="browser2inp" list="browser" class="form-control postdeal-field" placeholder="Enter Service or Service Type">
							</div>	
							<div class="col-md-18 col-md-push-3">
								<input id="browser3inp" list="browser" class="form-control postdeal-field" placeholder="Enter Service or Service Type">
							</div>
						</div>
					</c:if>
					<center>
						<input type="button" onclick="submitservice()" class="signup-button font-size-16 font-type" value="Save and Next">
					</center>
					<input type="hidden" id="servicetype1" name="serviceTypeId">
					<input type="hidden" id="servicetype2" name="serviceTypeId">
					<input type="hidden" id="servicetype3" name="serviceTypeId">
					<input type="hidden" id="service1" name="serviceId">
					<input type="hidden" id="service2" name="serviceId">
					<input type="hidden" id="service3" name="serviceId">
				</div>
				<div id="enteramount" style="display:none">
					<center>
			    		<ol class="progress-meter">
			    			<li class="progress-point done">Services</li><li class="progress-point doing">Price</li><li class="progress-point todo">Validity</li><li class="progress-point todo">Confirmation</li>
			    		</ol>
			    	</center>
	    			<c:if test="${categories ne null and not empty categories}">
						<div class="row row15">
							<center>
								<div class="row row15 font-size-24" style="padding:10px;text-align:center; color:#fff; background-color:#1fbbad">
								Select Services
								</div>
							</center>
						</div>
						<div class="form-group">
						    <label class="col-sm-9 col-sm-push-1 control-label">Flat Off*</label>
						    <div class="col-sm-14">
						      <input id="flatOff" class="form-control signup-field" type="text" name="flatOff">
						    </div>
						</div>
						<div class="form-group">
						    <label class="col-sm-9 col-sm-push-1 control-label">Percent Off*</label>
						    <div class="col-sm-14">
						      <input id="percentOff" class="form-control signup-field" type="text" name="percentOff">
						    </div>
					    </div>
					</c:if>
					<center>
						<input type="button" onclick="return submitamount();" class="signup-button font-size-16 font-type" value="Save and Next">
					</center>
				</div>
				<div id="entervalidity" style="display:none">
					<center>
			    		<ol class="progress-meter">
			    			<li class="progress-point done">Services</li><li class="progress-point done">Price</li><li class="progress-point doing">Validity</li><li class="progress-point todo">Confirmation</li>
			    		</ol>
			    	</center>
	    			<c:if test="${categories ne null and not empty categories}">
						<div class="row row15">
							<center>
								<div class="row row15 font-size-24" style="padding:10px;text-align:center; color:#fff; background-color:#1fbbad">
								Select Services
								</div>
							</center>
						</div>
						<div class="form-group">
							<div class="col-xs-12">
								<label for="onetime" class="form-control font-size-20" style="text-align:center">One - Time</label>
								<input type="radio" class="form-control" name="recurring" value="false" id="onetime" onclick="hidedaypill()">
							</div>
							<div class="col-xs-12">
								<label for="everytime" class="form-control font-size-20" style="text-align:center">Recurring</label>
								<input type="radio" class="form-control" name="recurring" value="true" id="everytime" onclick="showdaypill()" selected>
							</div>
						</div>
						<div class="row row15" style="border:1px solid #1fbbad; margin-top:10px">
							<center>
				   				<div class="btn-group" id="weekdays" data-toggle="buttons" style="margin-top:10px; margin-bottom:10px">
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
						       	<input id="days" type="hidden" name="days">
							</center>
						</div>
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
						<input type="hidden" id="openingtime" value="10:00">
						<input type="hidden" id="closingtime" value="20:00">
						<div class="col-md-18 col-md-push-3" id="slide">
							<div id="behaviour" style="margin-bottom:40px;"></div>
						</div>

						<div class="form-group">
						    <label class="col-sm-9 col-sm-push-1 control-label">Valid From*</label>
						    <div class="col-sm-14">
						    	<input type='text' id='fromDate' class="form-control signup-field" readonly/>
						    	<input type="hidden" name="validFrom" id="validFrom">
						    </div>
						</div>
						<div class="form-group">
						    <label class="col-sm-9 col-sm-push-1 control-label">Valid Till*</label>
						    <div class="col-sm-14">
						      <input id="tillDate" class="form-control signup-field" type="text" readonly/>
						      <input type="hidden" name="validTill" id="validTill">
						    </div>
						</div>
					</c:if>
					<center>
						<input type="submit" onclick="return appendtry();" class="signup-button font-size-16 font-type" value="Save and Next">
					</center>
				</div>
			</form:form>
	</div>
	<script type="text/javascript">
	function showcategories(){
		$("#categories").css("display","block");
		$("#services").css("display","none");

	}
	function showservices(){
		$("#categories").css("display","none");
		$("#services").css("display","block");
    	$('#categories input[type=checkbox]').attr('checked',false);
	}
	function showchecked(){
		var checkedValues = $('input:checkbox:checked').map(function() {
		    return this.value;
		}).get().length;
		alert(checkedValues);
	}
	function submitservice(){
		
			var checkedValues = $('input:checkbox:checked').map(function() {
			    return this.value;
			}).get().length;
			var data = $('#browser');
            var inp1 = $('#browser1inp').val();
            var value1 = '';
            if(inp1 != ''){
            var val1 = $(data).find('option[value="' + inp1 + '"]');
            var id1 = val1.attr('id');
            value1 = val1.attr('value');
            if(value1 != '')
            {
	            if(value1.indexOf('-All')!= -1){
	            	$("#servicetype1").val(id1);
	            }
	            else{
	            	$("#service1").val(id1);
	            }
	        }
            }
            var inp2 = $('#browser2inp').val();
            var value2 = '';
            if(inp2 != ''){
	            var val2 = $(data).find('option[value="' + inp2 + '"]');
	            var id2 = val2.attr('id');
	            value2 = val2.attr('value').trim();
	            if(value2 != '')
	            {
		          	if(value2.indexOf('-All')!= -1){
		            	$("#servicetype2").val(id2);
		            }
		            else{
		            	$("#service2").val(id2);
		            }
		        }
            }
            var inp3 = $('#browser3inp').val();
            var value3 = '';
            if(inp3 != ''){
            var val3 = $(data).find('option[value="' + inp3 + '"]');
            var id3 = val3.attr('id');
            value3 = val3.attr('value').trim();
            if(value3 != '')
            {
	           	if(value3.indexOf('-All')!= -1){
	            	$("#servicetype3").val(id3);
	            }
	            else{
	            	$("#service3").val(id3);
	            }
	        }
            }
	        if(value1 == '' && value2 == '' && value3 == '' && checkedValues==0){
	        	alert("Please enter atleast one service or select one category");
	        	return false;
	        }
	        $("#viewservices").css("display","none");
	        $("#enteramount").css("display","block");
	}
	function submitamount(){
		if( $("#flatOff").val().trim() == '' && $("#percentOff").val().trim() == '')
		{
			alert("Please enter flat off or percent off");
			return false;
		}
		if( $("#flatOff").val().trim() != '' && $("#percentOff").val().trim() != '')
		{
			alert("Please enter either flat off or percent off");
			return false;
		}
		$("#enteramount").css("display","none");
		$("#entervalidity").css("display","block");
	}

	</script>
	<script type="text/javascript">
		$("#weekdays").change(function (e) {
		    var checkedDays = $("#weekdays :checkbox").map(function () {
		        return +$(this).is(':checked');
		    }).get(); 
		    
		    console.log(checkedDays.join(""));
		    $("#days").val(checkedDays.join(""));
		});

		$('#toggler').on('click', function () {
		    console.log(
		        $('#weekdays label').eq(0).button('toggle')
		                .find(':checkbox').prop('checked') // toggles t/f
		    );
		});
		function showdaypill(){
			$("#weekdays").removeClass("display");
		}

		function hidedaypill(){
			$("#weekdays").addClass("display");
		}
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
			$("#openingtime").val($("#behaviour").val()[0].replace(".",":"));
			$("#closingtime").val($("#behaviour").val()[1].replace(".",":"));
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
	</script>
	<script type="text/javascript"> 
	$(document).ready(function() {

	    $("#fromDate").datepicker({
	        showOn: 'button',
	        buttonText: 'Show Date',
	        buttonImageOnly: true,
	        buttonImage: 'http://jqueryui.com/resources/demos/datepicker/images/calendar.gif',
	        dateFormat: 'dd/mm/yy',
	        constrainInput: true
	    });

	    $(".ui-datepicker-trigger").mouseover(function() {
	        $(this).css('cursor', 'pointer');
	    });

	});

	</script>
	<script type="text/javascript"> 
	$(document).ready(function() {

	    $("#tillDate").datepicker({
	        showOn: 'button',
	        buttonText: 'Show Date',
	        buttonImageOnly: true,
	        buttonImage: 'http://jqueryui.com/resources/demos/datepicker/images/calendar.gif',
	        dateFormat: 'dd/mm/yy',
	        constrainInput: true
	    });

	    $(".ui-datepicker-trigger").mouseover(function() {
	        $(this).css('cursor', 'pointer');
	    });

	});

	</script>
	<script type="text/javascript">
	function appendtry(){
	if($("#fromDate").val()=='' || $("#tillDate").val()==''){
		alert("Please select valid dates");
		return false;
	}
	$("#validFrom").val($("#fromDate").val() + " " + $("#openingtime").val());
	$("#validTill").val($("#tillDate").val() + " " + $("#closingtime").val());
	}
	</script>

	
</body>
</html>