<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<head>
	<link rel="stylesheet" href="/css/k_style.css">
	<link rel="stylesheet" href="https://use.typekit.net/mss6mty.css">
	<script src="https://kit.fontawesome.com/ab847241fd.js" crossorigin="anonymous"></script>
	<script
	src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xx0e16f9f2f8cc49c8af5c5ad4cc51a5c2"></script>
	<script type = "text/javascript">
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
		console.log(detail_arr);
	}
</script>
<script src="/js/tmap_update_k.js"></script>
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
						<a href="/">
							코스
						</a>
						<a href="/">
							<i class="fa-solid fa-angle-right"></i>
							코스 상세보기
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
			<form method = "post" id = "courseForm"">
				<div class="k_make_path_edit">
					<div class="k_make_path_map" id = "map_div"></div>
					<ul class="k_path_infos">
						<li class="k_green"><span>코스 이름</span></li>
						<li id="k_coursename">
						<span id="">
						<input type="text" name="course_name" id="coursename" value="${vo.course_name}">
						<%-- <input type="button" id = "courseNameCheck" value = "중복 검사" onclick = "nameCheck()">--%>
						</span></li>
						<li class="k_green"><span>코스 정보</span></li>
						<li id="k_course_info"><span id="course_info">${vo.course_info}</span></li>
						<li class="k_green"><span>소요 시간</span></li>
						<li id="k_time"><span id="result_time">${vo.time}분</span></li>
						<li class="k_green"><span>이동거리</span></li>
						<li id="k_distance"><span id="result_distance">${vo.distance}km</span></li>

						<li class="k_green"><span>시작 위치</span></li>
						<li id="k_startaddr"><span><input type = "text" id = "searchStart" onKeypress="javascript:if(event.keyCode==13){searchPlace(this.value, 0)}"></span></li>
						<li class="k_green"><span>도착 위치</span></li>
						<li id="k_endaddr"><span><input type = "text" id = "searchEnd" onKeypress="javascript:if(event.keyCode==13){searchPlace(this.value, 1)}"></span></li>
						<li class="k_green"><span>경유지</span><input type = "button" id="addr_btn" value = "추가" onclick = "add_textbox()"></li>
						<li id="waypoint">
						</li>
						<%-- <li class="k_green">이번 달 방문 횟수</li>
						<li id="k_plog_total"><span>${vo.plog_total}</span></li> --%>
					</ul>
					<ul id="searchResult" name="searchResult">
						<div class="k_green">검색결과</div>
					</ul>
				</div>
			</form>

			
			<div class="k_mydetail_set">
			<c:if test="${logStatus !='Admin'}">
				<div><a href="/mypage/myCourseView?no=${vo.course_no}">돌아가기</a></div>
				<c:if test="${logId!=null}">
					<div class="saveEditedCourse">저장하기</div>
				</c:if>
			</c:if>
			<c:if test="${logStatus =='Admin'}">
				<div><a href="/mypage/myCourseView?no=${vo.course_no}">돌아가기</a></div>
				<c:if test="${logId!=null}">
					<div class="saveEditedCourse">저장하기</div>
				</c:if>
			</c:if>
		</div>
		</div>
	</section>
</body>