<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="/css/k_style.css">
	<link rel="stylesheet" href="https://use.typekit.net/mss6mty.css">
	<script src="https://kit.fontawesome.com/ab847241fd.js" crossorigin="anonymous"></script>
	<script
	src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xx0e16f9f2f8cc49c8af5c5ad4cc51a5c2"></script>
	<script>
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

		<!-- --------- NEW PARTY with rec paths --------- -->
		<section class="k_new_party_rec_path">
			<div class="k_wrapper">
				<div class="k_section_title_links">
					<div>
						<i class="fa-solid fa-square-caret-right k_green"></i>
						<a href="/">
							플로깅하기 
						</a>
						<a href="/club/join_club">
							<i class="fa-solid fa-angle-right"></i>
							함께하기
							<i class="fa-solid fa-angle-right"></i>
							모임 찾기
						</a>
						<i class="fa-solid fa-angle-right"></i>
						모임 만들기
						<i class="fa-solid fa-angle-right"></i>
						추천 경로 찾기
					</div>
				</div>

				<div class="k_section_title">
					<div>원하는 모임이 없다면,</div>
					<div class="k_green">나의 모임 만들기 <i class="fa-solid fa-circle-plus"></i></div>
					<button class="k_my_party click-btn-l">
						<a href="/club/my_club_list">나의 모임 관리</a>
					</button>
				</div> 
			</div>
			<!-- ----------- recommendation path ------------->
			<div class="k_path_list">
				<div class="k_wrapper">
					<ul class="k_rec_path_button">
						<li class="active click-btn"><a href="/club/make_club_rec_path">추천 코스 선택하기</a></li>
						<li class="click-btn-w"><a href="/club/make_club_new_path">나만의 코스 만들기</a></li>
					</ul>

					<div class="k_path_list_bg">
						<!-- recommendation path select -->
						<form action="">
						
						</form>
						<form method="get" id="pathSearchFrm" onclick="searchPath();">
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
								<input type="submit" value="검색" class="k_rec_path_search_btn click-btn-l"></input>
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
										<li>예상 소요시간: ${vo.time}</li>
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
								<li><a href="/club/make_club_rec_path?nowPage=${p_PageVO.nowPage-1 }<c:if test="${pVO.addr_section_2!=null }">&addr_section_1=${p_PageVO.addr_section_1 }&addr_section_2=${p_PageVO.addr_section_2 }</c:if>"><i class="fa-solid fa-chevron-left active"></i></a></li>
							</c:if>
								
							<c:forEach var="p" begin="${p_PageVO.startPage }" end="${p_PageVO.startPage + p_PageVO.onePageCount - 1 }" >
								<c:if test="${p<=p_PageVO.totalPage }" >
									<li
									<c:if test="${p==p_PageVO.nowPage }">
										style = "color:#2fb86a;"
									</c:if>
									><a href="/club/make_club_rec_path?nowPage=${p }<c:if test="${p_PageVO.addr_section_2!=null }">&addr_section_1=${p_PageVO.addr_section_1 }&addr_section_2=${p_PageVO.addr_section_2 }</c:if>">${p }</a></li>
								</c:if>
							</c:forEach>
								
							<!-- 다음페이지 -->
							<c:if test="${p_PageVO.nowPage>=p_PageVO.totalPage }" > 
								<li><i class="fa-solid fa-chevron-right active"></i></li>
							</c:if>
							<c:if test="${p_PageVO.nowPage<p_PageVO.totalPage}" > 
									<li><a href="/club/make_club_rec_path?nowPage=${p_PageVO.nowPage-1 }<c:if test="${pVO.addr_section_2!=null }">&addr_section_1=${p_PageVO.addr_section_1 }&addr_section_2=${p_PageVO.addr_section_2 }</c:if>"><i class="fa-solid fa-chevron-right active"></i></a></li>
							</c:if>
						</ul>
					</div>
				</div>
			</div>
		</section>


		<!-- --------- PARTY Details--------- -->
		<section class="k_selected_path_detail modal">
			<div class="k_wrapper modal_body">
				<div class="k_path_detail_box">
					<div class="k_path_map"></div>
					<ul class="k_path_infos">
						<li class="k_green">코스 이름</li>
						<li id="k_coursename"><span></span></li>
						<li class="k_green">시작 위치</li>
						<li id="k_startaddr"><span></span></li>
						<li class="k_green">도착 위치</li>
						<li id="k_endaddr"><span></span></li>
						<li class="k_green">소요 시간</li>
						<li id="k_time"><span></span></li>
						<li class="k_green">이동 거리</li>
						<li id="k_distance"><span></span></li>
						<li class="k_green">이번 달 방문 횟수</li>
						<li id="k_plog_total"><span></span></li>
					

					<%-- before/after image 영역 --%>
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
					<div class="k_close_popup click-btn" onclick="select_path()">코스 선택하기</div>
				</div>
			</div>
		</section>



		<!-- k_new_party_setting -->
		<section class="k_new_party_setting">
			<div class="k_wrapper">
				<form action="/club/makeNewClub" method="post" id="k_party_set_frm">
				<input type="hidden" name="course_no"  id="k_party_set_course_no"/>
				<div class="k_section_title">
					<div>플로깅 할 사람 여기여기 모여라</div>
					<div class="k_green">모임 세팅 <i class="fa-solid fa-gear"></i></div>
				</div>

				<div class="k_party_set">
						<ul class="k_party_set_left">
							<li>모임 가이드</li>
							<li class="k_party_set_guide">
								<div>
<p>⚫️ 클럽 모임장 준수사항</p><br>

<p>프로깅의 핵심 가치</p><br>
- <b>책임있는 자율성</b>을 지향합니다. 구성원들이 자발적으로 참여하고 만들어나가는 커뮤니티입니다. 환경이나 운동에 대해 관심을 가신 사람들이 모여서 선한 가치를 만들어 나갑니다.<br><br>
- <b>타인에 대한 예의</b>가 중요합니다. 새로운 만남에 대한 호기심을 가진 사람들의 모임입니다. 처음 보는 사람들이 대부분이므로 실례가 될 수 있는 질문은 하지 않습니다. 클럽 모임장은 프로깅 도중 무례가 될 수 있는 언행이 발생하지 않도록 주의를 기울여주세요.<br><br>
- <b>시간 준수</b>는 서로에 대한 약속입니다. 만나기로 한 장소, 만나기로 한 시간에 꼭 나오기로 합니다. 클럽 모임장은 참가원들이 시간을 준수할 수 있도록 격려하고 이를 어길 시 지체하지 않고 프로깅을 진행하도록 합니다.<br><br>
								</div>
							</li>
							<li><input type="checkbox" id="k_party_set_agree">위 모임 가이드를 확인하였습니다.</li>
						</ul>
						<div class="k_party_set_line"></div>
						<ul class="k_party_set_right">
							<li><label class="k_green" for="">모임명</label></li>
							<li class="k_party_set_in"><input type="text" name="partyname" id="k_party_set_party_name" placeholder="파티명을 입력하세요"><input type="button" value="중복검사" onclick="checkPartyname()"></li>
							<li><label class="k_green" for="">코스명</label></li>
							<li class="k_party_set_in"><input type="text" name="course_name" id="k_party_set_course_name" value="" readonly></li>
							<li><label class="k_green" for="">모집인원</label></li>
							<li class="k_party_set_in"><input type="number" name="number" id="k_party_set_party_number" min="2" max="12" placeholder="인원 수"></li>
							<li><label class="k_green" for="">모집일시</label></li>
							<li class="k_party_set_in">
								<input type="datetime-local" name="meeting_time" id="k_party_set_meeting_time" value="">
							</li>
							<li><label class="k_green" for="">만남장소</label></li>
							<li class="k_party_set_in"><input type="text" name="meeting_place" id="k_party_set_meeting_place" placeholder="만남장소를 입력하세요"></li>
						</ul>
						<div class="k_party_set_buttom">
							<label class="k_green" for="">세부 알림 사항</label>
							<textarea name="content" id="k_content" ></textarea>
						</div>
				</div>
				<div class="k_party_set_button">
					<div class="click-btn k_party_frm_submit">모임 등록</div>
				</div>
			</form>
			</div>
	</section>
</body>
</html>