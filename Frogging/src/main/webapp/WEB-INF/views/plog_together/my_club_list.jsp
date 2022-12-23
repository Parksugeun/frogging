<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="/css/k_style.css">
	<link rel="stylesheet" href="https://use.typekit.net/mss6mty.css">
	<script src="https://kit.fontawesome.com/ab847241fd.js" crossorigin="anonymous"></script>
	<script src="/js/k_script.js" type="text/javascript"></script>
	<script src="/js/k_club_manage.js" type="text/javascript"></script>

</head>
<body onload="modal_more()" class="k_body">

		<!-- --------- party_list --------- -->
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
							클럽 찾기
						</a>
						<i class="fa-solid fa-angle-right"></i>
						나의 클럽 관리
					</div>
				</div>

				<div class="k_section_title">
					<div>플로깅 약속 잊지말기!</div>
					<div class="k_green">나의 클럽 관리하기&nbsp<i class="fa-solid fa-list-check"></i></div>
				</div>
			</div>

			<!-- ----------- party_list(참여한 파티) ------------->
			<div class="k_my_party_join">
				<div class="k_wrapper">
					<div class="k_my_party_list_title">참여 중인 클럽</div>
					<div class="k_bg_white_wrapper">
						<ul class="k_my_party_grid">
							<li class="k_my_list_head"><span>번호</span></li>
							<li class="k_my_list_head"><span>파티명</span></li>
							<li class="k_my_list_head"><span>코스명</span></li>
							<li class="k_my_list_head"><span>일시</span></li>
							<li class="k_my_list_head"><span>상태</span></li>


							<c:forEach var="vo" items="${join_list}">
								<li><span>${vo.no}</span></li>
								<li><a href="/club/club_view?no=${vo.no}&l_id=${vo.id}"><span>${vo.partyname}</span></a></li>
								<li><a href=""><span>${vo.course_name}</span></a></li>
								<li><span>${vo.meeting_time}</span></li>
								<li><span>
									<c:if test="${vo.join_status==0}">
										수락대기
									</c:if>
									<c:if test="${vo.join_status==1}">
										수락완료
									</c:if>
									<c:if test="${vo.join_status==2}">
										수락거절 
										<c:if test="${vo.reason==1}">
											(부적절한 언행)
										</c:if>
										<c:if test="${vo.reason==2}">
											(신청 마감)
										</c:if>
										<c:if test="${vo.reason==3}">
											(기타사유)
										</c:if>
									</c:if>
									<c:if test="${vo.join_status==3}">
										퇴출
										<c:if test="${vo.reason==1}">
											(부적절한 언행)
										</c:if>
										<c:if test="${vo.reason==2}">
											(신청 마감)
										</c:if>
										<c:if test="${vo.reason==3}">
											(기타사유)
										</c:if>
									</c:if>
									</span>
								</li>
							</c:forEach>
							
							<%-- <li>12</li>
							<li><a href="">서울숲 한바퀴</a></li>
							<li><a href="">응봉산~서울숲 코스</a></li>
							<li>10/11 18:00</li>
							<li>수락 대기</li> --%>
						</ul>

						<%-- <ul class="k_rec_path_page">
							<li><i class="fa-solid fa-chevron-left active"></i></li>
							<li class="active">1</li>
							<li>2</li>
							<li>3</li>
							<li>4</li>
							<li>5</li>
							<li><i class="fa-solid fa-chevron-right active"></i></li>
						</ul> --%>
					</div>
				</div>
			</div>
		</section>

		<!-- ----------- party_list(운영하는 파티) ------------->
		<section class="k_my_party_manage">
			<div class="k_wrapper">
				<div class="k_my_party_list_title">내가 운영하는 클럽</div>
				<div class="k_bg_white_wrapper">
					<ul class="k_my_party_grid">
							<li class="k_my_list_head"><span>번호</span></li>
							<li class="k_my_list_head"><span>파티명</span></li>
							<li class="k_my_list_head"><span>코스명</span></li>
							<li class="k_my_list_head"><span>일시</span></li>
							<li class="k_my_list_head"><span>관리</span></li>

							<c:forEach var="vo" items="${manage_list}">
								<li><span>${vo.no}</span></li>
								<li><a href="/club/club_view?no=${vo.no}&l_id=${vo.id}"><span>${vo.partyname}</span></a></li>
								<li><a href=""><span>${vo.course_name}</span></a></li>
								<li><span>${vo.meeting_time}</span></li>
								<li class="open_modal" onclick="modal_data(${vo.no});">
									<span>${vo.current_number}/${vo.number}</span>
									<i class="fa-solid fa-gear k_green click-btn-c"></i>
								</li>
							</c:forEach>

					</ul>

					<%-- <ul class="k_rec_path_page">
							<li><i class="fa-solid fa-chevron-left active"></i></li>
							<li class="active">1</li>
							<li>2</li>
							<li>3</li>
							<li>4</li>
							<li>5</li>
							<li><i class="fa-solid fa-chevron-right active"></i></li>
					</ul> --%>
				</div>
			</div>
		</section>

		<%-- my party-manage-detail --%>
		<section class="k_selected_m_party_detail modal">
			<div class="k_wrapper modal_body">
				<div class="k_m_party_detail_box">
					<div class="k_my_party_list_title modal_title">[파티명] 참여 인원</div>
					<ul class="k_party_manage_infos">
						<li class="k_my_list_head"><span>파티번호</span></li>
						<li class="k_my_list_head"><span>아이디</span></li>
						<li class="k_my_list_head"><span>닉네임</span></li>
						<li class="k_my_list_head"><span>상태</span></li>
						<li class="k_my_list_head"><span>확인</span></li>

						<li id="k_no"><span></span></li>
						<li id="k_id"><span></span></li>
						<li id="k_nickname"><span></span></li>
						<li id="k_join_status"><span></span></li>
						<li id="k_btn"><span></span></li>

						<li>11</li>
						<li>중랑천 빠르게 걷기</li>
						<li>샘플닉네임12</li>
						<li>수락 완료</li>
						<li><button>퇴장</button></li>

						<li>11</li>
						<li>중랑천 빠르게 걷기</li>
						<li>샘플닉네임13</li>
						<li>수락 대기</li>
						<li><button>수락</button><button>거절</button></li>

					</ul>

					<%-- <ul class="k_rec_path_page">
							<li><i class="fa-solid fa-chevron-left active"></i></li>
							<li class="active">1</li>
							<li>2</li>
							<li>3</li>
							<li>4</li>
							<li>5</li>
							<li><i class="fa-solid fa-chevron-right active"></i></li>
						</ul> --%>
				</div>

				<div class="k_party_detail_join">
					<div class="k_close_popup click-btn">돌아가기</div>
				</div>
			</div>
		</section>

</body>
</html>