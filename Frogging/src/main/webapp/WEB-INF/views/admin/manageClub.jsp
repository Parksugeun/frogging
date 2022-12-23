<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<head>
	<link rel="stylesheet" href="/css/k_style.css">
	<link rel="stylesheet" href="https://use.typekit.net/mss6mty.css">
	<script src="https://kit.fontawesome.com/ab847241fd.js" crossorigin="anonymous"></script>
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=Black+And+White+Picture&family=Black+Han+Sans&family=Cute+Font&family=Do+Hyeon&family=Dokdo&family=East+Sea+Dokdo&family=Gaegu&family=Gamja+Flower&family=Gothic+A1&family=Gugi&family=Hi+Melody&family=Jua&family=Kirang+Haerang&family=Nanum+Brush+Script&family=Nanum+Gothic&family=Nanum+Gothic+Coding&family=Nanum+Myeongjo&family=Nanum+Pen+Script&family=Noto+Sans+KR&family=Noto+Serif+KR&family=Poor+Story&family=Single+Day&family=Song+Myung&family=Stylish&family=Sunflower:wght@300&family=Yeon+Sung&display=swap" rel="stylesheet">	
	<script src="/js/k_admin.js"></script>
</head>
<style>
.delBtn_1{
	height: 40px;
    width: 100px;
    background-color: #2fb86a;
    border : 1px solid white;
    border-radius:5px;
    color: white;
    font-weight: bold;
    font-size: 22px;
    margin: 0 10px;
    font-family: 'Noto Sans KR', sans-serif;
}
</style>
	<ul class="adminMenu">
		<li class="tabMenu"><a href="/admin/userlist">사용자목록</a></li>
		<li class="tabMenu"><a href="/admin/communityList">커뮤니티관리</a></li>
		<li class="tabMenu"><a href="/admin/eventList">이벤트관리</a></li>
		<li class="tabMenu"><a href="/admin/qnaList">QnA관리</a></li>
		<li class="tabMenu"><a href="/admin/customerServiceList">고객센터관리</a></li>
		<li class="tabMenu"><a href="/admin/manageCourse">코스관리</a></li>
		<li class="tabMenu"><a href="/admin/manageClub">클럽관리</a></li>
		<li class="tabMenu"><a href="/admin/statistic">데이터관리</a></li>
	</ul>
<body class="k_body" style="font-family: 'Noto Sans KR', sans-serif; ">
	<div style="height:110%;">
	<section>
		<div class="k_wrapper">


			<div class="k_section_title_s">
				<div>클럽 관리</div>
			</div>

		</div>
	</section>

	<section class="k_mycourse" style="font-family: 'Noto Sans KR', sans-serif;">
		<div class="k_wrapper">
			<form method="post" action="/admin/clubMultiDel" id="listFrm">
			<ul class="k_my_club_grid">
				<li class="k_my_list_head"><span>번호</span></li>
				<li class="k_my_list_head"><span>파티명</span></li>
				<li class="k_my_list_head"><span>코스명</span></li>
				<li class="k_my_list_head"><span>일시</span></li>
				<li class="k_my_list_head"><span>인원</span></li>
				<li class="k_my_list_head"><span>관리</span></li>

				<c:forEach var="vo" items="${c_list}">
					<li><span>${vo.no}</span></li>
					<li><a href="/club/club_view?no=${vo.no}&l_id=${vo.id}"><span>${vo.partyname}</span></a></li>
					<li><a href="/mypage/myCourseView?no=${vo.course_no}"><span>${vo.course_name}</span></a></li>
					<li><span>${vo.meeting_time}</span></li>
					<li>
						<span>현: ${vo.current_number}명 /총: ${vo.number}명</span>
					</li>
					<li><span><input type="checkbox" name="noList" value="${vo.no}"></span></li>
				</c:forEach>

			</ul>
			<div class="k_manage_btn_section">
				<input type="checkbox" class="allChk">
				<input type="button" class="delBtn_1" value="삭제하기">
			</div>

			</form>

			<ul class="k_rec_path_page">
						
							<%-- 이전페이지 --%>
							<c:if test="${pVO.nowPage<=1 }">
								<li><i class="fa-solid fa-chevron-left active"></i></li>
							</c:if>
							<c:if test="${pVO.nowPage>1}" >
								<li><a href="/admin/manageClub?nowPage=${pVO.nowPage-1 }<c:if test='${pVO.searchWord!=null}'>&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>"><i class="fa-solid fa-chevron-left active"></i></a></li>
							</c:if>
								
							<c:forEach var="p" begin="${pVO.startPage }" end="${pVO.startPage + pVO.onePageCount - 1 }" >
								<c:if test="${p<=pVO.totalPage }" >
									<li
									<c:if test="${p==pVO.nowPage }">
										style = "font-weight:bold; color:#2fb86a;"
									</c:if>
									><a href="/admin/manageClub?nowPage=${p }<c:if test='${pVO.searchWord!=null}'>&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>">${p }</a></li>
								</c:if>
							</c:forEach>
								
							<!-- 다음페이지 -->
							<c:if test="${pVO.nowPage>=pVO.totalPage }" > 
								<li><i class="fa-solid fa-chevron-right active"></i></li>
							</c:if>
							<c:if test="${pVO.nowPage<pVO.totalPage}" > 
									<li><a href="/admin/manageClub?nowPage=${pVO.nowPage-1 }<c:if test='${pVO.searchWord!=null}'>&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>"><i class="fa-solid fa-chevron-right active"></i></a></li>
							</c:if>
						</ul>
		</div>
	</section>
	</div>
</body>
