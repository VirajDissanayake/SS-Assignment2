<%--
  Created by IntelliJ IDEA.
  User: viraj
  Date: 8/31/18
  Time: 6:40 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <style>
        * {box-sizing: border-box}
        body {font-family: Verdana, sans-serif; margin:0}
        .mySlides {display: none}
        img {vertical-align: middle;}

        .slideshow-container {
            max-width: 1000px;
            position: relative;
            margin: auto;}
        h2,h4 {color: white; font-family: Arial}

        .fade {
            -webkit-animation-name: fade;
            -webkit-animation-duration: 1.5s;
            animation-name: fade;
            animation-duration: 1.5s;
        }

        @-webkit-keyframes fade {
            from {opacity: .4}
            to {opacity: 1}
        }

        @keyframes fade {
            from {opacity: .4}
            to {opacity: 1}
        }

        @media only screen and (max-width: 300px) {
            .prev, .next,.text {font-size: 11px}
        }
    </style>
    <title>Login</title>
    <script>
        function request() {
            //Request parameter defining
            var CLIENT_ID = "2088508851400874";
            var RESPONSE_TYPE = "code";
            var URI = "https://localhost:8443/callback";
            var AUTH_FB_ENDPOINT = "https://www.facebook.com/dialog/oauth";
            var SCOPE = "public_profile user_friends user_link user_gender user_photos";
            //Authorization Request Endpoint
            var REQUEST_ENDPOINT = AUTH_FB_ENDPOINT + "?" + "client_id=" + encodeURIComponent(CLIENT_ID) + "&" + "response_type=" + encodeURIComponent(RESPONSE_TYPE) + "&" +
                "redirect_uri=" + encodeURIComponent(URI) + "&" + "scope=" + encodeURIComponent(SCOPE);
            window.location.href= REQUEST_ENDPOINT;
        }
    </script>
</head>
<body background="fb.jpeg">

<div class="slideshow-container" align="center">
    <h2>SLIIT June intake UWP App</h2>
    <div class="mySlides fade">
        <img src="1.PNG" style="width:50%; height: 50%">
    </div>

    <div class="mySlides fade">
        <img src="2.PNG" style="width:50%; height: 50%">
    </div>

    <div class="mySlides fade">
        <img src="3.PNG" style="width:50%; height: 50%">
    </div>
    <div class="mySlides fade">
        <img src="4.PNG" style="width:50%; height: 50%">
    </div>
    <div class="mySlides fade">
        <img src="5.PNG" style="width:50%; height: 50%">
    </div>
    <div class="mySlides fade">
        <img src="6.PNG" style="width:50%; height: 50%">
    </div>
</div>
<script>
    var slideIndex = 0;
    showSlides();

    function showSlides() {
        var i;
        var slides = document.getElementsByClassName("mySlides");
        for (i = 0; i < slides.length; i++) {
            slides[i].style.display = "none";
        }
        slideIndex++;
        if (slideIndex > slides.length) {slideIndex = 1}
        slides[slideIndex-1].style.display = "block";
        setTimeout(showSlides, 2000);
    }
</script>
     <div style="width:400px;margin:auto;padding-top:30px; align-content: center">
         <br><input type="image" src="Vk9SO.png" alt="login" onclick="request()" height="60px" width="370px"></button><br><br>
         <h4>This app requires yours information. Please login to continue</h4>
     </div>
</body>
</html>
