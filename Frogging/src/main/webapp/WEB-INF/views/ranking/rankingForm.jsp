<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" href="/css/ranking.css" type="text/css"/>
	</head>

<body>
	
<div id="s_container">
		<div id="s_header">
			<div id="s_rankingBox">
				<h1>Ranking</h1>
				<p>현재 플로깅 랭킹들을 확인해보세요!</p>
			</div>
		</div>
		
		<div class="s_bar"> 플로깅 주간랭킹</div>
	
	<!-- 랭킹시작 -> 주간 횟수 -->	
		<div id="s_rankingBarweek">
			<div class="s_mune">플로깅 횟수</div>	
			
			<div id="s_cntweekList">
				<ul class="s_list">
					<li>랭킹</li>
					<li>닉네임</li>
					<li>플로깅 횟수</li>
				</ul>
			</div>		
<!-- 예시내용 ============================================== -->	
				<div class="s_rankList">
				<c:forEach var="vo" items="${list_1}">
					<ul id="s_weeklist">
						<li>${vo.rownum}위</li>
						<li>${vo.nickname}</li>
						<li>${vo.plog_count}회</li>
					</ul>
				</c:forEach>
				<%-- <ul id="s_weeklist">
						<li>${vo.rownum}위</li>
						<li>${vo.nickname}</li>
						<li>${vo.plog_count}회</li>
					</ul> --%>
				<%-- <ul id="s_weeklist">
					<li>1위</li>
					<li>프로거</li>
					<li>125회</li>
				</ul>
				<ul id="s_weeklist2">
					<li>2위</li>
					<li>프로거</li>
					<li>100회</li>
				</ul>
				<ul id="s_weeklist3">
					<li>3위</li>
					<li>프로거</li>
					<li>95회</li>
				</ul> --%>
			</div>
<!-- ============================================== -->		
		</div>




<!-- 랭킹시작 -> 주간 km순-->
<div id="s_rankingBarkm">
			<div class="s_mune">플로깅 Km</div>	
			
		<div id="s_kmweekList">
			<ul class="s_list">
				<li>랭킹</li>
				<li>닉네임</li>
				<li>플로깅 km</li>
			</ul>
		</div>		
<!-- 예시내용 ============================================== -->
			<div class="s_rankList">
			<c:forEach var="vo" items="${list_2}">
			<ul id="s_kmweeklist">
				<li>${vo.rownum}위</li>
				<li>${vo.nickname}</li>
				<li>${vo.total_distance}km</li>
			</ul>
			</c:forEach>
			<%-- 			<ul id="s_kmweeklist2">
				<li>1위</li>
				<li>프로거</li>
				<li>100km</li>
			</ul>
			<ul id="s_kmweeklist3">
				<li>1위</li>
				<li>프로거</li>
				<li>86km</li>
			</ul> --%>
		</div>
<!-- ============================================== -->	
		</div>
		
	
		
<!-- ************************************************************************************************************ -->		
<!-- 랭킹시작 -> 월간 횟수 -->	
	<div id="s_background">
		<div class="s_bar"> 플로깅 월간랭킹</div>
			<div id="s_rankingBarmonth">
				<div class="s_mune">플로깅 횟수</div>	
				
			<div id="s_cntmonthList">
				<ul class="s_list">
					<li>랭킹</li>
					<li>닉네임</li>
					<li>플로깅 횟수</li>
				</ul>
			</div>		
	<!-- 예시내용 ============================================== -->
			<div class="s_rankListGlay">
				<c:forEach var="vo" items="${list_3}">
					<ul id="s_monthlist2">
						<li>${vo.rownum}위</li>
						<li>${vo.nickname}</li>
						<li>${vo.plog_count}회</li>
					</ul>
				</c:forEach>
				<%-- <ul id="s_monthlist2">
					<li>1위</li>
					<li>프로거</li>
					<li>125회</li>
				</ul>
				<ul id="s_monthlist3">
					<li>1위</li>
					<li>프로거</li>
					<li>125회</li>
				</ul> --%>
			</div>
	<!-- ============================================== -->		
		</div>
		
		
	<!-- 랭킹시작 -> 월간 km순-->
	<div id="s_rankingBarmonthkm">
				<div class="s_mune">플로깅 Km</div>	
				
			<div id="s_kmMonthList">
				<ul class="s_list">
					<li>랭킹</li>
					<li>닉네임</li>
					<li>플로깅 km</li>
				</ul>
			</div>		
	<!-- 예시내용 ============================================== -->
				<div class="s_rankListGlay">
				<c:forEach var="vo" items="${list_4}">
					<ul id="s_kmmonthlist2">
						<li>${vo.rownum}위</li>
						<li>${vo.nickname}</li>
						<li>${vo.total_distance}km</li>
					</ul>
				</c:forEach>
				<%-- <ul id="s_kmmonthlist2">
					<li>1위</li>
					<li>프로거</li>
					<li>500km</li>
				</ul>
				<ul id="s_kmmonthlist3">
					<li>1위</li>
					<li>프로거</li>
					<li>480km</li>
				</ul> --%>
			</div>
	<!-- ============================================== -->	
		</div>
			
	</div> <!-- 백그라운드 -->
	

</div>
</body>
</html>