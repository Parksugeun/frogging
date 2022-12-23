<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
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
	
	<c:forEach items = "${list}" var = "courseList">
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
<script src="/js/k_script.js" type="text/javascript"></script>
<script src="/js/k_path.js" type="text/javascript"></script>
</head>
<body onload="modal_more(); initTmap();" class="k_body">
		<!-- --------- ALONE with rec paths --------- -->
		<section class="k_new_party_rec_path">
			<div class="k_wrapper">
				<div class="k_section_title_links">
					<div>
						<i class="fa-solid fa-square-caret-right k_green"></i>
						<a href="/">
							플로깅하기 
						</a>
						<a href="/alone/alone_rec_path">
							<i class="fa-solid fa-angle-right"></i>
							혼자하기
						</a>
						<i class="fa-solid fa-angle-right"></i>
						추천 경로 찾기
					</div>
				</div>
				
				<div class="k_section_title">
					<div>오늘은 혼자 걷고 싶어!</div>
					<div class="k_green">프로깅 혼자하기 <i class="fa-solid fa-circle-plus"></i></div>
				</div>
			</div>
			<!-- ----------- recommendation path ------------->
			<div class="k_path_list">
				<div class="k_wrapper">
					<ul class="k_rec_path_button">
						<li class="active"><a href="/alone/alone_rec_path">추천 코스 선택하기</a></li>
						<li><a href="/alone/alone_new_path">나만의 코스 만들기</a></li>
					</ul>

					<div class="k_path_list_bg">
						<!-- recommendation path select -->
						<form  method="get" id="pathSearchFrm" onclick="searchPath();">
							<div class="k_rec_path_select">
								<span>내 근처의 플로깅 코스: </span>
								<div>
									<div>
										<select name="addr_section_1" id="addr_section_1"  onchange="changeAddr()">
											<c:forEach var="vo" items="${addr_1}">
												<option value="${vo.addr_section_1}">${vo.addr_section_1}</option>
											</c:forEach>
										</select>
									</div>
									<div>
										<select name="addr_section_2" id="addr_section_2">
											<option value="">세부 선택</option>
											<c:forEach var="vo" items="${addr_2}">
												<option value="${vo.addr_section_2}">${vo.addr_section_2}</option>
											</c:forEach>
										</select>
									</div>
								</div>
								<button class="k_rec_path_search_btn">검색</button>
							</div>
						</form>

						<!-- path lists -->
						<ul class="k_rec_path_list_view">
							<c:forEach var="vo" items="${list}">
								<li class="open_modal" onclick="modal_data(${vo.course_no})">
									<ul class="k_rec_path_box">
										<li class="k_rec_path_title k_green">${vo.course_name}</li>
										<li>${vo.addr}</li>
										<li class="k_box_space"></li>
										<li>예상 소요시간: ${vo.time}분</li>
										<li>당월 방문 수: ${vo.plog_total}회</li>
										<li class="k_more"><div id="map_div_${vo.course_no }"></div></li>
									</ul>
								</li>
							</c:forEach>
						</ul>
					
						<!-- recommand path paging -->
						<ul class="k_rec_path_page">
						
							<%-- 이전페이지 --%>
							<c:if test="${p_PageVO.nowPage<=1 }">
								<li><i class="fa-solid fa-chevron-left active"></i></li>
							</c:if>
							<c:if test="${p_PageVO.nowPage>1}" >
								<li><a href="/alone/alone_rec_path?nowPage=${p_PageVO.nowPage-1 }<c:if test="${pVO.addr_section_2!=null }">&addr_section_1=${p_PageVO.addr_section_1 }&addr_section_2=${p_PageVO.addr_section_2 }</c:if>"><i class="fa-solid fa-chevron-left active"></i></a></li>
							</c:if>
								
							<c:forEach var="p" begin="${p_PageVO.startPage }" end="${p_PageVO.startPage + p_PageVO.onePageCount - 1 }" >
								<c:if test="${p<=p_PageVO.totalPage }" >
									<li
									<c:if test="${p==p_PageVO.nowPage }">
										style = "color:#2fb86a;"
									</c:if>
									><a href="/alone/alone_rec_path?nowPage=${p }<c:if test="${p_PageVO.addr_section_2!=null }">&addr_section_1=${p_PageVO.addr_section_1 }&addr_section_2=${p_PageVO.addr_section_2 }</c:if>">${p }</a></li>
								</c:if>
							</c:forEach>
								
							<!-- 다음페이지 -->
							<c:if test="${p_PageVO.nowPage>=p_PageVO.totalPage }" > 
								<li><i class="fa-solid fa-chevron-right active"></i></li>
							</c:if>
							<c:if test="${p_PageVO.nowPage<p_PageVO.totalPage}" > 
									<li><a href="/alone/alone_rec_path?nowPage=${p_PageVO.nowPage-1 }<c:if test="${pVO.addr_section_2!=null }">&addr_section_1=${p_PageVO.addr_section_1 }&addr_section_2=${p_PageVO.addr_section_2 }</c:if>"><i class="fa-solid fa-chevron-right active"></i></a></li>
							</c:if>
						</ul>
					</div>

					<!-- --------- PARTY Details--------- -->
					<section class="k_selected_path_detail modal">
						<div class="k_wrapper modal_body">
							<div class="k_path_detail_box">
								<div class="k_path_map"></div>
								<ul class="k_path_infos">
									<li class="k_green">코스 이름</li>
									<li id = "k_coursename"><span>가볍게 응봉산 코스</span></li>
									<li class="k_green">시작 위치</li>
									<li id = "k_startaddr"><span>응봉산 팔각정 응봉산 팔각정 응봉산 팔각정 응봉산 팔각정 응봉산 팔각정</span></li>
									<li class="k_green">도착 위치</li>
									<li id = "k_endaddr"><span>응복역 4번 출구</span></li>
									<li class="k_green">소요 시간</li>
									<li id = "k_time"><span>50 min</span></li>
									<li class="k_green">이동 거리</li>
									<li id = "k_distance"><span>4 km</span></li>
									<li class="k_green">이번 달 방문 횟수</li>
									<li id = "k_plog_total"><span>12회</span></li>
								
									<%-- image --%>
									<%-- <div>
										<ul class="k_path_images">
											<li><i class="fa-solid fa-chevron-left"></i></li>
											<li><img src="/img/course_detail_sample.jpeg" alt=""></li>
											<li><img src="" alt=""></li>
											<li><img src="" alt=""></li>
											<li><i class="fa-solid fa-chevron-right"></i></li>
										</ul>
									</div> --%>
								</ul>
								
							</div>

							<div class="k_party_detail_join">
								<div class="k_close_popup click-btn">돌아가기</div>
								<%-- <div class="click-btn">파티 참여 신청하기</div> --%>
							</div>
						</div>
					</section>

					<div class="k_alone_start_button">
						<div><a href="/mobile/mobileList">혼자 프로깅 시작</a></div>
					</div>
				</div>
			</div>
		</section>
	</body>
</html>
