<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="/css/k_style.css">
	<link rel="stylesheet" href="https://use.typekit.net/mss6mty.css">
	<script src="https://kit.fontawesome.com/ab847241fd.js" crossorigin="anonymous"></script>
	<script src="/js/k_script.js" type="text/javascript"></script>
	<script
	src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xx0e16f9f2f8cc49c8af5c5ad4cc51a5c2"></script>
	<script src="/js/tmap_insert_user.js"></script>
</head>

<body class="k_body" onload = "initTmap()">
		<!-- --------- NEW PARTY with rec paths --------- -->
		<section class="k_new_party_rec_path">
			<div class="k_wrapper">
				

				<%-- <div class="k_section_title">
					<div>원하는 모임이 없다면,</div>
					<div class="k_green">나의 모임 만들기 <i class="fa-solid fa-circle-plus"></i></div>
					<button class="k_my_party click-btn-l">
						<a href="/club/my_club_list">나의 모임 관리</a>
					</button>
				</div> --%>
			</div>

			<!-- ----------- make path ------------->
			<div class="k_path_list">
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
						나의 경로 만들기
					</div>
				</div>
					

					<div class="k_path_list_bg">
					<!-- 지도 입력 폼 -->
				
					
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
										
									</ul>
									<ul id="searchResult" name="searchResult">
								<div class="k_green">검색결과</div>
							</ul>
							<form  style="width:100%" method = "post" id = "courseForm"">
								<div class="k_btn_area"><input type="submit" id="courseSave" value="코스 저장"></div>
								<div class="k_btn_area"><a href = "/club/make_club_new_path"><input type="button" id="courseSave" value="자동 코스 생성"></a></div>
							</form>
							</div>
						
							
						<%-- <form action="">
							<div class="k_make_path">
								<div class="k_make_path_map"></div>
								<ul class="k_make_path_detail">
									<li class="k_green"><label for="">코스명</label></li>
									<li class="k_path_detail_in"><input type="text" id="" name=""><input type="button" value="중복검사"></li>
									<li class="k_green"><label for="">시작 위치</label></li>
									<li class="k_path_detail_in"><input type="text" id="" name=""></li>
									<li class="k_green"><label for="">경유 위치</label></li>
									<li class="k_path_detail_in"><input type="text" id="" name=""></li>
									<li class="k_green"><label for="">도착 위치</label></li>
									<li class="k_path_detail_in"><input type="text" id="" name=""></li>
									<li class="k_make_path_total" ><span>예상 소요 시간: / 예상 거리: </span></li>
									<li class="k_make_path_total"><input type="submit" value="코스 저장"></li>
								</ul>
							</div>
						</form> --%>

					</div>
					<ul class="k_rec_path_button">
						<li class="click-btn-w"><a href="/club/make_club_rec_path">추천 코스 선택하기</a></li>
						<li class="active click-btn"><a href="/club/make_club_new_path">나만의 코스 만들기</a></li>
					</ul>
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
							<li class="k_party_set_in"><input type="datetime-local" name="meeting_time" id="k_party_set_meeting_time" value=""></li>
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