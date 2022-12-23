<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src = "https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script
	src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xx0e16f9f2f8cc49c8af5c5ad4cc51a5c2"></script>
<script src="/js/tmap_insert_user.js"></script>
	
<link rel = "stylesheet" href = "/js_css/style.css" type = "text/css">
<style>
</style>
</head>
<body onload="initTmap();">
	<div id="map_div" style = "height : 100%;">
	<div class="map_act_btn_wrap clear_box" style="position: absolute;z-index: 1;padding-left: 10px;">
				<button onClick="drawPolyline()">라인 그리기</button>
				<button onClick="clearDrawing()"><b>라인 삭제하기</b></button>
			</div>
	</div>
	
		<form method = "post" id = "courseForm">
			코스명 : <input type = "text" id = "course_name" name = "course_name">
			코스에 대한 메모 : <textarea id = "course_info" name = "course_info"></textarea>
			<input type = "submit" id = "course" name = "course" value = "코스 생성">
		</form>
		<br />
		<input type = "text" id = "searchStart" onKeypress="javascript:if(event.keyCode==13){searchPlace(this.value)}">
		<div class="rst mCustomScrollbar">
			<ul id="searchResult" name="searchResult">
				<li>검색결과</li>
			</ul>
		</div>
</body>
</html>