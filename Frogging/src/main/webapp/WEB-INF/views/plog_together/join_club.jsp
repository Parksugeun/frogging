<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="/js/k_script.js" type="text/javascript"></script>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="/css/k_style.css">
	<link rel="stylesheet" href="https://use.typekit.net/mss6mty.css">
	<script src="https://kit.fontawesome.com/ab847241fd.js" crossorigin="anonymous"></script>
	<script src="/js/k_script.js" type="text/javascript"></script>
	<script src="/js/k_club.js" type="text/javascript"></script>
	<script
	src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xx0e16f9f2f8cc49c8af5c5ad4cc51a5c2"></script>
	<script src="/js/tmap_list.js"></script>
</head>
<body onload='modal_club();' class="k_body">
	<!-- --------- FIND PARTY --------- -->
	<section class="find_party">
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
				</div>
			</div>

			<div class="k_section_title">
				<%-- 위치 조건 검색 --%>
					<!-- script 처리 -->
				<div class="k_green" >
					지금 당신 위치 : 
				</div>
				<div>주변 모임을 찾아드릴께요 <i class="fa-solid fa-magnifying-glass k_green"></i></div>
				<button class="k_my_party click-btn-l">
					<a href="/club/my_club_list">나의 모임 관리</a>
				</button>
			</div>
		</div>
		
		<div class="k_party_list">
			<div class="k_wrapper">
				<!-- 날짜 조건 검색 -->
				<div class="k_party_list_date">
					<form method="get" id="clubSearchForm"  action="/club/join_club">
						<%-- <i class="fa-solid fa-chevron-left"></i> --%>
						<div class="k_select_wrap">
							<span><i class="fa-solid fa-caret-right"></i>모임 장소: </span>
							<select name="addr_section_1" id="addr_section_1" onchange="changeAddr()" >
								<c:forEach var="vo" items="${addr_1}">
									<option value="${vo.addr_section_1}">${vo.addr_section_1}</option>
								</c:forEach>					
							</select>
							<select name="addr_section_2" id="addr_section_2" onchange="changeAddr_2()" >
								<option value="">세부 선택</option>
								<c:forEach var="vo" items="${addr_2}">
									<option value="${vo.addr_section_2}">${vo.addr_section_2}</option>
								</c:forEach>			
							</select>
						</div>
						<div>
							<span><i class="fa-solid fa-caret-right"></i>모임 날짜: </span>
							<input type='date' name="searchDate" id="searchDate"/>
							<input type='button' class="k_club_search" value='검색'>
						</div>
					</form>
				</div>

				<!-- 데이터 뿌릴 영역 -->
				<ul class="k_party_list_boxes">
					<%-- 파티 리스트 반복 --%>
					<c:forEach var="vo" items="${list}">
						<li class="k_one_box open_modal" onclick="modal_data(${vo.no});">
							<ul>
								<li class="k_box_title">${vo.course_name}</li>
								<li>${vo.meeting_time} /총 ${vo.number}명</li> 

								<%-- 개구리 아이콘 출력 반복 --%>
								<li class="k_box_frogs">
									<c:forEach var="i" begin="1" end="${vo.number}">
										<%-- 참여자 있음 --%>
										<c:if test="${i <= vo.current_number}">
											<i class="fa-solid fa-frog active"></i>
										</c:if>
										<%-- 참여자 없음 --%>
										<c:if test="${i > vo.current_number}">
											<i class="fa-solid fa-frog"></i>
										</c:if>

									</c:forEach>
								</li> 
								<li>위치: ${vo.addr}</li>
								<li>클럽명: ${vo.partyname}</li>
							</ul>
						</li>
					</c:forEach>

				</ul>
				<%-- <div class="k_party_list_more"><i class="fa-solid fa-caret-down"></i></div> --%>

				<%-- 페이징 --%>
				<ul class="k_club_paging">
				<!-- 페이지 번호 -->
					<c:if test="${pVO.nowPage<=1 }"><!-- 이전페이지가 없을때 -->
						<li><i class="fa-solid fa-caret-left"></i></li>
					</c:if>
					<c:if test="${pVO.nowPage>1 }"><!-- 이전페이지가 있을때 -->
						<li><a href="/club/join_club?nowPage=${pVO.nowPage-1 }<c:if test='${pVO.addr_section_2!=null}'>&addr_section_1=${pVO.addr_section_1}&addr_section_2=${pVO.addr_section_2}</c:if>"><i class="fa-solid fa-caret-left"></i></a></li>
					</c:if>
					<c:forEach var="p" begin="${pVO.startPage }" end="${pVO.startPage+pVO.onePageCount-1 }">
						<!--  출력할 페이지번호 총페이지수 보다 작거나 같을 떄 -->
						<c:if test="${p<=pVO.totalPage }">
							<li
							<c:if test="${p==pVO.nowPage }">
							style="font-weight:bold"
							</c:if>
							><a href="/club/join_club?nowPage=${p}<c:if test='${pVO.addr_section_2!=null}'>&addr_section_1=${pVO.addr_section_1}&addr_section_2=${pVO.addr_section_2}</c:if>">${p}</a></li>
						</c:if>
					</c:forEach>
					
					<!-- 다음페이지 -->
					<c:if test="${pVO.nowPage==pVO.totalPage }">
						<li><i class="fa-solid fa-caret-right"></i></li>
					</c:if>
					<c:if test="${pVO.nowPage<pVO.totalPage }">
						<li><a href="/club/join_club?nowPage=${pVO.nowPage+1 }<c:if test='${pVO.addr_section_2!=null}'>&addr_section_1=${pVO.addr_section_1}&addr_section_2=${pVO.addr_section_2}</c:if>"><i class="fa-solid fa-caret-right"></i></a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</section>

	<!-- --------- PARTY Details--------- -->
	<section class="k_selected_party_detail modal">
		<div class="k_wrapper modal_body">
			<div class="k_party_detail_box">
				<div class="k_party_detail_box_left">
					<span id="k_course_name">서울숲 외곽 코스</span>
					<div class="k_party_detail_img"></div>
					<div class="k_party_detail_who">
						<div>파티장 정보</div>
						<ul>
							<li id="k_nickname">닉네임: <span></span></li>
							<li id="k_total_km">이번 달 걸은 거리: <span></span></li>
							<li id="k_plog_count">이번 달 플로깅 횟수: <span></span></li>
						</ul>
						<div>참여 파티원</div>
						<ul id="k_current_number">
						</ul>
					</div>
				
				</div>
				<ul class="k_party_detail_box_right">
					<li><span>파티명</span></li>
					<li id="k_partyname"><span></span></li>
					<li><span>코스 위치</span></li>
					<li id="k_addr"><span></span></li>
					<li><span>소요시간/거리</span></li>
					<li id="k_d_and_t"><span></span></li>
					<li><span>모집 인원</span></li>
					<li id="k_number"><span></span></li>
					<li><span>모집 일시</span></li>
					<li id="k_meeting_time"><span></span></li>
					<li><span>만남 장소</span></li>
					<li id="k_meeting_place"><span></span></li>
					<li><span>기타 안내</span></li>
					<li id="k_content"><span></span></li>
				</ul>

			</div> 
			<div class="k_party_detail_join">
				<div class="k_close_popup click-btn">돌아가기</div>
				<div class="click-btn"><a href="javascript:ask_join_in();">모임 참여 신청하기</a></div>
			</div>
		</div>
	</section>


	<!-- --------- START NEW PARTY --------- -->
	<section class="k_start_new_party">
		<div class="k_wrapper">
			<div class="k_section_title">
				<div>원하는 모임이 없다면,</div>
				<div class="k_green">나의 파티 만들기 <i class="fa-solid fa-circle-plus"></i></div>
			</div>
			<ul>
				<li class="click-btn"><a href="/club/make_club_rec_path">추천 코스 선택하기</a></li>
				<li class="click-btn"><a href="/club/make_club_new_path">나만의 코스 만들기</a></li>
			</ul>
		</div>
	</section>
	</body>
</html>
