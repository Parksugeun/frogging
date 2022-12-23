<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<head>
	<link rel="stylesheet" href="/css/k_style.css">
	<link rel="stylesheet" href="https://use.typekit.net/mss6mty.css">
	<script src="https://kit.fontawesome.com/ab847241fd.js" crossorigin="anonymous"></script>
	<script src="/js/k_script.js" type="text/javascript"></script>
	<script src="/js/k_mypage.js" type="text/javascript"></script>
</head>
<body class="k_body">
<%-- 나의 프로필 --%>
	<section class="k_mypage_top">
		<div class="k_wrapper">

			<div class="k_section_title_links">
				<div>
					<i class="fa-solid fa-square-caret-right k_green"></i>
					<a href="/mypage/my">
						마이페이지
					</a>
				</div>
			</div>
		</div>
	</section>
	
	<section class="k_profile">
		<div class="k_wrapper">

			<div class="k_profile_main">

				<div class="k_pro_left">
					<div class="k_pro_img"><img src="/img/plogging_logo.jpeg" alt=""></div>
					
					<ul>
						<li class="k_nick">${logNickName}</li>
						<li>거리 랭킹: ${plog_count}위</li>
						<li>횟수 랭킹: ${distance}위</li>
					</ul>
				</div>

				<div class="k_pro_line">
				</div>

				<div class="k_pro_right">
					<ul>
						<li class="click-btn"><a href="/mypage/myDetail">나의 상세정보</a></li>
						<li class="click-btn"><a href="/mypage/activity">나의 플로깅 활동</a></li>
						<li class="click-btn"><a href="/club/my_club_list">나의 클럽 관리</a></li>
						<li class="click-btn"><a href="/mypage/myCourse">나의 코스 관리</a></li>
					</ul>
				</div>

			</div>
			
		</div>
	</section>

<%-- 내가 쓴  글 --%>
	<section class="k_mywrite">
		<div class="k_section_title">
				<div>내가 쓴 글 보기</div>
			</div>

		<div class="k_wrapper">
			
			<%-- 내가 쓴 글 탭메뉴 --%>
			<div class="my_write_tab">
				<div><button class="active click-btn k_write_tab_c">커뮤니티</button></div>
				<div><button class="click-btn k_write_tab_q">QnA</button></div>
				<div><button class="click-btn k_write_tab_s">고객센터</button></div>
			</div>

			<ul class="k_my_write_grid">
				<li class="k_my_list_head"><span>번호</span></li>
				<li class="k_my_list_head"><span>제목</span></li>
				<li class="k_my_list_head"><span>작성일</span></li>
				<li class="k_my_list_head"><span>조회수</span></li>

				<%-- 커뮤니티 --%>
				<c:forEach var="vo" items="${c_list}">
					<li class="k_my_write_c"><span>${vo.no}</span></li>
					<li class="k_my_write_c"><span><a href="/community/communityView?no=${vo.no}">${vo.subject}</a></span></li>
					<li class="k_my_write_c"><span>${vo.writedate}</span></li>
					<li class="k_my_write_c"><span>${vo.hit}</span></li>
				</c:forEach>


				<%-- 큐앤애이 --%>
				<c:forEach var="vo" items="${q_list}">
					<li class="k_my_write_q"><span>${vo.no}</span></li>
					<li class="k_my_write_q"><span><a href="/qna/qnaDetail?no=${vo.no}">${vo.subject}</a></span></li>
					<li class="k_my_write_q"><span>${vo.writedate}</span></li>
					<li class="k_my_write_q"><span>${vo.hit}</span></li>
				</c:forEach>

				<%-- 고객센터 --%>
				<c:forEach var="vo" items="${s_list}">
					<li class="k_my_write_s"><span>${vo.no}</span></li>
					<li class="k_my_write_s"><span><a href="/customerService/customerServiceDetail?no=${vo.no}">${vo.subject}</a></span></li>
					<li class="k_my_write_s"><span>${vo.writedate}</span></li>
					<li class="k_my_write_s"><span>${vo.hit}</span></li>
				</c:forEach>
			</ul>
		</div>
	</section>


<%-- 나의 달성 기록 --%>
	<section class="k_achieve">
		<div class="k_section_title">
					<div>나의 달성 기록</div>
			</div>
		<div class="k_wrapper">

			<div class="k_achieve_badge">
				<i class="fa-solid fa-caret-left"></i>
				<ul>
					
					<%-- km badge --%>
					<c:forEach var="i" begin="5" end="50" step="5">
						<c:if test="${a_vo.total_distance>i}">
							<li><img src="/img/badge/${i}K.png" alt=""></li>
						</c:if>
					</c:forEach>

					<%-- liter badge --%>
					<c:forEach var="i" begin="10" end="50" step="10">
						<c:if test="${a_vo.trash_sum>i}">
							<li><img src="/img/badge/${i}L.png" alt=""></li>
						</c:if>
					</c:forEach>

				</ul>
				<i class="fa-solid fa-caret-right"></i>		
				</div>	
		</div>

	</section>

</body>
