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
	
	map_arr.push({
			// course_no : "${vo.course_no}",
			course_no : 99999,
			course_name : "${vo.course_name}",
			course_info : "${vo.course_info}",
			distance : "${vo.distance}",
			time : "${vo.time}",
			type : "${vo.type}"
	});

	<c:forEach items = "${courseDetail}" var = "courseDetail">
		detail_arr.push({
			// course_no : "${courseDetail.course_no}",
			course_no : 99999,
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
<script src="/js/k_admin.js"></script>
</head>
<body class="k_body" onload="initTmap()">
	<section>
		<div class="k_wrapper">
			<div class="k_section_title_links">
				<div>
					<c:if test="${logStatus =='Admin'}">
						<i class="fa-solid fa-square-caret-right k_green"></i>
						<a href="/">
							관리자
						</a>
						<a href="/admin/manageCourse">
							<i class="fa-solid fa-angle-right"></i>
								코스 관리하기
						</a>
						<a href="/mypage/myCourseView?no=${vo.course_no}">
							<i class="fa-solid fa-angle-right"></i>
							코스 보기
						</a>
					</c:if>

					<c:if test="${logStatus !='Admin'}">
						<i class="fa-solid fa-square-caret-right k_green"></i>
						<a href="/mypage/myCourse">
							코스
						</a>
						<a href="/mypage/myCourseView?no=${vo.course_no}">
							<i class="fa-solid fa-angle-right"></i>
							코스 보기
						</a>
					</c:if>
				</div>
			</div>
			

			<c:if test="${logStatus !='Admin'}">
			<div class="k_section_title">
				<div class="k_green" >
					프로거 ${logNickName }가
				</div>
				<div>작성한 코스</div>
			</div>
			</c:if>

		</div>
	</section>

	<section class="k_mycourse">
		<div class="k_wrapper">
			<form action="">
				<div class="k_make_path">
					<div class="k_make_path_map" id = "map_div_99999"></div>
					<ul class="k_path_infos">
						<li class="k_green">코스 이름</li>
						<li id="k_coursename"><span>${vo.course_name}</span></li>
						<li class="k_green">시작 위치</li>
						<li id="k_startaddr"><span>${vo.startaddr}</span></li>
						<li class="k_green">도착 위치</li>
						<li id="k_endaddr"><span>${vo.endaddr}</span></li>
						<li class="k_green">소요 시간</li>
						<li id="k_time"><span>${vo.time}분</span></li>
						<li class="k_green">이동 거리</li>
						<li id="k_distance"><span>${vo.distance}km</span></li>
						<li class="k_green">이번 달 방문 횟수</li>
						<li id="k_plog_total"><span>${vo.plog_total}회</span></li>
						<li class="k_green"><span>코스 정보</span></li>
						<li id="k_course_info"><span>${vo.course_info}</span></li>
					</ul>
				</div>
			</form>

			
			<div class="k_mydetail_set">
			<c:if test="${logStatus !='Admin'}">
				<div><a href="/mypage/myCourse">돌아가기</a></div>
				<c:if test="${logId!=null}">
					<div>
					<a href="/mypage/myCourseEdit<c:if test = '${vo.type == 2 }'>_user</c:if>?no=${vo.course_no}">수정하기</a>
					</div>
					<div><a href="javascript:deleteCourse(${vo.course_no});">삭제하기</a></div>
				</c:if>
			</c:if>
			<c:if test="${logStatus =='Admin'}">
				<div><a href="/admin/manageCourse">돌아가기</a></div>
				<c:if test="${logId!=null}">
					<div><a href="/mypage/myCourseEdit<c:if test = '${vo.type == 2 }'>_user</c:if>?no=${vo.course_no}">수정하기</a></div>
					<div><a href="javascript:deleteCourse(${vo.course_no});">삭제하기</a></div>
				</c:if>
			</c:if>
		</div>
		</div>
	</section>
</body>