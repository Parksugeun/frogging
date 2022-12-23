<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<head>
	<link rel="stylesheet" href="/css/k_style.css">
	<link rel="stylesheet" href="https://use.typekit.net/mss6mty.css">
	<script src="https://kit.fontawesome.com/ab847241fd.js" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
	<script src="/js/k_chart.js" ></script>
	<script
	src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xx0e16f9f2f8cc49c8af5c5ad4cc51a5c2"></script>
	
	<script>
	var map_arr = new Array();
	var detail_arr = new Array();
	function initTmap() {
		// 1. 지도 띄우기
		<c:forEach items = "${activityList}" var = "activityList">
			map_arr.push({
				course_no : "${activityList.course_no}",
				course_name : "${activityList.course_name}",
				distance : "${activityList.distance}",
				time : "${activityList.time}",
				step : "${activityList.step}",
				amount_trash : "${activityList.amount_trash}",
				activity_no : "${activityList.no}",
				date : "${activityList.date}",
				sort : "${activityList.sort}",
				type : 2
			});
		</c:forEach>
		
		<c:forEach items = "${courseUser}" var = "courseUser">
			detail_arr.push({
				course_no : "${courseUser.course_no}",
				waypoint : "${courseUser.waypoint}",
				lat : "${courseUser.lat}",
				log : "${courseUser.log}",
				activity_no : "${courseUser.activity_no}"
			});
		</c:forEach>
		
		console.log(map_arr);
		console.log(detail_arr);
		mapLoad(map_arr, detail_arr);
	}
	</script>
	<script src="/js/tmap_activity.js"></script>
	<style>
		@media screen and (min-width:152px) and (max-width:1024px){
	.k_activity_sum{display:none;}
	.k_activity_list>.k_wrapper>ul>li{
	width: 96%;
	margin: var(--space-medium) 2%;
}
		}
	</style>
</head>
<body class="k_body" onload="draw_myplog(); initTmap(); modal_more();">
	<section>
		<div class="k_wrapper">

			<div class="k_section_title_links">
				<div>
					<i class="fa-solid fa-square-caret-right k_green"></i>
					<a href="/mypage/my">
						마이페이지
					</a>
					<a href="/mypage/activity">
						<i class="fa-solid fa-angle-right"></i>
						나의 플로깅 활동
					</a>
				</div>
			</div>

			<div class="k_section_title">
				<div class="k_green" >
					오늘도 열심히 걸은 ${logNickName }님! 
				</div>
				<div>나의 활동 보기 <i class="fa-solid fa-magnifying-glass k_green"></i></div>
			</div>

		</div>
	</section>

	<section class="k_activity_sum">
		<div class="k_wrapper">

			<div class="k_a_title">나의 활동 요약</div>

			<form action="">
				<ul class="k_a_select">
					<li class="k_a_select_w active">주</li>
					<li class="k_a_select_m">월</li>
					<li class="k_a_select_y ">년</li>
					<li class="k_a_select_t">전체</li>
				</ul>
			</form>

			<div class="k_a_chart">
				<ul>
					<li>TOTAL</li>

					<li class="k_weekly"><span>${a_vo_w.week}</span>번째 주</li>
					<li class="k_weekly"><span>${a_vo_w.total_distance}</span> km</li>
					<li class="k_weekly"><span>${a_vo_w.total_step}</span> steps</li>
					<li class="k_weekly"><span>${a_vo_w.plog_count}</span> th plogging</li>
					<li class="k_weekly"><span>${a_vo_w.trash_sum}</span> L of trash</li>

					<li class="k_monthly"><span>${a_vo_m.month}</span>월</li>
					<li class="k_monthly"><span>${a_vo_m.total_distance}</span> km</li>
					<li class="k_monthly"><span>${a_vo_m.total_step}</span> steps</li>
					<li class="k_monthly"><span>${a_vo_m.plog_count}</span> th plogging</li>
					<li class="k_monthly"><span>${a_vo_m.trash_sum}</span> L of trash</li>

					<li class="k_yearly"><span>${a_vo_y.year}</span>년</li>
					<li class="k_yearly"><span>${a_vo_y.total_distance}</span> km</li>
					<li class="k_yearly"><span>${a_vo_y.total_step}</span> steps</li>
					<li class="k_yearly"><span>${a_vo_y.plog_count}</span> th plogging</li>
					<li class="k_yearly"><span>${a_vo_y.trash_sum}</span> L of trash</li>

					<li class="k_totally"><span>전체</span></li>
					<li class="k_totally"><span>${a_vo_t.total_distance}</span> km</li>
					<li class="k_totally"><span>${a_vo_t.total_step}</span> steps</li>
					<li class="k_totally"><span>${a_vo_t.plog_count}</span> th plogging</li>
					<li class="k_totally"><span>${a_vo_t.trash_sum}</span> L of trash</li>
				</ul>

				<div class="k_a_chart_wrap">
					<div class="k_a_chart_graph" id="k_weekly_chart"><canvas id="myChart_w"></canvas></div>
					<div class="k_a_chart_graph" id="k_monthly_chart"><canvas id="myChart_m"></canvas></div>
					<div class="k_a_chart_graph" id="k_yearly_chart"><canvas id="myChart_y"></canvas></div>
					<div class="k_a_chart_graph" id="k_totally_chart"><canvas id="myChart_t"></canvas></div>
				</div>
			</div>

		</div>
	</section>

	<section class="k_activity_list">
		<div class="k_wrapper">
			<div class="k_a_title">최근 활동</div>
			<ul >
				<c:forEach var="vo" items="${activityList}">
					<li class = "open_modal" onclick="modal_data(${vo.no})">
						<ul class="k_a_each_box">
							<li><div id="map_div_${vo.no }"></div></li>
							<li class="k_a_main_info">${vo.date}</li>
							<li class="k_a_main_info">${vo.course_name}</li>
							<li class="k_a_div"></li>
							<li>거리: ${vo.distance}km, 걸음 수 : ${vo.step}보</li>
							<li>주운 쓰레기: ${vo.amount_trash}L</li>
							<li>
								<c:if test="${vo.sort == 0 }">
									혼자한 플로깅
								</c:if>
								<c:if test="${vo.sort > 0}">
									같이한 플로깅
								</c:if>
							</li>
						</ul>
					</li>
				</c:forEach>
			</ul>
			

			<div>
			<ul class="k_rec_path_page">
			
				<c:if test="${apvo.nowPage<=1 }">
					<li><i class="fa-solid fa-chevron-left active"></i></li>
				</c:if>
				<c:if test = "${apvo.nowPage > 1 }"><!-- 이전 page가 있을 때 -->
					<li><a href = "/mypage/activity?nowPage=${apvo.nowPage-1 }<c:if test='${apvo.searchWord!=null }'>&searchKey=${apvo.searchKey }&searchWord=${apvo.searchWord }</c:if>"><i class="fa-solid fa-chevron-left active"></i></a></li>
				</c:if>
				
				<c:forEach var = "p" begin = "${apvo.startPage }" end = "${apvo.startPage + apvo.onePageCount - 1 }">
					<!-- 출력할 page 번호가 총 page보다 작거나 같을 때 -->
					<c:if test = "${p <= apvo.totalPage}">
						
						<li 
						
						<c:if test = "${p == apvo.nowPage }">
							style = "color:#2fb86a;"
						</c:if>
						
						><a href = "/mypage/activity?nowPage=${p }<c:if test='${apvo.searchWord!=null }'>&searchKey=${apvo.searchKey }&searchWord=${apvo.searchWord }</c:if>">${p }</a></li>
						
					</c:if>
				</c:forEach>
				
				<!-- 다음 page -->
				<c:if test="${apvo.nowPage>=apvo.totalPage }" > 
					<li><i class="fa-solid fa-chevron-right active"></i></li>
				</c:if>
				<c:if test = "${apvo.nowPage < apvo.totalPage }">
					<li><a href = "/mypage/activity?nowPage=${apvo.nowPage + 1 }<c:if test='${apvo.searchWord!=null }'>&searchKey=${apvo.searchKey }&searchWord=${apvo.searchWord }</c:if>"><i class="fa-solid fa-chevron-right active"></i></a></li>
				</c:if>
			</ul>
			</div>
			<%-- <div class="k_list_more"><i class="fa-solid fa-caret-down"></i></div> --%>
		</div>
	</section>


	<section class="k_selected_path_detail modal">
		<div class="k_wrapper modal_body">
			<div class="k_path_detail_box">
				<div class="k_path_map"></div>
				<ul class="k_path_infos">
					<li class="k_green">코스 이름</li>
					<li id = "k_coursename"><span>가볍게 응봉산 코스</span></li>
					<li class="k_green">날짜</li>
					<li id = "k_date"><span>50 min</span></li>
					<li class="k_green">소요 시간</li>
					<li id = "k_time"><span>50 min</span></li>
					<li class="k_green">이동 거리</li>
					<li id = "k_distance"><span>4 km</span></li>
					<li class="k_green">걸음 수</li>
					<li id = "k_step"><span>4 km</span></li>
					<li class="k_green">쓰레기양</li>
					<li id = "k_trash"><span>12회</span></li>
				
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
</body>
