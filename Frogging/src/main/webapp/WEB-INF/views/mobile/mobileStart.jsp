<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
		<script
	src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xx0e16f9f2f8cc49c8af5c5ad4cc51a5c2"></script>
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
			line-height: 100px;
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
		.mobile-plogging-btn:hover{
			
		}
		</style>
<script>
	var check = "${course.course_no}";
	if(check == -1){
		alert("해당 코스는 없습니다.");
		history.go(-1);
	} else {
		var courseType = "${course.type}";
		var detail_arr = new Array();
			<c:forEach items = "${courseDetail}" var = "courseDetail">
				detail_arr.push({
					course_no : "${courseDetail.course_no}",
					waypoint : "${courseDetail.waypoint}",
					lat : "${courseDetail.lat}",
					log : "${courseDetail.log}",
					addr : "${courseDetail.addr}"
				});
			</c:forEach>
	}
</script>
<script src="/js/watch_position.js" ></script>
	</head>
<body>
	<div class="container" style="height:100vh;">
		<div class="mobileTop">
		    <div class="moble_logo" style="height:100px;">
	       	<img src="../img/logo.png" alt="로고" style="width:180px; height:80px; margin-top:10px;">
			</div>
			<div class="mobileMenu">
			<ul>
				
              	<li><a href="/login" class="mobileMenu-log">로그인</a></li>  
              	<li><a href="/logout" class="mobileMenu-log">로그아웃</a></li>
     
			</ul>
			</div>
		</div>
		<div class="mobileBody">		
			<div onload="initTmap();">
				<div id="map_wrap" class="map_wrap3">
						<div id="map_div"></div>
				</div>
				
				<div>
			    <form method = "post" id = "checkCourseForm">
			    	쓰레기 처리량 : <input type = "text" id = "amount_trash" name = "amount_trash">
			    	파티번호 : <input type = "text" id = "sort" name = "sort">
			    	<input type = "submit" value = "이동한 코스 저장">
			    </form>
	   			 <p id="demo">show error please</p>
			    <input type = "button" value = "위치 확인 시작" onclick = "startChecking();">
			    <input type = "button" value="확인를 끝낸다" onclick = "endChecking();" />
				</div>
			</div>
		</div>	
	</div>
</body>
</html>