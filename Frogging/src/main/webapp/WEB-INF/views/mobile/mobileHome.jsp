<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
		<link rel="stylesheet" href="/css/p_style.css" type="text/css"/>
		<link rel="preconnect" href="https://fonts.gstatic.com">
		<link href="https://fonts.googleapis.com/css2?family=Black+And+White+Picture&family=Black+Han+Sans&family=Cute+Font&family=Do+Hyeon&family=Dokdo&family=East+Sea+Dokdo&family=Gaegu&family=Gamja+Flower&family=Gothic+A1&family=Gugi&family=Hi+Melody&family=Jua&family=Kirang+Haerang&family=Nanum+Brush+Script&family=Nanum+Gothic&family=Nanum+Gothic+Coding&family=Nanum+Myeongjo&family=Nanum+Pen+Script&family=Noto+Sans+KR&family=Noto+Serif+KR&family=Poor+Story&family=Single+Day&family=Song+Myung&family=Stylish&family=Sunflower:wght@300&family=Yeon+Sung&display=swap" rel="stylesheet">
	  	<meta name="viewport" content="width=device-width,initial-scale=1">
		<style>
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
		.mobileBody{
		height:100%;
		 background-image:url(../img/plogging4.jfif);
		}
		.mobile-plogging-btn{
			height:100px;
			width:130px;
			background-color: #2fb86a;
			font-family: 'Noto Sans KR', sans-serif;
			color:white;
			font-weight: bold;
			font-size: 18px;
			border : 1px solid white;
   			border-radius:5px;
			position: absolute;
			left:50%;
			top: 50%;
			transform: translate(-50%, -50%);
		}
		.mobile-plogging-btn:hover{
		}
		.mobileMenu-back{
			text-align:center;
		}
		</style>
	</head>
<body>
	<div class="container" style="height:100vh;">
		<div class="mobileTop">
		    <div class="moble_logo" style="height:100px;">
	       	<img src="../img/logo.png" alt="로고" style="width:180px; height:80px; margin-top:10px;">
			</div>
			<div class="mobileMenu">
			<ul>
			<li><a href="/" class="mobileMenu-back">뒤로가기</a></li>	
              <!--  	<li><a href="/logout" class="mobileMenu-log">로그아웃</a></li> -->      
			</ul>
			</div>
		</div>
		<div class="mobileBody">	
            <input type="button" value="측정하기" class="mobile-plogging-btn" onclick="location.href='mobileList'"/>
		</div>	
	</div>
</body>
</html>