<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib  prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
 <head>
    <jsp:include page="../views/globalhead.jsp" />
  
<style type="text/css">
.header-info{
  inherit:.active;
}
    </style>
  </head>
<body style="background-color:#f0f0f0">
<jsp:include page="../views/postmerchantHeader.jsp" />
	
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
			<div class="col-md-5 col-sm-12 col-xs-20 col-md-push-5 col-sm-push-6 col-xs-push-2 post-deal-btn font-size-24">
				<a href="${pageContext.servletContext.contextPath }/merchant/inputDeal" style="color:#fff"> + Post A Deal </a>
			</div>
			<form method="POST" id="searchDeal" action="listDeals">
			<div class="col-md-8 col-sm-12 col-xs-20 col-md-push-7 col-sm-push-6 col-xs-push-2 font-size-24 post-deal-input">
				<input type="text" name="coupon" id="coupon" placeholder="Enter Coupon Code" class="font-size-16" style="color:white; border-bottom: 2px solid #fff !important;width:100%;background: transparent;" />
				<p>
					<input type="submit" value="search" class="white-text font-size-16" style="background-color:#b4978d;"><a href="" class="white-text font-size-16 pull-right" style="margin-top: 5px;"><u>What is this</u></a>
				</p>
			</div>
			</form>
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
		<c:choose>
			<c:when test="${deals ne null and  not empty deals}">
							<c:forEach var="deal" items="${deals}" varStatus="status"> 
							<c:if test="${deal.validTill > now and deal.status}">
								<div class="col-lg-6 col-md-6 col-sm-8 white-bg" style="margin-left:6%; border:1px solid; margin-top:20px;">
									<div class="row" style="border-bottom:1px solid; color:white; background-color:#b4978d">
										<div style="width:50%; float:left; border-right:1px solid; padding:15px;text-align:center;">
											<c:choose> <c:when test="${deal.percentOff ne null and deal.percentOff ne ''}">${deal.percentOff}%</c:when><c:otherwise>INR ${deal.flatOff}/-</c:otherwise></c:choose>
										</div>
										<div style="width:50%; float:right; text-align:center; padding:15px;">
											<s:eval expression="T(com.eros.utils.CalculationUtils).getDateDiff(deal.validTill)" var="dateDiff" />
											${dateDiff } days left!
										</div>
									</div>
									<div class="row" style="padding:5px 0px;margin-bottom:5px;border-bottom:1px dashed #333;">
										<c:forEach var="category" items="${categories}" varStatus="stats">
											<c:forEach var="serviceCat" items="${deal.categoryIds }" varStatus="status">
												<c:if test="${serviceCat == category.id}">
													<div class="col-md-3 text-center">
														<img src="../images/${category.image}" height="30px" >
													</div>
													
												</c:if>
											</c:forEach>
										</c:forEach>
										
										
									</div>
									<div class="row">
										<div style="width:50%; float:left; text-align:center">
										<s:eval expression="T(com.eros.utils.CalculationUtils).getWeekDays(deal.days)" var="weekdays" />
											${weekdays} <fmt:formatDate pattern="hh:mm" value="${deal.validFrom }" /> - <fmt:formatDate pattern="hh:mm a" value="${deal.validTill }" />
										</div>
										<div style="width:50%; float:right; text-align:center">
									<fmt:formatDate pattern="dd MMM yy" value="${deal.validFrom }" /> - <fmt:formatDate pattern="dd MMM yy" value="${deal.validTill }" /> 
										</div>
									</div>
									<div class="row">
										<a href="killDeal?dealId=${deal.id}" onclick="return confirm('Are you sure, you want to kill this deal?');">
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
			</c:when>
			<c:otherwise>
			<div class="col-lg-6 col-md-6 col-sm-8" style="margin-left:6%;margin-top:20px;">
						OOPS!! no deals defined.
			</div>
			</c:otherwise>
			</c:choose>
		</div>
	</div>
	<div class="container-fluid" id="pastdeals" style="display:none">
		<div class="row row15">
			<c:if test="${deals ne null and  not empty deals}">
							<c:forEach var="deal" items="${deals}" varStatus="status"> 
								<c:if test="${deal.validTill < now or not deal.status}">
								<div class="col-lg-6 col-md-6 col-sm-8" style="margin-left:6%; border:1px solid; margin-top:20px;">
									<div class="row" style="border-bottom:1px solid; color:white; background-color:#b4978d">
										<div style="width:30%; float:left; border-right:1px solid; padding:15px;text-align:center;">
											<c:choose> <c:when test="${deal.percentOff ne null and deal.percentOff ne ''}">${deal.percentOff}%</c:when><c:otherwise>INR ${deal.flatOff}/-</c:otherwise></c:choose>
										</div>
										<div style="width:70%; float:right; text-align:center; padding:15px;">
											Inactive since <fmt:formatDate pattern="dd MMM yy" value="${deal.validTill }" />! 
										</div>
									</div>
																		<div class="row" style="padding:5px 0px;margin-bottom:5px;border-bottom:1px dashed #333;">
										<c:forEach var="category" items="${categories}" varStatus="stats">
											<c:forEach var="serviceCat" items="${deal.categoryIds }" varStatus="status">
												<c:if test="${serviceCat == category.id}">
													<div class="col-md-3 text-center">
														<img src="../images/${category.image}" height="30px" >
													</div>
													
												</c:if>
											</c:forEach>
										</c:forEach>
										
										
									</div>
									
									<div class="row">
										<div style="width:50%; float:left; text-align:center">
										<s:eval expression="T(com.eros.utils.CalculationUtils).getWeekDays(deal.days)" var="weekdays" />
											${weekdays} <fmt:formatDate pattern="hh:mm" value="${deal.validFrom }" /> - <fmt:formatDate pattern="hh:mm a" value="${deal.validTill }" />
										</div>
										<div style="width:50%; float:right; text-align:center">
									<fmt:formatDate pattern="dd MMM yy" value="${deal.validFrom }" /> - <fmt:formatDate pattern="dd MMM yy" value="${deal.validTill }" /> 
										</div>
									</div>
									<div class="row">
										<a href="killDeal?dealId=${deal.id}">
										<div class="col-md-12 col-md-push-6 col-sm-16 col-sm-push-4 col-xs-20 col-xs-push-2" style="border:1px solid; padding:10px; text-align:center; margin-top:5px; border-radius:5px">
											Expired!
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
