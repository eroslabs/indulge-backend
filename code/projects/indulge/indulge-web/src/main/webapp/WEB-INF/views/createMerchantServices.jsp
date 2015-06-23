<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib  prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% response.setHeader("Cache-Control", "no-cache,no-store,private,must-revalidate,max-stale=0,post-check=0,pre-check=0"); // HTTP 1.1.
response.setHeader("Pragma", "no-cache"); 
response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html>
<html lang="en">
   <head>
      <jsp:include page="../views/globalhead.jsp" />
   </head>
   <body style="background-color: #f0f0f0">
      <jsp:include page="../views/postmerchantHeader.jsp" />
	<div id="loading">
		<img
			src="${pageContext.servletContext.contextPath }/images/ajax-loader.gif"
			id="loading-image" />
	</div>      
      <div class="container-fluid" style="margin-top: 50px">
         <div class="row row15">
            <form:form method="POST" onsubmit="return validateForm();"
               action="saveMerchantServices" modelAttribute="merchant"
               enctype="multipart/form-data" class="form-horizontal"
               id="uploadMerchantPhoto">
               <div class=" col-lg-17 col-centered col-sm-24 col-xs-24" style="padding:0;">
               		<div class="font-size-20"
                     style="padding-left: 15px; padding-top: 12px; padding-bottom: 12px; background-color: #1fbbad; text-align: center; color:#fff;">Enter
                     prices for the services you offer and create a digital menu
                  </div>
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
                  <div class="row row15" style="padding: 10px 0;">
                     <input list="browser" id="searchbox" class="col-xs-20 col-sm-5"
                        style="height: 40px; border: none;" placeholder="Search here">
                        <input type="button" onclick="search()"
                        class="col-xs-3 btn-green btn"
                        style="border-radius: 0px; color: white; height: 40px"
                        value="Search">
                     <datalist id="browser">
                        <c:forEach var="category" items="${categories}"
                           varStatus="status">
                           <c:forEach var="catService" items="${category.services}"
                              varStatus="serviceStatus">
                              <div id="row">
                                 <option value="${catService.name}">
                              </div>
                           </c:forEach>
                        </c:forEach>
                     </datalist>
                        <a href="${pageContext.servletContext.contextPath }/merchant/inputIssue" class="brown-text pull-right" style="padding-top: 10px;"><u>Cant find the service you're looking for?</u></a>
                  </div>

               
                  
                  
                  <c:if test="${categories ne null and not empty categories}">
                  <div class="row row15 cat">
                  <c:forEach var="category" items="${categories}"
                     varStatus="status">
                  <div class="row row15 white-bg" id="catrow_${category.id}"
                     style="border: 1px solid #C8C8C8; padding-bottom: 10px; margin-bottom: 30px;">
                  <div class="row row15 brown-text text-uppercase" style="font-size: 20px !important; padding-left: 10px;">
                  <img src="../images/${category.image}" height="50px"
                     style="margin: 10px">
                  ${category.name}
                  </div>
                  <div class="row row15" style="padding: 3px 15px;">
                  <div id="initial_${category.id}">
                  <input type="hidden" id="categoryId" name="categoryId"
                     value="${category.id}">
                  <div class="col-md-5 col-sm-12 col-xs-12"
                     style="padding: 0px 20px 0px 5px; margin-top: 5px;">
                  <select style="width: 100%" class="select-style"
                     id="servicedrop_${category.id}" name="selectedId"
                     onchange="servicedropdown(${category.id})">
                  <option selected="selected" value="0">---Select---</option>
                  <c:forEach var="Service" items="${category.services}"
                     varStatus="serviceStatus">
                  <c:if test="${Service.name ne null}">
                  <option id="Service_${Service.id}" value="${Service.id}"
                     onclick="servicedropdown(${category.id})">${Service.name}</option>
                  </c:if>
                  </c:forEach>
                  </select>
                  </div>
                  <div class="col-md-5 col-sm-12 col-xs-12"
                     style="padding: 0px 20px 0px 5px; margin-top: 5px;">
                  <select style="width: 100%" class="select-style"
                     name="selectedType" id="servicetypedrop_${category.id}"
                     class="servicetypedrop_${category.id}">
                  <option selected="selected" value="0">---Select---</option>
                  <c:forEach var="Service" items="${category.services}"
                     varStatus="serviceStatus">
                  <c:forEach var="serviceType"
                     items="${Service.serviceTypes}"
                     varStatus="serviceTypeStatus">
                  <c:if test="${serviceType.name ne null}">
                  <option value="${serviceType.id}"
                     class="${category.id}_${Service.id}">${serviceType.name}</option>
                  </c:if>
                  </c:forEach>
                  </c:forEach>
                  </select>
                  </div>
                  <div class="col-md-4 col-sm-7 col-xs-24"
                     style="padding: 0px 20px 0px 5px; margin-top: 5px;">
                  <div class="btn-group" id="weekdays" data-toggle="buttons"
                     style="width: 100%">
                  <label class="btn btn-default day-pill"
                     style="width: 30%; padding: 0px; text-align: center; height: 40px; line-height: 40px; font-size:12px; vertical-align: middle"
                     onclick="selectmale(this,${category.id})"> <input
                     type="checkbox" value="0">M
                  </label> <label class="btn btn-default day-pill"
                     style="width: 30%; padding: 0px; text-align: center; height: 40px; line-height: 40px; font-size:12px; vertical-align: middle"
                     onclick="selectfemale(this,${category.id})"> <input
                     type="checkbox" value="1">F
                  </label> <label class="btn btn-default day-pill"
                     style="width: 40%; padding: 0px; text-align: center; height: 40px; line-height: 40px; font-size:12px; vertical-align: middle"
                     onclick="selectboth(this,${category.id})"> <input
                     type="checkbox" value="2">Unisex
                  </label> <input name="selectedGender"
                     id="selectedGender_${category.id}" type="hidden">
                  </div>
                  </div>
                  <div class="col-md-5 col-sm-7 col-xs-24"
                     style="padding: 0px 20px 0px 5px; margin-top: 5px;">
                  <div class="btn-group" id="weekdays" data-toggle="buttons"
                     style="width: 100%">
                  <label class="btn btn-default day-pill"
                     style="width: 35%;  padding: 7px; text-align: center; height: 40px; line-height: 13px; font-size: 12px; vertical-align: middle"
                     onclick="selectMerchant(this,${category.id})"> <input
                     type="checkbox" value="0">Merchant<br>Venue
                  </label> <label class="btn btn-default day-pill"
                     style="width: 35%;  padding: 7px; text-align: center; height: 40px; line-height: 13px; font-size: 12px; vertical-align: middle"
                     onclick="selectHome(this,${category.id})"> <input
                     type="checkbox" value="1">Client<br/>Home
                  </label> <label class="btn btn-default day-pill"
                     style="width: 30%;  padding: 12px; text-align: center; height: 40px; line-height: 13px; font-size: 12px; vertical-align: middle"
                     onclick="selectbothlocation(this,${category.id})">
                  <input type="checkbox" value="2">Both
                  </label> <input name="selectedHomeService"
                     id="selectedHomeService_${category.id}" type="hidden">
                  </div>
                  </div>
                  <div class="col-md-3 col-sm-5 col-xs-12"
                     style="padding: 0px 20px 0px 5px; margin-top: 5px;">
                  <input type="text" name="selectedPrice" id="selectedPrice"
                     style="width: 100%; height: 40px"
                     class="form-input signup-field" placeholder="Add Price">
                  </div>
                  </div>
                  <div class="col-md-2 col-sm-5 col-xs-12"
                     style="padding: 0px 20px 0px 5px; margin-top: 5px;">
                  <input type="button" value="ADD"
                     class="btn btn-blue" onclick="clone(${category.id})"
                     id="add_${category.id}">
                  </div>
                  </div>
                  <div id="append_${category.id}"  style="padding:3px 30px;" class="row">
                  <c:forEach var="merService" items="${merchant.services}"
                     varStatus="merStatus">
                  <c:if test="${merService.categoryId == category.id }">
                  <div >
                  <input type="hidden" value="${merService.categoryId }"
                     name="categoryId" id="categoryId">
                  <div style="padding: 0px 20px 0px 5px; margin-top: 5px;"
                     class="col-md-5 col-sm-12 col-xs-12 light-opacity">
                  <select name="selectedId"
                     id="servicedrop_1" class="select-style"
                     style="width: 100%">
                  <option value="${merService.serviceId }">${merService.serviceName
                  }</option>
                  </select>
                  </div>
                  <div style="padding: 0px 20px 0px 5px; margin-top: 5px;"
                     class="col-md-5 col-sm-12 col-xs-12 light-opacity">
                  <select id="servicetypedrop_1" name="selectedType"
                     class="select-style" style="width: 100%">
                  <option class="1_1" value="${merService.serviceTypeId }">${merService.name
                  }</option>
                  </select>
                  </div>
                  <div style="padding: 0px 20px 0px 5px; margin-top: 5px;"
                     class="col-md-4 col-sm-7 col-xs-24 light-opacity">
                  <div style="width: 100%" data-toggle="buttons"
                     id="weekdays" class="btn-group">
                  <label onclick="selectmale(this,1)"
                  style="width: 30%; padding: 0px; text-align: center; height: 40px; line-height: 40px; font-size:12px; vertical-align: middle"
                  class="btn btn-default day-pill <c:if test="${merService.gender == 0}">active </c:if>">
                  <input type="checkbox" value="0"
                  <c:if test="${merService.gender == 0}">checked </c:if>>M
                  </label> <label onclick="selectfemale(this,1)"
                  style="width: 30%; padding: 0px; text-align: center; height: 40px; line-height: 40px; font-size:12px; vertical-align: middle"
                  class="btn btn-default day-pill <c:if test="${merService.gender == 1}">active </c:if>">
                  <input type="checkbox" value="1"
                  <c:if test="${merService.gender == 1}">checked </c:if>>F
                  </label> <label onclick="selectboth(this,1)"
                  style="width: 40%; padding: 0px; text-align: center; height: 40px; line-height: 40px; font-size:12px; vertical-align: middle"
                  class="btn btn-default day-pill <c:if test="${merService.gender == 2}">active </c:if>">
                  <input type="checkbox" value="2"
                  <c:if test="${merService.gender == 2}">checked </c:if>>Unisex
                  </label> <input type="hidden" id="selectedGender_1"
                     name="selectedGender" value="${merService.gender}">
                  </div>
                  </div>
                  <div style="padding: 0px 20px 0px 5px; margin-top: 5px;"
                     class="col-md-5 col-sm-7 col-xs-24 light-opacity">
                  <div style="width: 100%" data-toggle="buttons"
                     id="weekdays" class="btn-group">
                  <label onclick="selectMerchant(this,1)"
                  style="width: 35%; padding: 7px; text-align: center; height: 40px; line-height: 13px; font-size: 12px; vertical-align: middle"
                  class="btn btn-default day-pill <c:if test="${merService.homeService == 0}">active </c:if>">
                  <input type="checkbox" value="0"
                  <c:if test="${merService.homeService == 0}">checked </c:if>>Merchant<br>Home
                  </label> <label onclick="selectHome(this,1)"
                  style="width: 35%; padding: 7px; text-align: center; height: 40px; line-height: 13px; font-size: 12px; vertical-align: middle"
                  class="btn btn-default day-pill <c:if test="${merService.homeService == 1}">active </c:if>">
                  <input type="checkbox" value="1"
                  <c:if test="${merService.homeService == 1}">checked </c:if>>Home<br>
                  Venue
                  </label> <label onclick="selectbothlocation(this,1)"
                  style="width: 30%; padding: 12px; text-align: center; height: 40px; line-height: 13px; font-size: 12px; vertical-align: middle"
                  class="btn btn-default day-pill <c:if test="${merService.homeService == 2}">active </c:if>">
                  <input type="checkbox" value="2"
                  <c:if test="${merService.homeService == 2}">checked </c:if>>Both
                  </label> <input type="hidden" id="selectedHomeService_1"
                     name="selectedHomeService"
                     value="${merService.homeService}">
                  </div>
                  </div>
                  <div style="padding: 0px 20px 0px 5px; margin-top: 5px;"
                     class="col-md-3 col-sm-5 col-xs-12 light-opacity">
                  <input type="text" placeholder="Add Price"
                     class="form-input signup-field"
                     style="width: 100%; height: 40px" id="selectedPrice"
                     name="selectedPrice" value="<fmt:formatNumber value="${merService.price }" maxFractionDigits="0"/>">
                  </div>
                  <a onclick="deleteme(this);" href="#" class="col-md-2"><span class="glyphicon glyphicon-remove" style="padding: 15px 0px; color:#B4978D;"></span></a>
                  
                  </div>
                  </c:if>
                  </c:forEach>
                  </div>
                  <div id="clone_${category.id}" style="display: none">
                  <input type="hidden" name="categoryId" value="${category.id}">
                  <div class="col-md-5 col-sm-12 col-xs-12"
                     style="padding: 0px 20px 0px 5px; margin-top: 5px;">
                  <select style="width: 100%" class="select-style"
                     id="servicedrop_${category.id}" name="selectedId"
                     onchange="servicedropdown(${category.id})">
                  <option selected="selected" value="0">---Select---</option>
                  <c:forEach var="Service" items="${category.services}"
                     varStatus="serviceStatus">
                  <c:if test="${Service.name ne null}">
                  <option id="Service_${Service.id}" value="${Service.id}"
                     onclick="servicedropdown(${category.id})">${Service.name}</option>
                  </c:if>
                  </c:forEach>
                  </select>
                  </div>
                  <div class="col-md-5 col-sm-12 col-xs-12"
                     style="padding: 0px 20px 0px 5px; margin-top: 5px;">
                  <select style="width: 100%" class="select-style"
                     name="selectedType" id="servicetypedrop_${category.id}"
                     class="servicetypedrop_${category.id}">
                  <option selected="selected" value="0">---Select---</option>
                  <c:forEach var="Service" items="${category.services}"
                     varStatus="serviceStatus">
                  <c:forEach var="serviceType"
                     items="${Service.serviceTypes}"
                     varStatus="serviceTypeStatus">
                  <c:if test="${serviceType.name ne null}">
                  <option value="${serviceType.id}"
                     class="${category.id}_${Service.id}">${serviceType.name}</option>
                  </c:if>
                  </c:forEach>
                  </c:forEach>
                  </select>
                  </div>
                  <div class="col-md-4 col-sm-7 col-xs-24"
                     style="padding: 0px 20px 0px 5px; margin-top: 5px;">
                  <div class="btn-group" id="weekdays" data-toggle="buttons"
                     style="width: 100%">
                  <label class="btn btn-default day-pill"
                     style="width: 30%; padding: 0px; text-align: center; height: 40px; line-height: 40px; font-size:12px; vertical-align: middle"
                     onclick="selectmale(this,${category.id})"> <input
                     type="checkbox" value="0">M
                  </label> <label class="btn btn-default day-pill"
                     style="width: 30%; padding: 0px; text-align: center; height: 40px; line-height: 40px; font-size:12px; vertical-align: middle"
                     onclick="selectfemale(this,${category.id})"> <input
                     type="checkbox" value="1">F
                  </label> <label class="btn btn-default day-pill"
                     style="width: 40%; padding: 0px; text-align: center; height: 40px; line-height: 40px; font-size:12px; vertical-align: middle"
                     onclick="selectboth(this,${category.id})"> <input
                     type="checkbox" value="2">Unisex
                  </label> <input name="selectedGender"
                     id="selectedGender_${category.id}" type="hidden">
                  </div>
                  </div>
                  <div class="col-md-5 col-sm-7 col-xs-24"
                     style="padding: 0px 20px 0px 5px; margin-top: 5px;">
                  <div class="btn-group" id="weekdays" data-toggle="buttons"
                     style="width: 100%">
                  <label class="btn btn-default day-pill"
                     style="width: 35%;  padding: 7px; text-align: center; height: 40px; line-height: 13px; font-size: 12px; vertical-align: middle"
                     onclick="selectMerchant(this,${category.id})"> <input
                     type="checkbox" value="0">Merchant<br>Venue
                  </label> <label class="btn btn-default day-pill"
                     style="width: 35%; padding: 7px; text-align: center; height: 40px; line-height: 13px; font-size: 12px; vertical-align: middle"
                     onclick="selectHome(this,${category.id})"> <input
                     type="checkbox" value="1">Client<br>Home
                  </label> <label class="btn btn-default day-pill"
                     style="width: 30%;  padding: 12px; text-align: center; height: 40px; line-height: 13px; font-size: 12px;vertical-align: middle"
                     onclick="selectbothlocation(this,${category.id})">
                  <input type="checkbox" value="2">Both
                  </label> <input name="selectedHomeService"
                     id="selectedHomeService_${category.id}" type="hidden">
                  </div>
                  </div>
                  <div class="col-md-3 col-sm-5 col-xs-12"
                     style="padding: 0px 20px 0px 5px; margin-top: 5px;">
                  <input type="text" name="selectedPrice"
                     style="width: 100%; height: 40px"
                     class="form-input signup-field" placeholder="Add Price">
                  </div>
                  </div>
                  <div id="prepend_${category.id}"></div>
                  </div>
                  </c:forEach>
                  <input type="submit" class="row row15 midbrownbg-color"
                     style="border-radius: 0px; margin: 20px; color: white; height: 40px"
                     value="Save Services">
                  </div>
                  </c:if>
               </div>
		<input type="submit" class="row row15 midbrownbg-color" style="position: fixed;right: 0px;top: 250px;border-radius: 0px; margin: 20px; color: white; height: 40px" value="Save Services">
            </form:form>
         </div>
      </div>
      <script type="text/javascript">
	var changes = false;
	$('#loading').hide();
		function showLoader() {
			$('#loading').show();
		}
         function validateForm(){
		changes = false;
         	var p = document.getElementsByName("selectedPrice");
         	var c = document.getElementsByName('selectedId');
         	var t = document.getElementsByName('selectedType');
         	var g = document.getElementsByName('selectedGender');
         	var s = document.getElementsByName('selectedHomeService');
         	
         	var i;
         	for (i = 0; i < p.length; i++) {
         		 if (p[i].value != "0") {
         		        if(c[i].value != '0' && t[i].value != '' && g[i].value != '' && s[i].value != ''){
					showLoader();
         		        	return true;
         		        }
         	}}
         
         		alert("Please enter complete information for atleast one service.");
         		return false;
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
		changes = true;
         	var error = 0;
         	var message="Invalid Values for ";
         	$("#initial_"+id).find("#servicedrop_"+id).each(function(){
         		if($(this).val()=='0')
         		{
         			error = 1;
         			message=message + "Category,  ";
         		}
         	});
         	$("#initial_"+id).find("#servicetypedrop_"+id).each(function(){
         		if($(this).val()=='0')
         		{
         			error = 1;
         			message=message + "Service,  ";
         		}
         	});
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
         		
         		d=document.createElement('div');
         		$("#initial_"+id).children().css('opacity','0.6').appendTo(d);

         		$(d).append('<a onclick="deleteme(this);" href="#" class="col-md-2"><span class="glyphicon glyphicon-remove" style="padding: 15px 0px; color:#B4978D;"></span></a>');
         		$("#append_"+id).append(d);
         		$("#clone_" + id).clone().attr("id","cloned_"+id).css("display","block").prependTo("#initial_"+id);
         		
         
         }
         function deleteme(event){
        	 if(confirm('Are you sure you want to delete?')){
         	$(event).parent("div").remove();
        	 }
         }
      </script>
      <script type="text/javascript">
         function servicedropdown(dropid){
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
	$(window).bind("beforeunload",function(event) {
	    	    if(changes) {return "Click SAVE button at the BOTTOM to save all services.";}
	    	});
         
      </script>
   </body>
</html>
