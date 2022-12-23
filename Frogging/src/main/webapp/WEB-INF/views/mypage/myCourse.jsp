<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<head>
	<link rel="stylesheet" href="/css/k_style.css">
	<link rel="stylesheet" href="https://use.typekit.net/mss6mty.css">
	<script src="https://kit.fontawesome.com/ab847241fd.js" crossorigin="anonymous"></script>
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
	mapLoad_2(map_arr, detail_arr);
}
	
	</script>
	<script src="/js/tmap_list.js"></script>
</head>
<body class="k_body" onload="initTmap();">
	<section>
		<div class="k_wrapper">

			<div class="k_section_title_links">
				<div>
					<i class="fa-solid fa-square-caret-right k_green"></i>
					<a href="/mypage/my">
						마이페이지
					</a>
					<a href="/mypage/myCourse">
						<i class="fa-solid fa-angle-right"></i>
						나의 코스
					</a>
				</div>
			</div>

			<div class="k_section_title">
				<div class="k_green" >
					프로거 ${logNickName }가
				</div>
				<div>작성한 코스</div>
			</div>
	
		</div>
	</section>

	<section class="k_mycourse">
		<div class="k_wrapper">
			<ul class="k_mycourse_list">
				<c:forEach var="vo" items="${c_list}">
					<a href="/mypage/myCourseView?no=${vo.course_no}">
					<li class="k_mycourse_list_one">
						<ul class="k_a_each_box">
							<li><div id="map_div_${vo.course_no }"></div></li>
							<%-- <li><img src="/img/course_sample.png" alt=""></li> --%>
							<li class="k_a_main_info">${vo.course_name}</li>
							<%-- <li class="k_a_main_info">위</li> --%>
							<li class="k_a_div"></li>
							<li>예상 거리: ${vo.distance}km</li>
							<li>예상 시간: ${vo.time}분</li>
							<li>위치 : ${vo.addr}</li>
						</ul>
					</li>
					</a>
				</c:forEach>

			</ul>
			

			<!-- recommand path paging -->
						<ul class="k_rec_path_page">
						
							<%-- 이전페이지 --%>
							<c:if test="${mvo.nowPage<=1 }">
								<li><i class="fa-solid fa-chevron-left active"></i></li>
							</c:if>
							<c:if test="${mvo.nowPage>1}" >
								<li><a href="/mypage/myCourse?nowPage=${mvo.nowPage-1 }"><i class="fa-solid fa-chevron-left active"></i></a></li>
							</c:if>
								
							<c:forEach var="p" begin="${mvo.startPage }" end="${mvo.startPage + mvo.onePageCount - 1 }" >
								<c:if test="${p<=mvo.totalPage }" >
									<li
									<c:if test="${p==mvo.nowPage }">
										style = "color:#2fb86a;"
									</c:if>
									><a href="/mypage/myCourse?nowPage=${p }">${p }</a></li>
								</c:if>
							</c:forEach>
								
							<!-- 다음페이지 -->
							<c:if test="${mvo.nowPage>=mvo.totalPage }" > 
								<li><i class="fa-solid fa-chevron-right active"></i></li>
							</c:if>
							<c:if test="${mvo.nowPage<mvo.totalPage}" > 
									<li><a href="/mypage/myCourse?nowPage=${mvo.nowPage-1 }"><i class="fa-solid fa-chevron-right active"></i></a></li>
							</c:if>
						</ul>
		</div>
	</section>
</body>