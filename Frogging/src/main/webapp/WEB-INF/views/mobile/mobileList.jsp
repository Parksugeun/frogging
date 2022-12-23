<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/k_style.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Black+And+White+Picture&family=Black+Han+Sans&family=Cute+Font&family=Do+Hyeon&family=Dokdo&family=East+Sea+Dokdo&family=Gaegu&family=Gamja+Flower&family=Gothic+A1&family=Gugi&family=Hi+Melody&family=Jua&family=Kirang+Haerang&family=Nanum+Brush+Script&family=Nanum+Gothic&family=Nanum+Gothic+Coding&family=Nanum+Myeongjo&family=Nanum+Pen+Script&family=Noto+Sans+KR&family=Noto+Serif+KR&family=Poor+Story&family=Single+Day&family=Song+Myung&family=Stylish&family=Sunflower:wght@300&family=Yeon+Sung&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/ab847241fd.js" crossorigin="anonymous"></script>
<script
	src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xxc6985a9bef1d438f939779b9bf5e79d8"></script>
<style>
.mobileListWrap{
	font-family: 'Noto Sans KR', sans-serif;
}
.listArea > ul >li{
	display: inline-block;
}
#mobileListPage, #courseSearchForm{
	width:80%;
	margin:0 auto;
	text-align:center;
}
#mobileListPage > ul >li{
	display: inline-block;
	text-decoration:none;	
}
#mobileListPage > ul >li>a{
	text-decoration:none;
	color : gray;
}

.listArea{
	display:flex;
}
.k_rec_path_box >li{
	display:flex;
	margin:0 auto;
}
.moblieList-btn{
	background-color:#2fb86a; 
	color:white; 
	border : 1px solid white; 
	height:50px; 
	width:100px; 
	margin:5px 10px; 
	font-weight: bold; 
	font-size: 18px;
	border : 1px solid #2fb86a; 
	border-radius:5px;
	}
</style>
<script type = "text/javascript">
$(function(){
	$("#courseSearchForm").submit(function(){
		if($("#searchName").val()==""){
			alert("코스 이름을 입력해주세요.");
			return false;
		}
		return true;
	});
});

function confirmCourse(course_name, course_no){
	if(confirm(course_name + "를 선택하시겠습니까?")){
		window.location.href='/mobile/maps/geolocation01/'+course_no;
	}
}
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
		<div class="mobileListWrap">
		<!-- 190430 기존 지도를 모두 이미지 처리 위해 주석 처리 S -->
		<form method = "get" id = "courseSearchForm" style="height:50px;">
			<select name = "searchKey" style="height:50px;">
				<option value = "course_name">코스 이름</option>
				<option value = "course_no">코스 번호</option>
			</select>
			<input type = "text" name = "searchWord" id = "searchWord" style="height:46px; width:50%;">
			<input type = "submit" name = "Search" value="찾기" class="moblieList-btn">
		</form>
		<div id="map_wrap" class="map_wrap3">
			<c:forEach var = "courseList" items = "${courseList }">
				<div class ="listArea" onclick = "confirmCourse('${courseList.course_name }','${courseList.course_no}')" style=" border : 5px solid #2fb86a; border-radius:25px; margin: 15px 80px;">
					<ul class = "k_rec_path_box" style="width:80%; margin:0 auto; float:center">
						<span style="width:35%; float:left;">
						<br>
						<li class = "k_rec_path_title k_green">${courseList.course_no }, ${courseList.course_name }</li>
						<br>
						<li>${courseList.course_info }</li>
						<li>예상 거리 : ${courseList.distance }km</li>
						<li>예상 시간 : ${courseList.time }분</li>
						</span>
						<span style = "float:right;">
						<li><div id="map_div_${courseList.course_no }"></div></li>
						</span>	
					</ul>
				</div>
			</c:forEach>
		</div>
		<div class="map_act_btn_wrap clear_box"></div>
		<p id="result"></p>
		<br />
			<div>
		<div id = "mobileListPage">
			<ul class="k_rec_path_page">
			<!-- page 번호 -->
				<c:if test="${cpvo.nowPage<=1 }">
					<li><i class="fa-solid fa-chevron-left active"></i></li>
				</c:if>
				<c:if test = "${cpvo.nowPage > 1 }"><!-- 이전 page가 있을 때 -->
					<li><a href = "/mobile/mobileList?nowPage=${cpvo.nowPage-1 }<c:if test='${cpvo.searchWord!=null }'>&searchKey=${cpvo.searchKey }&searchWord=${cpvo.searchWord }</c:if>"><i class="fa-solid fa-chevron-left active"></i></a></li>
				</c:if>
				
				<c:forEach var = "p" begin = "${cpvo.startPage }" end = "${cpvo.startPage + cpvo.onePageCount - 1 }">
					<!-- 출력할 page 번호가 총 page보다 작거나 같을 때 -->
					<c:if test = "${p <= cpvo.totalPage}">
						
						<li 
						
						<c:if test = "${p == cpvo.nowPage }">
							style = "color:#2fb86a;"
						</c:if>
						
						><a href = "/mobile/mobileList?nowPage=${p }<c:if test='${cpvo.searchWord!=null }'>&searchKey=${cpvo.searchKey }&searchWord=${cpvo.searchWord }</c:if>">${p }</a></li>
						
					</c:if>
				</c:forEach>
				
				<c:if test="${cpvo.nowPage>=p_PageVO.totalPage }" > 
					<li><i class="fa-solid fa-chevron-right active"></i></li>
				</c:if>
				<!-- 다음 page -->
				<c:if test = "${cpvo.nowPage < cpvo.totalPage }">
					<li><a href = "/mobile/mobileList?nowPage=${cpvo.nowPage + 1 }<c:if test='${cpvo.searchWord!=null }'>&searchKey=${cpvo.searchKey }&searchWord=${cpvo.searchWord }</c:if>"><i class="fa-solid fa-chevron-right active"></i></a></li>
				</c:if>
			</ul>
		</div>
	</div>
</div>	
</body>
</html>