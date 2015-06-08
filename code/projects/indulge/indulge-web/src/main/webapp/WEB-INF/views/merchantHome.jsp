<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib  prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">
   <head>
      <jsp:include page="../views/globalhead.jsp" />
      <script src="${pageContext.servletContext.contextPath }/js/jquery-ui.min.js"></script>
      <link href="${pageContext.servletContext.contextPath }/css/jquery-ui.min.css" rel="stylesheet">
      <link href="${pageContext.servletContext.contextPath }/css/jquery.nouislider.pips.min.css" rel="stylesheet">
      <style>
         img{
         width: 200px;
         height: 200px;
         margin: 10px 0;
         }
      </style>
   </head>
   <body style="background-color:#f0f0f0; color: #656565;">
      <jsp:include page="../views/postmerchantHeader.jsp" />
      <div class="row row15" id="merchant-home-body" style="margin-bottom:10px">
         <div class="col-md-21 col-md-push-2 col-sm-21 col-sm-push-2">
            <!-- Nav tabs -->
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
         </div>
         <div class="col-md-10 col-md-push-2 col-sm-10 col-sm-push-2">
            <div class="row row15 font-size-20 brown-text font-type" style="padding:10px"> Profile<a class="font-size-16" style="float:right" data-toggle="modal" data-target="#myModalProfilePic"><i class="icon-pencil"></i> edit</a></div>
            <div class="row row15" style=" margin-left:15px; background-color:#B4978D">
               <center>
                  <div class="col-md-5 col-sm-8 col-xs-12" >
                     <img src="
                     <c:if test="${merchant.image ne null and merchant.image != ''}" >../images/merchant/${merchant.image}</c:if>
                     " style="height:90px; width:90px; margin-top:20px; margin-bottom:15px;">
                  </div>
               </center>
               <div class="col-md-10 col-sm-10 white-text" style="padding-bottom:10px">
                  <center>
                     <h2>${merchant.name}</h2>
                     <p>
                        <c:if test="${merchant.merchantType == 0}">Merchant</c:if>
                        <c:if test="${merchant.merchantType == 1}">Individual</c:if>
                     </p>
                     <p>${merchant.locality}, ${merchant.city}</p>
                  </center>
               </div>
            </div>
         </div>
         <div class="col-md-10 col-md-push-3 col-sm-10 col-sm-push-3" style="height:100%">
            <div class="row row15 font-size-20 brown-text font-type" style="padding:10px;"> Opening Hours <a style="float:right" class="font-size-16" data-toggle="modal" data-target="#myModalSch"><i class="icon-pencil"></i> edit</a></div>
            <div class="merchant-home font-size-16 font-type">
               <c:choose>
                  <c:when test="${merchant.schedule ne null}">
                     <c:forEach var="schedule" items="${merchant.schedule}" varStatus="status">
                        ${schedule.weekStr} ${schedule.openTime12Hrs} - ${schedule.closeTime12Hrs}<br/>
                     </c:forEach>
                  </c:when>
                  <c:otherwise>
                     No schedule specified.
                  </c:otherwise>
               </c:choose>
            </div>
         </div>
      </div>
      <!--<div class="container">
         <div class="row" style="text-align: center;">
         
           <h2>Welcome to merchant app</h2>
           Name  : <strong>${merchant.name}</strong>
           <br/>Pending Task ( Attract more users): <c:if test="${not merchant.profileComplete}"><a href="inputLocation"> Complete Profile</a></c:if>
           <div style="clear:both;"/>
         </div>
         </div>-->
      <div class="row row15">
         <div class="col-md-10 col-md-push-2 col-sm-10 col-sm-push-2">
            <div class="row row15 font-size-20 brown-text font-type" style="padding:10px">Venue Info <a class="font-size-16" style="float:right" data-toggle="modal" data-target="#myModalAdd"><i class="icon-pencil"></i> edit</a></div>
            <div class="merchant-home">
               <table class="font-size-16 font-type" style="width:80%">
                  <tr>
                     <td width="50%" valign="top">Address</td>
                     <td width="50%">${merchant.address}</td>
                  </tr>
                  <tr>
                     <td width="50%" height="30px">Locality</td>
                     <td width="50%">${merchant.locality}</td>
                  </tr>
                  <tr>
                     <td width="50%" height="30px">Landmark</td>
                     <td width="50%">${merchant.landmark}</td>
                  </tr>
                  <tr>
                     <td width="50%" height="30px">City</td>
                     <td width="50%">${merchant.city}</td>
                  </tr>
                  <tr>
                     <td width="50%" height="30px">PinCode</td>
                     <td width="50%">${merchant.pincode}</td>
                  </tr>
                  <tr>
                     <td width="50%" height="30px">Accept Debit Cards</td>
                     <td width="50%">No</td>
                  </tr>
                  <tr>
                     <td width="50%" height="30px">Have Air Conditioning</td>
                     <td width="50%">Yes</td>
                  </tr>
               </table>
            </div>
         </div>
         <div class="col-md-10 col-md-push-3 col-sm-10 col-sm-push-3">
            <div class="row row15  font-size-20 brown-text font-type" style="padding:10px"> Contact Info <a style="float:right" class="font-size-16" data-toggle="modal" data-target="#myModalAcc"><i class="icon-pencil"></i> edit</a></div>
            <div class="merchant-home">
               <table class="font-size-16 font-type" style="width:80%">
                  <c:if test="${merchant.phones ne null and  not empty merchant.phones}">
                     <c:forEach var="phoneItem" items="${merchant.phones}" varStatus="status">
                        <tr>
                           <td width="50%" height="30px">Phone No.</td>
                           <td width="50%">${phoneItem.phone }</td>
                        </tr>
                     </c:forEach>
                  </c:if>
                  <c:if test="${merchant.phones == null or  empty merchant.phones}">
                     <tr>
                        <td width="50%" height="30px">Phone No.</td>
                        <td width="50%"></td>
                     </tr>
                  </c:if>
                  <tr>
                     <td width="50%" height="30px">Software</td>
                     <td width="50%">${merchant.software}</td>
                  </tr>
                  <tr>
                     <td width="50%" height="30px"></td>
                     <td width="50%"></td>
                  </tr>
                  <tr>
                     <td width="50%" height="30px"></td>
                     <td width="50%"></td>
                  </tr>
                  <tr>
                     <td width="50%" height="30px"></td>
                     <td width="50%"></td>
                  </tr>
                  <tr>
                     <td width="50%" height="30px"></td>
                     <td width="50%"></td>
                  </tr>
                  <tr>
                     <td width="50%" height="30px"></td>
                     <td width="50%"></td>
                  </tr>
               </table>
            </div>
         </div>
      </div>
      <div class="row row15">
         <div class="col-md-21 col-md-push-2 col-sm-21 col-sm-push-2">
            <div class="row row15 font-size-20 brown-text font-type" style="padding:10px"> Photos<a style="float:right" class="font-size-16" data-toggle="modal" data-target="#myModalPic"><i class="icon-pencil"></i> edit</a></div>
            <div class="row row15 merchant-home-img">
               <c:forEach var="imageItem" items="${merchant.images}" varStatus="status">
                  <div class="col-md-6 col-xs-12 text-center">
                     <img width="200" height="200" src="${pageContext.servletContext.contextPath}/images/merchant/${imageItem.image}">
                  </div>
               </c:forEach>
            </div>
         </div>
      </div>
      <!-- Modal -->
      <div class="modal fade" id="myModalSch" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
         <div class="modal-dialog">
            <div class="modal-content">
               <div class="modal-header" style="background-color:#1fbbad">
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                  <h4 class="modal-title white-text text-center" id="myModalLabel">Schedule Details</h4>
               </div>
                  <form:form method="POST" action="saveSchedule" modelAttribute="merchant" onsubmit="return validateForm();" class="form-horizontal white-bg" id="creatMerchantForm">
               <div class="modal-body">
                     <center>
                        <div class="btn-group" id="weekdays" data-toggle="buttons" style="margin-bottom:20px">
                           <label class="btn btn-default day-pill font-size-20">
                           <input type="checkbox" checked="" >Sun</label>
                           <label class="btn btn-default day-pill font-size-20">
                           <input type="checkbox" checked="" >Mon</label>
                           <label class="btn btn-default day-pill font-size-20">
                           <input type="checkbox" checked=""  >Tue</label>
                           <label class="btn btn-default day-pill font-size-20">
                           <input type="checkbox" checked="" >Wed</label>
                           <label class="btn btn-default day-pill font-size-20">
                           <input type="checkbox" checked="" >Thur</label>
                           <label class="btn btn-default day-pill font-size-20">
                           <input type="checkbox" checked="" >Fri</label>
                           <label class="btn btn-default day-pill font-size-20">
                           <input type="checkbox" checked="" >Sat</label>
                        </div>
                        <form:input path="schedule[0].weekSchedule" type="hidden" id="scheduleval0" value="${schedule[0].weekSchedule}"/>
                        <form:input path="schedule[1].weekSchedule" type="hidden" id="scheduleval1" value="${schedule[1].weekSchedule}"/>
                        <form:input path="schedule[0].closingTime" type="hidden" id="closingTime0" value="${schedule[0].closingTime}"/>
                        <form:input path="schedule[0].openingTime" type="hidden" id="openingTime0" value="${schedule[0].openingTime}"/>
                        <form:input path="schedule[1].closingTime" type="hidden" id="closingTime1" value="${schedule[1].closingTime}"/>
                        <form:input path="schedule[1].openingTime" type="hidden" id="openingTime1" value="${schedule[1].openingTime}"/>
                     </center>
                     <div class="row row-15" style="margin: 10px 0;">
                        <div class="col-xs-9 col-xs-push-2 font-size-24" style="text-align:center">
                           <div class="row row15">
                              Opening Time
                           </div>
                           <div class="row row15" id="lower-value"><span class="slider-time">${merchant.schedule[0].openTime12Hrs}</span>
                           </div>
                        </div>
                        <div class="col-xs-9 col-xs-push-5 font-size-24" style="text-align:center">
                           <div class="row row15">
                              Closing Time
                           </div>
                           <div class="row row15" id="upper-value"><span class="slider-time2">${merchant.schedule[0].closeTime12Hrs}</span>
                           </div>
                        </div>
                     </div>
                     <div class="col-md-18 col-md-push-3" >
                        <div class="sliders_step1">
                           <div id="slider-range"></div>
                        </div>
                     </div>
                     <div class="row row15">
                        <div class="col-xs-12 col-centered">
                           <input type="button" value="+ Add Another Time Slot" class="time-slot btn btn-green btn-lg" onclick="timeslotadd()" id="addtimebtn">
                        </div>
                     </div>
                     <div id="additional-time" style="display:none">
                        <center>
                           <div class="btn-group" id="weekdaysadd" data-toggle="buttons" style="margin-bottom:20px; margin-top:30px">
                              <label class="btn btn-default day-pill font-size-20">
                              <input type="checkbox" checked="" >Sun</label>
                              <label class="btn btn-default day-pill font-size-20">
                              <input type="checkbox" checked="" >Mon</label>
                              <label class="btn btn-default day-pill font-size-20">
                              <input type="checkbox" checked="" >Tue</label>
                              <label class="btn btn-default day-pill font-size-20">
                              <input type="checkbox" checked="" >Wed</label>
                              <label class="btn btn-default day-pill font-size-20">
                              <input type="checkbox" checked="" >Thur</label>
                              <label class="btn btn-default day-pill font-size-20">
                              <input type="checkbox" checked="" >Fri</label>
                              <label class="btn btn-default day-pill font-size-20">
                              <input type="checkbox" checked="" >Sat</label>
                           </div>
                        </center>
                        <div class="row row-15">
                           <div class="col-xs-9 col-xs-push-2 font-size-24" style="text-align:center">
                              <div class="row row15">
                                 Opening Time
                              </div>
                              <div class="row row15" id="lower-value-add"><span class="slider2-time">${schedule[0].openingTime}</span>
                              </div>
                           </div>
                           <div class="col-xs-9 col-xs-push-5 font-size-24" style="text-align:center">
                              <div class="row row15">
                                 Closing Time
                              </div>
                              <div class="row row15" id="upper-value-add"><span class="slider2-time2">${schedule[0].closingTime}</span>
                              </div>
                           </div>
                        </div>
                        <div class="col-md-18 col-md-push-3" >
                           <div class="sliders_step2">
                              <div id="slider-range2"></div>
                           </div>
                        </div>
                     </div>
               </div>
                     <div class="modal-footer nopadding"  style="background-color:#1fbbad; color: #fff;">
                        <center><input type="submit" value="Save" class="signup-button font-size-16 font-type"></center>
                     </div>
                  </form:form>
            </div>
         </div>
      </div>
      <div class="modal fade" id="myModalAdd" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
         <div class="modal-dialog">
            <div class="modal-content">
               <div class="modal-header" style="background-color:#1fbbad">
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                  <div class="modal-title font-size-20 location-head font-type"  id="myModalLabel">
                     <center>Enter Address Info</center>
                  </div>
               </div>
               <form:form method="POST" action="saveAddress" modelAttribute="merchant" class="form-horizontal white-bg" id="creatMerchantForm">
                  <div class="modal-body" style="text-align:left">
                     <div class="form-group">
                        <label  class="col-sm-4 control-label font-type font-size-16">Address</label>
                        <div class="col-sm-18">
                           <textarea id="address" class="form-control signup-field" name="address" placeholder="Address"  style="resize:none">${merchant.address}</textarea>
                        </div>
                     </div>
                     <div class="form-group">
                        <label class="col-sm-4 control-label font-type font-size-16">Landmark</label>
                        <div class="col-sm-18">
                           <input id="landmark" class="form-control signup-field" type="text" name="landmark" placeholder="Landmark" value="${merchant.landmark }">
                        </div>
                     </div>
                     <div class="form-group">
                        <label class="col-sm-4 control-label font-type font-size-16">City</label>
                        <div class="col-sm-18">
                           <input id="city" class="form-control signup-field" type="text" name="city" placeholder="City" value="${merchant.city }">
                        </div>
                     </div>
                     <div class="form-group">
                        <label class="col-sm-4 control-label font-type font-size-16">State</label>
                        <div class="col-sm-18">
                           <input id="state" class="form-control signup-field" type="text" name="state" placeholder="State" value="${merchant.state }">
                        </div>
                     </div>
                     <div class="form-group">
                        <label class="col-sm-4 control-label font-type font-size-16">Pincode</label>
                        <div class="col-sm-18">
                           <input id="pincode" class="form-control signup-field" type="text" name="pincode" placeholder="Pincode" value="${merchant.pincode }">
                        </div>
                     </div>
                     <div class="form-group">
                        <label class="col-sm-4 control-label font-type font-size-16">Country</label>
                        <div class="col-sm-18">
                           <input id="country" class="form-control signup-field" type="text" name="country" placeholder="Country" value="${merchant.country }">
                        </div>
                     </div>
                  </div>
                  <div class="modal-footer nopadding"  style="background-color:#1fbbad">
                     <center><input type="submit" value="Save" class="signup-button font-size-16 font-type white-text"></center>
                  </div>
               </form:form>
            </div>
         </div>
      </div>
      <div class="modal fade" id="myModalPic" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
         <div class="modal-dialog">
            <div class="modal-content">
               <div class="modal-header" style="background-color:#1fbbad">
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                  <div class="modal-title font-size-20 location-head font-type"  id="myModalLabel">
                     <center>Upload Photos</center>
                  </div>
               </div>
               <form:form method="POST" action="savePhoto" modelAttribute="merchant" enctype="multipart/form-data" class="form-horizontal white-bg" id="creatMerchantForm">
                  <div class="modal-body" style="overflow-y: auto;max-height: 600px;">
                     <div class="row row15">
                        <div class="col-md-21 col-md-push-2 col-sm-21 col-sm-push-2">
                           <div class="row row15 merchant-home-img">
                              <div class="col-md-10 col-centered ">
                                 <center>
                                   <div id="file-upload-cont">
                                      <input type="file" multiple="multiple" name="files" id="file" accept="image/*"/>
                                      <div id="my-button"></div>
                                      <input id="overlay"/>
                                   </div>
                                 </center>
                              </div>
                              <output id="list"></output>
                              <c:forEach var="imageItem" items="${merchant.images}" varStatus="status">
                                 <div class="col-md-12" style="overflow:hidden">
                                    <a href="#" onclick="deleteImage(${imageItem.id} , this);" class="white-text font-size-16" style="position: relative;left: 70px; top: 50px;"><i class="icon-trash"></i> Delete</a>
                                    <img src="${pageContext.servletContext.contextPath}/images/merchant/${imageItem.image}">
                                 </div>
                              </c:forEach>
                           </div>
                        </div>
                     </div>
                  </div>
                  <div class="modal-footer nopadding"  style="background-color:#1fbbad; color: #fff;">
                     <center><input type="submit" value="Save" class="signup-button font-size-16 font-type"></center>
                  </div>
               </form:form>
            </div>
         </div>
      </div>
      <div class="modal fade" id="myModalProfilePic" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
         <div class="modal-dialog">
            <div class="modal-content">
               <div class="modal-header" style="background-color:#1fbbad">
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                  <div class="modal-title font-size-20 location-head font-type"  id="myModalLabel">
                     <center>Upload Photos</center>
                  </div>
               </div>
               <form:form method="POST" action="saveLocation" modelAttribute="merchant" enctype="multipart/form-data" class="form-horizontal white-bg" id="creatMerchantForm">
                  <div class="modal-body" style="text-align:left">
                     <div class="row row15">
                        <div class="col-md-21 col-md-push-2 col-sm-21 col-sm-push-2">
                           <div class="row row15">
                                    <div class="col-sm-10" style="height:225px;">
                                       <div id="file-upload-cont">
                                          <input type="file" multiple="multiple" name="file" id="file" accept="image/*"/>
                                          <div id="my-button"></div>
                                          <input id="overlay"/>
                                       </div>
                                          
                                    </div>
                                       <div class="col-sm-10"><img src="${pageContext.servletContext.contextPath}/images/merchant/${merchant.image}"></div>
                              <output id="list"></output>
                              <div class="col-md-6" style="overflow:hidden">
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
                  <div class="modal-footer nopadding"  style="background-color:#1fbbad; color: #fff;">
                     <center><input type="submit" value="Save" class="signup-button font-size-16 font-type"></center>
                  </div>
               </form:form>
            </div>
         </div>
      </div>
      <div class="modal fade" id="myModalSch" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
         <div class="modal-dialog">
            <div class="modal-content">
               <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                  <h4 class="modal-title" id="myModalLabel">Schedule Details</h4>
               </div>
               <div class="modal-body">
                  ...
               </div>
               <div class="modal-footer nopadding">
                  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                  <button type="button" class="btn btn-primary">Save changes</button>
               </div>
            </div>
         </div>
      </div>
      <div class="modal fade" id="myModalAcc" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
         <div class="modal-dialog">
            <div class="modal-content">
               <div class="modal-header" style="background-color:#1fbbad">
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                  <div class="modal-title font-size-20 location-head font-type"  id="myModalLabel">
                     <center>Contact Details</center>
                  </div>
               </div>
               <form:form method="POST" action="saveContact" modelAttribute="merchant" class="form-horizontal white-bg" id="creatMerchantForm">
                  <div class="modal-body" style="text-align:left">
                     <c:forEach var="phone" items="${merchant.phones}" varStatus="status">
                        <div class="form-group">
                           <label  class="col-sm-4 control-label font-type font-size-16">Phone</label>
                           <div class="col-sm-18">
                              <input id="phone${status.index+1}" type="text" class="form-control signup-field" name="phone${status.index+1}" placeholder="phone"  value="${phone.phone}">
                           </div>
                        </div>
                     </c:forEach>
                     <c:if test="${merchant.phones eq null }">
                        <div class="form-group">
                           <label  class="col-sm-4 control-label font-type font-size-16">Phone</label>
                           <div class="col-sm-18">
                              <input id="phone1" class="form-control signup-field" type="text" name="phone1" placeholder="phone"  >
                           </div>
                        </div>
                        <div class="form-group">
                           <label  class="col-sm-4 control-label font-type font-size-16">Phone</label>
                           <div class="col-sm-18">
                              <input id="phone2" class="form-control signup-field" type="text" name="phone2" placeholder="phone"  >
                           </div>
                        </div>
                        <div class="form-group">
                           <label  class="col-sm-4 control-label font-type font-size-16">Phone</label>
                           <div class="col-sm-18">
                              <input id="phone3" class="form-control signup-field" type="text" name="phone3" placeholder="phone"  >
                           </div>
                        </div>
                     </c:if>
                     <div class="form-group">
                        <label class="col-sm-4 control-label font-type font-size-16">Software</label>
                        <div class="col-sm-18">
                           <input id="software" class="form-control signup-field" type="text" name="software" placeholder="Software" value="${merchant.software}">
                        </div>
                     </div>
                  </div>
                  <div class="modal-footer nopadding"  style="background-color:#1fbbad; color: #fff;">
                     <center><input type="submit" value="Save" class="signup-button font-size-16 font-type"></center>
                  </div>
               </form:form>
            </div>
         </div>
      </div>
      <script type="text/javascript">
         jQuery(document).ready(function(){
           jQuery("#file-upload-cont").hover(
             function(){
             jQuery("#my-button").css("background","url('../images/inputDigitalMenu.png') center center no-repeat");},
             function(){
             jQuery("#my-button").css("background","url('../images/inputDigitalMenu.png') center center no-repeat");
             }
         
           );
         });
      </script>
      <script>
         function handleFileSelect(evt) {
           var files = evt.target.files; // FileList object
         
           // Loop through the FileList and render image files as thumbnails.
           for (var i = 0, f; f = files[i]; i++) {
         
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
                 span.innerHTML = ['<img class="col-md-6" src="', e.target.result,
                                   '" title="', escape(theFile.name), '"/>'].join('');
                 document.getElementById('list').insertBefore(span, null);
               };
             })(f);
         
             // Read in the image file as a data URL.
             reader.readAsDataURL(f);
           }
         }
         document.getElementById('file').addEventListener('change', handleFileSelect, false);
      </script>
      <script type="text/javascript">
         $('input:checkbox').removeAttr('checked');
           $("#weekdays").change(function (e) {
               var checkedDays = $("#weekdays :checkbox").map(function () {
                   return +$(this).is(':checked');
               }).get(); 
               
               $("input#scheduleval0").val(checkedDays.join(""));
               if($("input#scheduleval0").val() == '1111111'){
                 $('#additional-time').css("display","none");
                 $('#addtimebtn').css("display","none");
               }else{
                 $('#addtimebtn').css("display","block");
               }
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
         function timeslotadd()
         {
           document.getElementById("additional-time").style.cssText = "visibility:visible !important;";
           document.getElementById("addtimebtn").style.cssText = "display:none !important;";
         }
         
         function validateForm(){
           if(document.getElementById('scheduleval0').value == '' ){
             alert("Please select weekdays.");
             return false;
           }
           if(document.getElementById('scheduleval1') != "undefined" && document.getElementById('scheduleval1').value != '' &&
               document.getElementById('scheduleval0').value != '' ){
             var arr = document.getElementById('scheduleval0').value.split("");
             var arr1 = document.getElementById('scheduleval1').value.split("");
             for (var i = 0; i < arr.length; i++) {
                 if(arr[i] == '1' && arr1[i] == '1'){
                 alert('Please check schedule days. You cannot have different schedule for any weekday');
                 return false;
               }
             }
           }
           
           return true;
         }
         
         $("#slider-range").slider({
             range: true,
             min: 360,
             max: 1440,
             step: 30,
             values: [420, 1200],
             slide: function (e, ui) {
                 var hours1 = Math.floor(ui.values[0] / 60);
                 var minutes1 = ui.values[0] - (hours1 * 60);
                 if (hours1.length == 1) hours1 = '0' + hours1;
                 if (minutes1.length == 1) minutes1 = '0' + minutes1;
                 if (minutes1 == 0) minutes1 = '00';
                 var uploadLowerValue=hours1+":"+minutes1;
                 if (hours1 >= 12) {
                     if (hours1 == 12) {
                         hours1 = hours1;
                         minutes1 = minutes1 + " PM";
                     } else {
                         hours1 = hours1 - 12;
                         minutes1 = minutes1 + " PM";
                     }
                 } else {
                     hours1 = hours1;
                     minutes1 = minutes1 + " AM";
                 }
                 if (hours1 == 0) {
                     hours1 = 12;
                     minutes1 = minutes1;
                 }
                 $('.slider-time').html(hours1 + ':' + minutes1);
                 $("input[id=openingTime0]").val(uploadLowerValue);
                 var hours2 = Math.floor(ui.values[1] / 60);
                 var minutes2 = ui.values[1] - (hours2 * 60);
             if (hours2.length == 1) hours2 = '0' + hours2;
                 if (minutes2.length == 1) minutes2 = '0' + minutes2;
                 if (minutes2 == 0) minutes2 = '00';
                 var uploadUpperValue=hours2+":"+minutes2;
                 if (hours2 >= 12) {
                     if (hours2 == 12) {
                         hours2 = hours2;
                         minutes2 = minutes2 + " PM";
                     } else if (hours2 == 24) {
                         hours2 = 11;
                         minutes2 = "59 PM";
                     } else {
                         hours2 = hours2 - 12;
                         minutes2 = minutes2 + " PM";
                     }
                 } else {
                     hours2 = hours2;
                     minutes2 = minutes2 + " AM";
                 }
         
                 $('.slider-time2').html(hours2 + ':' + minutes2);
                 
                 $("input[id=closingTime0]").val(uploadUpperValue);
             }
         });
         
         
         $("#slider-range2").slider({
             range: true,
             min: 360,
             max: 1440,
             step: 30,
             values: [420, 1200],
             slide: function (e, ui) {
                 var hours1 = Math.floor(ui.values[0] / 60);
                 var minutes1 = ui.values[0] - (hours1 * 60);
                 if (hours1.length == 1) hours1 = '0' + hours1;
                 if (minutes1.length == 1) minutes1 = '0' + minutes1;
                 if (minutes1 == 0) minutes1 = '00';
                 var uploadLowerValue=hours1+":"+minutes1;
                 if (hours1 >= 12) {
                     if (hours1 == 12) {
                         hours1 = hours1;
                         minutes1 = minutes1 + " PM";
                     } else {
                         hours1 = hours1 - 12;
                         minutes1 = minutes1 + " PM";
                     }
                 } else {
                     hours1 = hours1;
                     minutes1 = minutes1 + " AM";
                 }
                 if (hours1 == 0) {
                     hours1 = 12;
                     minutes1 = minutes1;
                 }
                 $('.slider2-time').html(hours1 + ':' + minutes1);
                 $("input[id=openingTime1]").val(uploadLowerValue);
                 var hours2 = Math.floor(ui.values[1] / 60);
                 var minutes2 = ui.values[1] - (hours2 * 60);
             if (hours2.length == 1) hours2 = '0' + hours2;
                 if (minutes2.length == 1) minutes2 = '0' + minutes2;
                 if (minutes2 == 0) minutes2 = '00';
                 var uploadUpperValue=hours2+":"+minutes2;
                 if (hours2 >= 12) {
                     if (hours2 == 12) {
                         hours2 = hours2;
                         minutes2 = minutes2 + " PM";
                     } else if (hours2 == 24) {
                         hours2 = 11;
                         minutes2 = "59 PM";
                     } else {
                         hours2 = hours2 - 12;
                         minutes2 = minutes2 + " PM";
                     }
                 } else {
                     hours2 = hours2;
                     minutes2 = minutes2 + " AM";
                 }
         
                 $('.slider2-time2').html(hours2 + ':' + minutes2);
                 
                 $("input[id=closingTime1]").val(uploadUpperValue);
             }
         });
         
         function deleteImage(imageid, image){
         $.ajax( "deleteImage?imageId="+imageid )
         .done(function() {
           $(image).parent("div").remove();
           alert( "Image deleted successfully" );
         })
         .fail(function() {
           alert( "error" );
         });
         }
         
         $('#myModalPic').on('hidden.bs.modal', function () {
        	 location.reload();
         });
      </script>
   </body>
</html>
