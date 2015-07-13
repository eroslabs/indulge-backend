<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>

 <head>
    <title>Indulge Merchant</title>
   <jsp:include page="../views/globalhead.jsp"/>
   <meta name="description" content="The premier platform for Spas, Salons and Individuals who provide beauty and wellness services and are looking to increase their reach. Unlimited real time deals! No hidden costs!">
<meta name="keywords" content="More customers in Delhi, Post your deals, Grow your business in Delhi, Get listed for free, Delhi Spa, Gurgaon Spa, Delhi Salon, Gurgaon Salon"> 		
  </head>
<body>
  <jsp:include page="../views/merchantHeader.jsp" />
 
<div class="lh20">&nbsp;</div>
  <div class="container">
    <!-- Nav tabs -->
    <div class="col-xs-24 formRightBody">
      <c:if test="${not empty error_message}">
        <div class="lh10">&nbsp;</div>
        <div class="alert alert-danger">${error_message}</div>
      </c:if>
      <c:if test="${not empty success_message}">
        <div class="lh10">&nbsp;</div>
        <div class="alert alert-success">${success_message}</div>
      </c:if>
      <div class="row row15">
          <c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION}">
            <div class="lh10">&nbsp;</div>
                <div class="alert alert-danger">Unsuccessful Login : <c:out value="${SPRING_SECURITY_LAST_EXCEPTION.message}"/>.</div>
          </c:if>
        </div>
  
    </div>
  </div>
    <div class = "row row15" style="border:1px solid #aea190;">
      <div class="col-md-15" style="padding:0px">
        <div style="background: url('${pageContext.servletContext.contextPath }/images/erosimg/front.jpg') top center no-repeat;background-size:cover;height:480px;width:100%;border-bottom: solid 4px #1fbbad; padding-top:250px">
          <div class="text-center">
            <span style="font-size:36px;color:#ffffff;font-weight:bold;">LOOKING FOR MORE CUSTOMERS ?</span><br>
            <p style="font-size:25px;font:Arial" class="white-text">Join India's fastest growing beauty and wellness marketplace</p>
        <div class="col-md-10 col-centered hidden-xs"><a href="${pageContext.servletContext.contextPath}/register/input" class="btn-green btn btn-lg">SIGNUP AND GET LISTED FOR FREE</a></div>  
	</div>
        </div>
      </div>
      <div class="col-md-9" style="background-color:#1fbbad; border:1px solid #aea190;padding: 60px 0px;height:480px">
        <form class="form-signin col-xs-18 col-xs-push-3" name='form' action='${pageContext.servletContext.contextPath }/j_spring_security_check' method='POST' style="padding:30px; background-color:#acddcf">
              <div class="form-group">
                <label class="sr-only">Email address</label>
                <input type="text" autofocus="" required="" placeholder="Email or Phone no." class="form-control sign-in-username sign-in-place font-size-20" name='username' value='' >
              </div>
              <div class="form-group">
                <label class="sr-only">Password</label>
                <input type="password" required="" placeholder="Password" class="form-control sign-in-pass sign-in-place font-size-20" name='password'>
              </div>
              <div class="form-group font-size-16" style="text-align:right">
                <a href="${pageContext.servletContext.contextPath}/register/inputforgot"> Forgot Password ?</a>
              </div>
              <button type="submit" class="btn btn-lg btn-green" name="submit" style="width: 100%;">Login</button>
              <div class="form-group font-size-20" style="text-align:center; margin-top:10px">
                <a href="${pageContext.servletContext.contextPath}/register/input" style="text-decoration:none;">Don't have an account ? Sign Up.</a>
              </div>
        </form>
      </div>
    </div>
    <div class = "row row15">
      <center style=" font-size:36px; margin-top: 15px;">
        <p style="color:#1FBBAD;"><i class="icon-chevron-down"></i></p>
        <p style="color: rgb(115, 94, 86);" id="benefits">BENEFITS</p>
      </center>
      <div class="col-md-20 col-centered col-sm-22">
        <div class="row">
          <div class="col-sm-12 col-md-8 text-center" style="padding: 0px 30px;">
            <div style="background:url('${pageContext.servletContext.contextPath }/images/erosimg/ic1.png') top center no-repeat;background-size:142px 142px;height:145px;">
            </div>
              <p style="font-size:26px;font-weight: bold; color: rgb(115, 94, 86);">EASY REGISTRATION</p>
              <p class="brown-text">Register automatically online via our simple profile creation process</p>
          </div>
          <div class="col-sm-12 col-md-8 text-center" style="padding: 0px 30px;">
            <div style="background:url('${pageContext.servletContext.contextPath }/images/erosimg/ic2.png') top center no-repeat;background-size:165px 160px;height:145px;">
            </div>
              <p style="font-size:26px;font-weight: bold; color: rgb(115, 94, 86);">GROWING USER BASE</p>
              <p class="brown-text">nstant access to our growing user base. Now anyone in your area can find you easily</p>
          </div>
          <div class="col-sm-12 col-md-8 text-center" style="padding: 0px 30px;">
            <div style="background:url('${pageContext.servletContext.contextPath }/images/erosimg/ic3.png') top center no-repeat;background-size:165px 160px;height:145px;">
            </div>
              <p style="font-size:26px;font-weight: bold; color: rgb(115, 94, 86);">REAL TIME DEALS</p>
              <p class="brown-text">Create a deal and have it instantly accessible to users. Track deal usage to plan future deals</p>
          </div>
          <div class="col-sm-12 col-md-8 text-center" style="padding: 0px 30px;">
            <div style="background:url('${pageContext.servletContext.contextPath }/images/erosimg/ic4.png') top center no-repeat;background-size:142px 142px;height:145px;">
            </div>
              <p style="font-size:26px;font-weight: bold; color: rgb(115, 94, 86);">RECOMMENDATIONS</p>
              <p class="brown-text">Intelligent recommendations for deals, pricing and services based on competitor data</p>
          </div>
          <div class="col-sm-12 col-md-8 text-center" style="padding: 0px 30px;">
            <div style="background:url('${pageContext.servletContext.contextPath }/images/erosimg/ic5.png') top center no-repeat;background-size:165px 160px;height:145px;">
            </div>
              <p style="font-size:26px;font-weight: bold; color: rgb(115, 94, 86);">UNLIMITED DEALS</p>
              <p class="brown-text">Post unlimited deals for free! Test the market, see what works, and get your brand out there</p>
          </div>
          <div class="col-sm-12 col-md-8 text-center" style="padding: 0px 30px;">
            <div style="background:url('${pageContext.servletContext.contextPath }/images/erosimg/ic6.png') top center no-repeat;background-size:165px 160px;height:145px;">
            </div>
              <p style="font-size:26px;font-weight: bold; color: rgb(115, 94, 86);">CUSTOMER SUPPORT</p>
              <p class="brown-text">24/7 customer service by phone and email for all your questions/concerns</p>
          </div>
        </div>
        <p style="color:#1FBBAD; font-size: 36px;" class="text-center"><i class="icon-chevron-down"></i></p>
      </div>
    </div>
    <br>
    <div class="row row15" style="background: #1fbbad;">
      <center>
        <h2 style="color:#ffffff;font-size:47px"><br>WHO SHOULD JOIN</h2>
        <br><br>
        <span style="color: rgb(240, 240, 240);font-size:24px">All Individuals, Salons and Spas that provide any of the following</span><br>
        <span style="color: rgb(240, 240, 240);font-size:24px">services and are interested in expanding their client base</span><br>
      </center>
      <span class="MerchantIcons col-md-24 col-sm-24 text-uppercase" style="margin-bottom:50px;">
        <div class="col-md-3 col-sm-6 col-xs-12"><div style="background:url('${pageContext.servletContext.contextPath }/images/nail1.png') center center no-repeat;background-size:100px 100px;height:120px;"></div><p class="white-text text-center">Nails</p> </div>
        <div class="col-md-3 col-sm-6 col-xs-12"><div style="background:url('${pageContext.servletContext.contextPath }/images/massage1.png') center center no-repeat;background-size:100px 100px;height:120px;"></div><p class="white-text text-center">Spa</p> </div>
        <div class="col-md-3 col-sm-6 col-xs-12"><div style="background:url('${pageContext.servletContext.contextPath }/images/gym1.png') center center no-repeat;background-size:100px 100px;height:120px;"></div><p class="white-text text-center">Fitness</p> </div>
        <div class="col-md-3 col-sm-6 col-xs-12"><div style="background:url('${pageContext.servletContext.contextPath }/images/haircut1.png') center center no-repeat;background-size:100px 100px;height:120px;"></div><p class="white-text text-center">Hair</p> </div>
        <div class="col-md-3 col-sm-6 col-xs-12"><div style="background:url('${pageContext.servletContext.contextPath }/images/makeup1.png') center center no-repeat;background-size:100px 100px;height:120px;"></div><p class="white-text text-center">Makeup</p> </div>
        <div class="col-md-3 col-sm-6 col-xs-12"><div style="background:url('${pageContext.servletContext.contextPath }/images/face1.png') center center no-repeat;background-size:100px 100px;height:120px;"></div><p class="white-text text-center">Face</p> </div>
        <div class="col-md-3 col-sm-6 col-xs-12"><div style="background:url('${pageContext.servletContext.contextPath }/images/hair1.png') center center no-repeat;background-size:100px 100px;height:120px;"></div><p class="white-text text-center">Hair Removal</p> </div>
        <div class="col-md-3 col-sm-6 col-xs-12"><div style="background:url('${pageContext.servletContext.contextPath }/images/body1.png') center center no-repeat;background-size:100px 100px;height:120px;"></div><p class="white-text text-center">Body</p> </div>
      </span>
      <p style="font-size: 36px;" class="text-center white-text"><i class="icon-chevron-down"></i></p>
    </div>

    <div class="row row15" style="background: #f0f0f0; padding-bottom: 50px;">
      <center>
        <h2 style="color: rgb(115, 94, 86);font-size:47px;" id="how_it_works"><br>HOW IT WORKS<br><br></h2>
      
      <div class="row row15">
        
        <div class="col-sm-8" style="margin-bottom:50px;">
          <div style="background:url('${pageContext.servletContext.contextPath }/images/join.png') center center no-repeat;height:316px;">
            <p class="brown-text work-text" style="width: 260px;">Create your profile in minutes with our simple online registration system. Just click on the sign up button below to create your free profile today! Our indulge support team will be in touch within 24hrs to verify your details and publish your profile to our users.</p>
          </div>
        </div>
        
        <div class="col-sm-8"  style="margin-bottom:50px">
          <div style="background:url('${pageContext.servletContext.contextPath }/images/engage.png') center center no-repeat;height:316px;">
            <p class="brown-text work-text" style="width: 260px;">Engage with your clients via our review and deal request features, get feedback and better understand their needs. Understand your competitors, what works for them and what doesnt, with our intelligent comparison algorithms.</p>
          </div>
        </div>
        
        <div class="col-sm-8"  style="margin-bottom:50px">
          <div style="background:url('${pageContext.servletContext.contextPath }/images/optimize.png') center center no-repeat;height:316px;">
            <p class="brown-text work-text" style="width: 260px;">Promote your brand and expand your business with the power of all this information. Fill up those quiet periods with our real time deals. Optimize your marketing, hiring and establishment expenses using our client and competitor data and truly add value to your business.</p>
          </div>
        </div>
      </div>
      <h2 style="color: rgb(115, 94, 86);font-size:32px;">Its that simple !</h2>
      </center>
    </div>
    <jsp:include page="../views/merchantFooter.jsp" />
    <jsp:include page="../views/includeScript.jsp" />
</body>
</html>
