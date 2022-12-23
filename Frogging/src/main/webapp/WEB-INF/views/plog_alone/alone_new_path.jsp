<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="/css/k_style.css">
	<link rel="stylesheet" href="https://use.typekit.net/mss6mty.css">
	<script src="https://kit.fontawesome.com/ab847241fd.js" crossorigin="anonymous"></script>
	<script
	src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xxc6985a9bef1d438f939779b9bf5e79d8"></script>
<script src="/js/tmap_insert.js"></script>
</head>
<body class="k_body">

		<!-- --------- NEW PARTY with rec paths --------- -->
		<section class="k_new_party_rec_path">
			<%-- <div class="k_wrapper"> --%>
				
<%-- 				
				<div class="k_section_title">
					<div>오늘은 혼자 걷고 싶어!</div>
					<div class="k_green">프로깅 혼자하기  <i class="fa-solid fa-circle-plus"></i></div>
				</div>
			</div> --%>

			<!-- ----------- make path ------------->
			<div class="k_path_list">
				<div class="k_wrapper">
				<div class="k_section_title_links">
					<div>
						<i class="fa-solid fa-square-caret-right k_green"></i>
						<a href="/">
							플로깅하기 
						</a>
						<a href="/alone/alone_rec_path">
							<i class="fa-solid fa-angle-right"></i>
							혼자하기
						</a>
						<i class="fa-solid fa-angle-right"></i>
						나만의 경로 만들기
					</div>
				</div>
					<div class="k_path_list_bg">
						<div class="k_make_path_edit">
							<div class="k_make_path_map" id = "map_div"></div>
								<ul class="k_path_infos">
									<li class="k_green"><span>코스 이름</span></li>
									<li id="k_coursename">
									<span id="coursename">
									<input type="text" name="course_name" id = "course_name">
									<input type="button" id = "courseNameCheck" value = "중복 검사" onclick = "nameCheck()">
									</span>
									</li>
									<li class="k_green"><span>코스 정보</span></li>
									<li id="k_course_info"><span id="course_info"><input type="text" name="course_info"></span></li>
									<li class="k_green"><span>소요 시간</span></li>
									<li id="k_time"><span id="result_time">분</span></li>
									<li class="k_green"><span>이동거리</span></li>
									<li id="k_distance"><span id="result_distance">km</span></li>
									<li class="k_green"><span>시작 위치</span></li>
									<li id="k_startaddr"><span><input type = "text" id = "searchStart" onKeypress="javascript:if(event.keyCode==13){searchPlace(this.value, 0)}"></span></li>
									<li class="k_green"><span>도착 위치</span></li>
									<li id="k_endaddr"><span><input type = "text" id = "searchEnd" onKeypress="javascript:if(event.keyCode==13){searchPlace(this.value, 1)}"></span></li>
									<li class="k_green"><span>경유지</span><input type = "button" id="addr_btn" value = "추가" onclick = "add_textbox()"></li>
									<li id="waypoint">
									</li>
								</ul>
								<ul id="searchResult" name="searchResult">
									<div class="k_green">검색결과</div>
								</ul>
								<form style="width:100%" method = "post" id = "courseForm">
									<div class="k_btn_area"><input type="submit" id="courseSave" value="코스 저장"></div>
									<div class="k_btn_area"><a href = "/alone/alone_new_path_user"><input type="button" id="courseSave" value="수동 코스 생성"></a></div>
								</form>
						</div>
										

							<%-- <div class="k_make_path">
								<div class="k_make_path_map" id = "map_div" style= "overflow : hidden;"></div>
								<ul class="k_make_path_detail">
									<li class="k_green"><label for="">코스명</label></li>
									<li class="k_path_detail_in"><input type="text" id="course_name" name="course_name"><input type="button" id = "courseNameCheck" value = "중복 검사" onclick = "nameCheck()"></li>
									<li class="k_green"><label for="">시작 위치</label></li>
									<li class="k_path_detail_in"><input type="text" id = "searchStart" onKeypress="javascript:if(event.keyCode==13){searchPlace(this.value, 0)}"></li>
									<li class="k_green"><label for="">경유 위치</label></li>
									<li class="k_path_detail_in"><div id = "waypoint"></div></li>
									<li class="k_green"><label for="">도착 위치</label></li>
									<li class="k_path_detail_in"><input type="text" id = "searchEnd" onKeypress="javascript:if(event.keyCode==13){searchPlace(this.value, 1)}"></li>
									<li class="k_make_path_total" ><span id = "result">예상 소요 시간: / 예상 거리: </span></li>
									<li class="k_make_path_total"><form><input type="submit" value="코스 저장"></form></li>
								</ul>
							</div> --%>


					</div>
					
					<ul class="k_rec_path_button">
						<li><a href="/alone/alone_rec_path">추천 코스 선택하기</a></li>
						<li class="active">
							<div><a href="/mobile/mobileList">혼자 프로깅 시작</a></div>
						</li>
					</ul>
					
				</div>
			</div>
		</section>

</body>
</html>