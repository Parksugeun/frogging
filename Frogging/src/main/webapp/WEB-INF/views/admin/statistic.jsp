<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<head>
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=Black+And+White+Picture&family=Black+Han+Sans&family=Cute+Font&family=Do+Hyeon&family=Dokdo&family=East+Sea+Dokdo&family=Gaegu&family=Gamja+Flower&family=Gothic+A1&family=Gugi&family=Hi+Melody&family=Jua&family=Kirang+Haerang&family=Nanum+Brush+Script&family=Nanum+Gothic&family=Nanum+Gothic+Coding&family=Nanum+Myeongjo&family=Nanum+Pen+Script&family=Noto+Sans+KR&family=Noto+Serif+KR&family=Poor+Story&family=Single+Day&family=Song+Myung&family=Stylish&family=Sunflower:wght@300&family=Yeon+Sung&display=swap" rel="stylesheet">	
	<link rel="stylesheet" href="/css/k_style.css">
	<link rel="stylesheet" href="https://use.typekit.net/mss6mty.css">
	<script src="https://kit.fontawesome.com/ab847241fd.js" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
	<script src="/js/k_admin.js" type="text/javascript"></script>
	<script src="/js/k_chart.js" type="text/javascript"></script>
</head>
<style>
.k_a_title{
	font-family: 'Noto Sans KR', sans-serif;
}
</style style="font-family: 'Noto Sans KR', sans-serif; ">
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
<body class="k_body" onload="draw_adminplog()" style="font-family: 'Noto Sans KR', sans-serif;">
	<section>
		<div class="k_wrapper">

			<div class="k_section_title_s">
				<div>통계 관리</div>
			</div>
		</div>
	</section>

	<section class="k_activity_sum">
		<div class="k_wrapper">
			<div class="my_write_tab">
				<div><button class="active click-btn k_static_tab_p">플로깅 통계</button></div>
				<div><button class="click-btn k_static_tab_u">유저 통계</button></div>
				<div><button class="click-btn k_static_tab_t">쓰레기 통계</button></div>
			</div>

			<div class="k_static_plog_box">
				<div class="k_a_title">플로깅 통계</div>
				<div class="k_m_chart">
					<div class="k_m_chart_graph"><canvas id="myChart_p"></canvas></div>
				</div>
			</div>

			<div class="k_static_user_box">
				<div class="k_a_title">유저 통계</div>
				<div class="k_m_chart">
					<div class="k_m_chart_graph"><canvas id="myChart_u_1"></canvas></div>
					<div class="k_m_chart_graph"><canvas id="myChart_u_2"></canvas></div>
				</div>
			</div>
		
			<div class="k_static_trash_box">
				<div class="k_a_title">쓰레기 통계</div>
				<div class="k_m_chart">
					<div class="k_m_chart_graph"><canvas id="myChart_t"></canvas></div>
				</div>
			</div>
		
		</div>
	</section>
</body>
