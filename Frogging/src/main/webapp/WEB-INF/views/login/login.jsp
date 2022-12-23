<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" href="/css/login.css" type="text/css"/>
		<script src="https://accounts.google.com/gsi/client" async defer></script>
	</head>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Black+And+White+Picture&family=Black+Han+Sans&family=Cute+Font&family=Do+Hyeon&family=Dokdo&family=East+Sea+Dokdo&family=Gaegu&family=Gamja+Flower&family=Gothic+A1&family=Gugi&family=Hi+Melody&family=Jua&family=Kirang+Haerang&family=Nanum+Brush+Script&family=Nanum+Gothic&family=Nanum+Gothic+Coding&family=Nanum+Myeongjo&family=Nanum+Pen+Script&family=Noto+Sans+KR&family=Noto+Serif+KR&family=Poor+Story&family=Single+Day&family=Song+Myung&family=Stylish&family=Sunflower:wght@300&family=Yeon+Sung&display=swap" rel="stylesheet">	
<style>
.s_container{
height:100%;
 background-image:url(./img/plogging2.jpg);
}
.loginForm{
	width: 300px;
	height:300px;
    background-color: #f8f8f8;
    opacity: 0.85;
    margin-right: auto;
    margin-left: auto;
    margin-top: 50px;
    padding: 20px;
    text-align: center;
    border: none;
    font-family: 'Noto Sans KR', sans-serif;
}
.google-btn{
	text-decoration: none;
	height: 50px;
    width: 200px;
    background-color: #2fb86a;
    border : 1px solid white;
    border-radius:5px;
    color: white;
    font-weight: bold;
    font-size: 1.2em;
    margin: 130px 20px 10px 20px;
    font-family: 'Noto Sans KR', sans-serif;
}
   	.mobileLogin{display:none;}
    @media screen and (min-width:152px) and (max-width:1024px){
    .loginForm{
    	height:300px;
    }
	/*.s_container{display:none;}*/
	.mobileLogin{display:block; z-index:1;}
   	.s_container{
    min-height: 1000px;
    position: fixed;
 	background-image:url(./img/plogging4.jfif);
	}
	.mobileTop{
		display:flex;
		justify-content: space-between;
		background-color:#2fb86a;
	}
	.mobileMenu > ul >li{
		display: inline-block;
		font-family: 'Noto Sans KR', sans-serif;
		line-height: 80px;
		font-size: 18px;
		margin: auto 20px;
		font-weight: bold;
		text-decoration:none;
	}
	.mobileMenu > ul >li>a{
		color:white;
	}
	.mobileMenu-log{
		width:200px;
		text-align:center;
	}
	}
</style>
<script>

	function handleCredentialResponse(response) {
        console.log("Encoded JWT ID token: " + response.credential);
      }
      window.onload = function () {
        google.accounts.id.initialize({
          client_id: "855667674068-setoafdstkuk2jg4tqiv3gut3kqaamfp.apps.googleusercontent.com",
          callback: handleCredentialResponse
        });
        google.accounts.id.renderButton(
          document.getElementById("buttonDiv"),
          { theme: "outline", size: "large" }  // customization attributes
        	 
        );
        //google.accounts.id.prompt(); // also display the One Tap dialog
      }
      function decodeJwtResponse(token) {
		    var base64Url = token.split('.')[1];
		    var base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
		    var jsonPayload = decodeURIComponent(atob(base64).split('').map(function(c) {
		        return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
		    }).join(''));

		    return JSON.parse(jsonPayload);
		};
      function handleCredentialResponse(response) {
    	     const responsePayload = decodeJwtResponse(response.credential);

    	     console.log("ID: " + responsePayload.sub);
    	     console.log('Full Name: ' + responsePayload.name);
    	     console.log('Given Name: ' + responsePayload.given_name);
    	     console.log('Family Name: ' + responsePayload.family_name);
    	     console.log("Email: " + responsePayload.email);
    	     
    	     location.href = "/login/loginOk?id="+responsePayload.email+"&name="+responsePayload.name; 
    	  }
      
</script>
<body>
<div class="mobileLogin">
	<div class="container" style="height:100px; width:100%;">
		<div class="mobileTop">
		    <div class="moble_logo" style="height:100px;">
	       	<img src="../img/logo3.png" alt="로고" style="width:150px; height:80px; margin-top:10px;">
			</div>
			<div class="mobileMenu">
			<ul>	  
				<li><a href="/" class="mobileMenu-log">뒤로가기</a></li>  
			</ul>
			</div>
		</div>
	</div>	
</div>
	<div class="s_container">
	</br><h1 style="color:white;">로그인 페이지</h1></br>
		<div class="loginForm">
			<h2>구글 로그인</h2>
			<hr/>
			<ul>
				<div id="buttonDiv" stlye="300px;"></div> 
				<input type="button" value="google 가입하러가기" class="google-btn" onclick="location.href='https://accounts.google.com/'"/>
			</ul>
		</div>
	</div>	
</body>
</html>