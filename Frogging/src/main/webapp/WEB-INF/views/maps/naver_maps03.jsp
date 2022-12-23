<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <title>간단한 지도 표시하기</title>
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=lmvzp9q6q8"></script>
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=lmvzp9q6q8&submodules=geocoder"></script>
<script src = "https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel = "stylesheet" href = "/js_css/style.css" type = "text/css">
<style>
</style>
</head>
<body>
	<div class = "course_list">
		<ui id = "course">
			<c:forEach var = "courseList" items = "${courseList }">
				<li>${courseList.course_no }</li>
				<li>${courseList.course_name }</li>
				<li>${courseList.course_info }</li>
				<li>${courseList.distance }</li>
				<li>${courseList.time }</li>
				<li>${courseList.startaddr }</li>
				<li>${courseList.endaddr }</li>
				<li><a href = "/maps/mapsDelete/${courseList.course_no }">${courseList.course_name } 삭제</a></li>
			</c:forEach>
		</ui>
	</div>
</body>
</html>