<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xx0e16f9f2f8cc49c8af5c5ad4cc51a5c2"></script>
<script type = "text/javascript">
function initTmap() {
	// 1. 지도 띄우기
	var map_arr = new Array();
	var detail_arr = new Array();
	
	<c:forEach items = "${courseList}" var = "courseList">
		map_arr.push({
			course_no : "${courseList.course_no}",
			course_name : "${courseList.course_name}",
			course_info : "${courseList.course_info}",
			distance : "${courseList.distance}",
			time : "${courseList.time}",
			type : "${courseList.type}"
		});
	</c:forEach>
	
	<c:forEach items = "${courseDetail}" var = "courseDetail">
		detail_arr.push({
			course_no : "${courseDetail.course_no}",
			waypoint : "${courseDetail.waypoint}",
			lat : "${courseDetail.lat}",
			log : "${courseDetail.log}",
			addr : "${courseDetail.addr}"
		});
	</c:forEach>
	
	console.log(map_arr);
	console.log(detail_arr);
	mapLoad(map_arr, detail_arr);
}
</script>
<script src="/js/tmap_list.js"></script>
</head>
<body onload="initTmap();">
		<!-- 190430 기존 지도를 모두 이미지 처리 위해 주석 처리 S -->
		<div id="map_wrap" class="map_wrap3">
			<c:forEach var = "courseList" items = "${courseList }">
				<div id="map_div_${courseList.course_no }"></div>
				${courseList.course_no }, ${courseList.course_name }, ${courseList.course_info }, ${courseList.distance },${courseList.time }
			</c:forEach>
		</div>
		<div class="map_act_btn_wrap clear_box"></div>
		<p id="result"></p>
		<br />
			<div>
		<ul id = "page">
		<!-- page 번호 -->
			<c:if test = "${cpvo.nowPage > 1 }"><!-- 이전 page가 있을 때 -->
				<li><a href = "/maps/tmap02?nowPage=${cpvo.nowPage-1 }">prev</a></li>
			</c:if>
			
			<c:forEach var = "p" begin = "${cpvo.startPage }" end = "${cpvo.startPage + cpvo.onePageCount - 1 }">
				<!-- 출력할 page 번호가 총 page보다 작거나 같을 때 -->
				<c:if test = "${p <= cpvo.totalPage}">
					
					<li 
					
					<c:if test = "${p == cpvo.nowPage }">
						style = "background-color : #f00"; color : #fff;"
					</c:if>
					
					><a href = "/maps/tmap02?nowPage=${p }">${p }</a></li>
					
				</c:if>
			</c:forEach>
			
			<!-- 다음 page -->
			<c:if test = "${cpvo.nowPage < cpvo.totalPage }">
				<li><a href = "/maps/tmap02?nowPage=${cpvo.nowPage + 1 }">next</a></li>
			</c:if>
		</ul>
	</div>
</body>
</html>