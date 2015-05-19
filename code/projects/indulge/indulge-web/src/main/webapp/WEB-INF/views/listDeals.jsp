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
            	<li><a href="${pageContext.servletContext.contextPath }/merchant/inputDigitalMenu" style="line-height:35px; margin-top:-5px"><img src="${pageContext.servletContext.contextPath }/images/Service-active.png" class="img-responsive" alt="Indulge" style="height:40px; float:left" />&nbsp;&nbsp;Services</a></li>
            	<li class="active" style="height:50px;background-color:#f0f0f0"><a href="${pageContext.servletContext.contextPath }/merchant/listDeals" style="line-height:35px; margin-top:-5px"><img src="${pageContext.servletContext.contextPath }/images/Deal.png" class="img-responsive" alt="Indulge" style="height:40px; float:left" />&nbsp;&nbsp;Deals</a></li>
            	<li><a href="${pageContext.servletContext.contextPath }/merchant/createMerchantServices" style="line-height:35px; margin-top:-5px"><img src="${pageContext.servletContext.contextPath }/images/account.png" class="img-responsive" alt="Indulge" style="height:40px; float:left" />&nbsp;&nbsp;Account</a></li>
            </ul>
        </div>
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

		<!-- Nav tabs -->
	<jsp:useBean id="now" class="java.util.Date"/>
	<div class="container-fluid">
		<div class="row row15">
			<div class="col-md-10 col-sm-12 col-xs-20 col-md-push-7 col-sm-push-6 col-xs-push-2 post-deal-btn font-size-24">
				<a href="${pageContext.servletContext.contextPath }/merchant/inputDeal" style="color:#fff"> + Post A Deal </a>
			</div>
		</div>
		<div class="row row15" style="background-color:#fff;margin-top:20px">
			<div class="col-xs-12 deal-tabs" style="border-bottom:1px solid #1fbbad" onclick="toggle()">
					Current Deals
			</div>
			<div class="col-xs-12 deal-tabs" onclick="toggle1()">
					Past Deals
			</div>
		</div>
	</div>
	<div class="container-fluid" id="currentdeals">
		<div class="row row15">
			<c:if test="${deals ne null and  not empty deals}">
				<c:forEach var="deal" items="${deals}" varStatus="status"> 
				<c:if test="${deal.validTill > now}">
					<div class="col-lg-6 col-md-6 col-sm-8" style="margin-left:6%; border:1px solid; margin-top:20px;">
						<div class="row" style="border-bottom:1px solid; color:white; background-color:#b4978d">
							<div style="width:30%; float:left; border-right:1px solid; padding:15px;text-align:center;">
								${deal.percentOff} ${deal.flatOff}/-
							</div>
							<div style="width:70%; float:right; text-align:center; padding:15px;">
								${deal.validTill } 
							</div>
						</div>
						<div class="row">
							<div style="width:50%; float:left; text-align:center">
						${deal.validFrom }
							</div>
							<div style="width:50%; float:right; text-align:center">
						${deal.validTill } 
							</div>
						</div>
						<div class="row">
							<a href="killDeal?dealId=${deal.id}">
							<div class="col-md-12 col-md-push-6 col-sm-16 col-sm-push-4 col-xs-20 col-xs-push-2" style="border:1px solid; padding:10px; text-align:center; margin-top:5px; border-radius:5px">
								Kill Deal Early
							</div>
							</a>
						</div>
						<div class="row" style="color:white; margin-top:10px">
							<div style="width:50%; float:left; padding:10px; text-align:center;background-color:#b4978d">
								Redeemed ${deal.redemption}
							</div>
							<div style="width:50%; float:right;padding:10px; text-align:center;background-color:#1fbbad">
								Confirmed ${deal.confirmed}
							</div>
						</div>
					
					</div>
				</c:if>
				</c:forEach>	
			</c:if>
		</div>
	</div>
	<div class="container-fluid" id="pastdeals" style="display:none">
		<div class="row row15">
			<c:if test="${deals ne null and  not empty deals}">
				<c:forEach var="deal" items="${deals}" varStatus="status"> 
					<c:if test="${deal.validTill < now and deal.status}">
					<div class="col-lg-6 col-md-6 col-sm-8" style="margin-left:6%; border:1px solid; margin-top:20px;">
						<div class="row" style="border-bottom:1px solid; color:white; background-color:#b4978d">
							<div style="width:30%; float:left; border-right:1px solid; padding:15px;text-align:center;">
								${deal.percentOff} ${deal.flatOff}%
							</div>
							<div style="width:70%; float:right; text-align:center; padding:15px;">
								${deal.validTill } 
							</div>
						</div>
						<div class="row">
							<div style="width:50%; float:left; text-align:center">
						${deal.validFrom }
							</div>
							<div style="width:50%; float:right; text-align:center">
						${deal.validTill } 
							</div>
						</div>
						<div class="row">
							${deal.status}
						</div>
						<div class="row">
							<a href="killDeal?dealId=${deal.id}">
							<div class="col-md-12 col-md-push-6 col-sm-16 col-sm-push-4 col-xs-20 col-xs-push-2" style="border:1px solid; padding:10px; text-align:center; margin-top:5px; border-radius:5px">
								Kill Deal Early
							</div>
							</a>
						</div>
						<div class="row" style="color:white; margin-top:10px">
							<div style="width:50%; float:left; padding:10px; text-align:center;background-color:#b4978d">
								Redeemed ${deal.redemption}
							</div>
							<div style="width:50%; float:right;padding:10px; text-align:center;background-color:#1fbbad">
								Confirmed ${deal.confirmed}
							</div>
						</div>

					<!--Deal: 	id :: ${deal.id} description :: ${deal.description }   validFrom ::  validTill :: ${deal.validTill }     <br/>
							service : ${ deal.service.id} :::: service name ${ deal.service.name} image::${ deal.service.image}<br/>-->
					
					</div>
				</c:if>
				</c:forEach>	
			</c:if>
		</div>
	</div>
			<!-- Kill Deal killDeal?dealId=${deal.id}

			-->
		
	</div>
	</div>

	<script type="text/javascript">
		function toggle(){
			document.getElementById("currentdeals").style.cssText = "visibility:visible;";
			document.getElementById("pastdeals").style.cssText = "display:none;";
		}
		function toggle1(){
			document.getElementById("currentdeals").style.cssText = "display:none;";
			document.getElementById("pastdeals").style.cssText = "visibility:visible;";
		}
	</script>

	
</body>
</html>