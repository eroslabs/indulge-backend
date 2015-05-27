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
	<div class="container-fluid" style="margin-top:50px">
		<div class="row row15">
		<form:form method="POST" onsubmit="return validateForm();" action="saveMerchantServices" modelAttribute="merchant" enctype="multipart/form-data"  class="form-horizontal" id="uploadMerchantPhoto" >
			<div class="col-lg-20 col-lg-push-2 col-md-22 col-md-push-1 col-sm-24 col-xs-24 white-bg">
				<div class="row row15 font-size-20" style="padding-left:15px;padding-top:12px; padding-bottom:12px;background-color:#1fbbad; text-align:center">Enter prices for the services you offer and create a digital menu</div>
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

				<div class="row row15">
					<input list="browser" id="searchbox" class="col-xs-20" style="height:40px" placeholder="Search here">
					<datalist id="browser">
						<c:forEach var="category" items="${categories}" varStatus="status">
							<c:forEach var="catService" items="${category.services}" varStatus="serviceStatus">
							    <div id="row">
						    		<option value="${catService.name}">
								</div>
							</c:forEach>			
						</c:forEach>
					</datalist>
					<input type="button" onclick="search()" class="col-xs-4 midbrownbg-color" style="border-radius:0px;color:white; height:40px" value="Search">
					
				</div>


				<c:if test="${categories ne null and not empty categories}">
					<div class="row row15 cat">
						<c:forEach var="category" items="${categories}" varStatus="status">
						<div class="row row15" id="catrow_${category.id}" style="border:1px solid; padding-bottom:10px">
							<div class="row row15">
								<img src="../images/${category.image}" height="50px" style="border-radius:30px; margin-top:5px; margin-bottom:5px; border:1px solid; margin:10px">
								${category.name}
							</div>



							<div class="row row15">
								<div id="initial_${category.id}">
									<input type="hidden" id="categoryId" name="categoryId" value="${category.id}">
									<div class="col-md-6 col-sm-12 col-xs-12" style="padding:0px 5px 0px 5px; margin-top:5px;">
										<select style="width:100%" class="select-style" id="servicedrop_${category.id}" name="selectedId" onchange="servicedropdown(${category.id})">
										<option selected="selected" value="0">---Select---</option>
										<c:forEach var="Service" items="${category.services}" varStatus="serviceStatus">
										<c:if test="${Service.name ne null}">
												<option id="Service_${Service.id}" value="${Service.id}" onclick="servicedropdown(${category.id})">${Service.name}</option>
										</c:if>
										</c:forEach>
										</select>
									</div>
									<div class="col-md-5 col-sm-12 col-xs-12" style="padding:0px 5px 0px 5px;margin-top:5px;">
										<select style="width:100%" class="select-style" name="selectedType" id="servicetypedrop_${category.id}" class="servicetypedrop_${category.id}">
										<option selected="selected" value="0">---Select---</option>
										<c:forEach var="Service" items="${category.services}" varStatus="serviceStatus">
												<c:forEach var="serviceType" items="${Service.serviceTypes}" varStatus="serviceTypeStatus">
													<c:if test="${serviceType.name ne null}">
													<option value="${serviceType.id}" class="${category.id}_${Service.id}">${serviceType.name}</option>
													</c:if>
												</c:forEach>
										</c:forEach>
										</select>
									</div>
									<div class="col-md-3 col-sm-7 col-xs-12" style="padding:0px 5px 0px 5px;margin-top:5px;">
										<div class="btn-group" id="weekdays" data-toggle="buttons" style="width:100%">
										    <label class="btn btn-default" style="width:20%; padding:0px;text-align:center; height:40px; line-height:40px; vertical-align:middle" onclick="selectmale(this,${category.id})">
										        <input type="checkbox" value="0">M</label>
										    <label class="btn btn-default" style="width:20%; padding:0px;text-align:center; height:40px; line-height:40px; vertical-align:middle" onclick="selectfemale(this,${category.id})">
										        <input type="checkbox"  value="1">F</label>
										    <label class="btn btn-default" style="width:60%; padding:0px;text-align:center; height:40px; line-height:40px; vertical-align:middle" onclick="selectboth(this,${category.id})">
										        <input type="checkbox" value="2">Unisex</label>
										    <input name="selectedGender" id="selectedGender_${category.id}" type="hidden">
										</div>
									</div>
									<div class="col-md-5 col-sm-7 col-xs-12" style="padding:0px 5px 0px 5px;margin-top:5px;">
										<div class="btn-group" id="weekdays" data-toggle="buttons" style="width:100%">
										    <label class="btn btn-default" style="width:35%; padding:0px;text-align:center; height:40px; line-height:20px; vertical-align:middle" onclick="selectMerchant(this,${category.id})">
										        <input type="checkbox"  value="0">Merchant<br>Home</label>
										    <label class="btn btn-default" style="width:35%; padding:0px;text-align:center; height:40px; line-height:20px; vertical-align:middle" onclick="selectHome(this,${category.id})">
										        <input type="checkbox"  value="1">Home<br> Venue</label>
										    <label class="btn btn-default" style="width:30%; padding:0px;text-align:center; height:40px; line-height:40px; vertical-align:middle" onclick="selectbothlocation(this,${category.id})">
										        <input type="checkbox"  value="2">Both</label>
										    <input name="selectedHomeService" id="selectedHomeService_${category.id}" type="hidden">
										</div>
									</div>
									<div class="col-md-3 col-sm-5 col-xs-12" style="padding:0px 5px 0px 5px;margin-top:5px;">
										<input type="text" name="selectedPrice" id="selectedPrice" style="width:100%;height:40px" class="form-input signup-field" placeholder="Add Price">
									</div>
								</div>
								<div class="col-md-2 col-sm-5 col-xs-12" style="padding:0px 5px 0px 5px;margin-top:5px;">
									<input type="button" value="Add" class="btn btn-lg btn-primary btn-block btn-login" style="height:40px" onclick="clone(${category.id})" id="add_${category.id}">
								</div>
							</div>
							<div id="append_${category.id}" style="pointer-events:none; opacity:0.5"></div>



							<div class="row row15" id="clone_${category.id}" style="display:none">
							

								<input type="hidden" name="categoryId" value="${category.id}">
								<div class="col-md-6 col-sm-12 col-xs-12" style="padding:0px 5px 0px 5px; margin-top:5px;">
									<select style="width:100%" class="select-style" id="servicedrop_${category.id}" name="selectedId" onchange="servicedropdown(${category.id})">
									<option selected="selected" value="0">---Select---</option>
									<c:forEach var="Service" items="${category.services}" varStatus="serviceStatus">
									<c:if test="${Service.name ne null}">
											<option id="Service_${Service.id}" value="${Service.id}" onclick="servicedropdown(${category.id})">${Service.name}</option>
									</c:if>
									</c:forEach>
									</select>
								</div>
								<div class="col-md-5 col-sm-12 col-xs-12" style="padding:0px 5px 0px 5px;margin-top:5px;">
									<select style="width:100%" class="select-style" name="selectedType" id="servicetypedrop_${category.id}" class="servicetypedrop_${category.id}">
									<option selected="selected" value="0">---Select---</option>
									<c:forEach var="Service" items="${category.services}" varStatus="serviceStatus">
											<c:forEach var="serviceType" items="${Service.serviceTypes}" varStatus="serviceTypeStatus">
												<c:if test="${serviceType.name ne null}">
												<option value="${serviceType.id}" class="${category.id}_${Service.id}">${serviceType.name}</option>
												</c:if>
											</c:forEach>
									</c:forEach>
									</select>
								</div>
								<div class="col-md-3 col-sm-7 col-xs-12" style="padding:0px 5px 0px 5px;margin-top:5px;">
									<div class="btn-group" id="weekdays" data-toggle="buttons" style="width:100%">
									    <label class="btn btn-default" style="width:20%; padding:0px;text-align:center; height:40px; line-height:40px; vertical-align:middle" onclick="selectmale(this,${category.id})">
									        <input type="checkbox" value="0">M</label>
									    <label class="btn btn-default" style="width:20%; padding:0px;text-align:center; height:40px; line-height:40px; vertical-align:middle" onclick="selectfemale(this,${category.id})">
									        <input type="checkbox"  value="1">F</label>
									    <label class="btn btn-default" style="width:60%; padding:0px;text-align:center; height:40px; line-height:40px; vertical-align:middle" onclick="selectboth(this,${category.id})">
									        <input type="checkbox" value="2">Unisex</label>
									    <input name="selectedGender" id="selectedGender_${category.id}" type="hidden">
									</div>
								</div>
								<div class="col-md-5 col-sm-7 col-xs-12" style="padding:0px 5px 0px 5px;margin-top:5px;">
									<div class="btn-group" id="weekdays" data-toggle="buttons" style="width:100%">
									    <label class="btn btn-default" style="width:35%; padding:0px;text-align:center; height:40px; line-height:20px; vertical-align:middle" onclick="selectMerchant(this,${category.id})">
									        <input type="checkbox"  value="0">Merchant<br>Home</label>
									    <label class="btn btn-default" style="width:35%; padding:0px;text-align:center; height:40px; line-height:20px; vertical-align:middle" onclick="selectHome(this,${category.id})">
									        <input type="checkbox"  value="1">Home<br> Venue</label>
									    <label class="btn btn-default" style="width:30%; padding:0px;text-align:center; height:40px; line-height:40px; vertical-align:middle" onclick="selectbothlocation(this,${category.id})">
									        <input type="checkbox"  value="2">Both</label>
									    <input name="selectedHomeService" id="selectedHomeService_${category.id}" type="hidden">
									</div>
								</div>
								<div class="col-md-3 col-sm-5 col-xs-12" style="padding:0px 5px 0px 5px;margin-top:5px;">
									<input type="text" name="selectedPrice" style="width:100%;height:40px" class="form-input signup-field" placeholder="Add Price">
								</div>


							</div>

							<div id="prepend_${category.id}"></div>
						</div>
						</c:forEach>
						<input type="submit" class="row row15 midbrownbg-color" style="border-radius:0px;margin:20px;color:white; height:40px" value="Save Services">
					</div>
				</c:if>
			</div>
		</form:form>
		</div>
	</div>
	<script type="text/javascript">
	function validateForm(){
		if(document.getElementById('selectedPrice').value == '' || document.getElementById('selectedCategory').value == ''){
			alert("Please enter complete information for atleast one service.");
			return false;
		}
		return true;
	}
	
	function search(){
		var a = $("#searchbox").val();
		<c:forEach var="category" items="${categories}" varStatus="status">
			<c:forEach var="catService" items="${category.services}" varStatus="serviceStatus">
				if("${catService.name}"== a)
				{
					var catid = "${category.id}";
					var serid = "${catService.id}";
				}
			</c:forEach>
		</c:forEach>
        $('html, body').animate({ scrollTop: $("#servicedrop_" + catid).offset().top - 130}, 'slow');
        $("#Service_" + serid).attr("selected","selected");
        $("#catrow_" + catid).animate({ borderLeftWidth: "15px"}, 1000 );
        $("#catrow_" + catid).animate({ borderLeftWidth: "1px"}, 1000 );
    }
	</script>
	<script type="text/javascript">
		function clone(id){
			var error = 0;
			var message="Invalid Values for ";
			$("#initial_"+id).find("input:text").each(function(){
				if($(this).val()=='')
				{
					error = 1;
					message=message + "Price,  ";
				}
			});
			$("#initial_"+id).find("input:hidden").each(function(){
				if($(this).val()=='')
				{
					message=message + "Gender and Location";
					error = 1;
					return false; 
				}
			});
			if (error==1){
				alert(message);
				return false;
			}
				$("#prepend_"+id).children().appendTo("#append_"+id);
				$("#clone_" + id).clone().attr("id","cloned_"+id).prependTo("#prepend_"+id);
				$("#prepend_" + id + " #cloned_"+id).css("display","block");
				$("#initial_"+id).css("pointer-events","none");
				$("#initial_"+id).css("opacity","0.5");

		}
	</script>
	<script type="text/javascript">
	function servicedropdown(dropid){
			alert(dropid);
			var e = document.getElementById("servicedrop_"+ dropid);
			var strUser = e.options[e.selectedIndex].value;
			//$("#servicetypedrop_"+dropid).removeAttr("disabled");
			$("#servicetypedrop_"+dropid).children().addClass("display");
			$("."+dropid + "_" + strUser).removeClass("display")
		}
	</script>
	<script type="text/javascript">
		function selectmale(self, id){
			$(self).closest('div').find("#selectedGender_" + id).val(0);
			activeremove(self);
		}
		function selectfemale(self,id){
			$(self).closest('div').find("#selectedGender_" + id).val(1);
			activeremove(self);
		}
		function selectboth(self,id){
			$(self).closest('div').find("#selectedGender_" + id).val(2);
			activeremove(self);
		}
		function selectMerchant(self,id){
			$(self).closest('div').find("#selectedHomeService_" + id).val(0);
			activeremove(self);
		}
		function selectHome(self,id){
			$(self).closest('div').find("#selectedHomeService_" + id).val(1);
			activeremove(self);
		}
		function selectbothlocation(self,id){
			$(self).closest('div').find("#selectedHomeService_" + id).val(2);
			activeremove(self);
		}
		function activeremove(self)
		{
			$(self).closest('#weekdays').find('label').each(function () {
                       $(this).removeClass("active");
                    });
		}

	</script>
</body>
</html>