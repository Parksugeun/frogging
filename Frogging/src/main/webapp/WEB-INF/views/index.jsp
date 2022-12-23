<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Frog-ging</title>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
	<script src="https://code.jquery.com/jquery-3.6.1.min.js" 
        integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
    <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
	<link rel="stylesheet" href="/css/p_style.css" type="text/css"/>
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=Black+And+White+Picture&family=Black+Han+Sans&family=Cute+Font&family=Do+Hyeon&family=Dokdo&family=East+Sea+Dokdo&family=Gaegu&family=Gamja+Flower&family=Gothic+A1&family=Gugi&family=Hi+Melody&family=Jua&family=Kirang+Haerang&family=Nanum+Brush+Script&family=Nanum+Gothic&family=Nanum+Gothic+Coding&family=Nanum+Myeongjo&family=Nanum+Pen+Script&family=Noto+Sans+KR&family=Noto+Serif+KR&family=Poor+Story&family=Single+Day&family=Song+Myung&family=Stylish&family=Sunflower:wght@300&family=Yeon+Sung&display=swap" rel="stylesheet">
   	</head>
   	<style>
   	.mobileHome{display:none;}
   	@media screen and (min-width:152px) and (max-width:1024px){
	.p_container1{display:none;}
	.mobileHome{display:block; z-index:1; min-height: 100%; }
   	.p_container1 {
    min-height: 100%;
    position: relative;
	}
	.mobileTop{
		display:flex;
		justify-content: space-between;
		background-color:#2fb86a;
	}
	.mobileMenu > ul >li{
		display: inline-block;
		font-family: 'Noto Sans KR', sans-serif;
		line-height: 80px;
		font-size: 18px;
		margin: auto 20px;
		font-weight: bold;
		text-decoration:none;
	}
	.mobileMenu > ul >li>a{
		color:white;
	}
	.mobileMenu-log, .mobileMenu-logout{
		width:200px;
		text-align:center;
	}
	.mobileBody{
	background-image:url(./img/plogging4.jfif);
	}
	.mobile-plogging-btn{
		height:100px;
		width:100px;
		background-color: #2fb86a;
		font-family: 'Noto Sans KR', sans-serif;
		color:white;
		font-weight: bold;
		font-size: 24px;
		border : 1px solid white;
  			border-radius:5px;
		position: absolute;
		left:50%;
		top: 50%;
		transform: translate(-50%, -50%);
	}
	}
    </style>
<script>

</script>
<body>
	<div class="p_container1" style="overflow-y: hidden;">
	<div class="swiper-container">
		<div class="swiper-wrapper">
			<div class="swiper-slide">
				<div class="p_mainContent_wrapper">
					<div>
					 <div class="p_mainContent">  
	                    <div class="p_nav">
	                        <h3>함께하는 플로깅 <br/> Frog-ging</h3> <br/> 환경보호 활동과 운동을 한번에! <br/><br/>					
	                        <input type="button" value="함께하기" class="p_plogging-btn" onclick="location.href='/club/join_club'"/>
	                        <input type="button" value="혼자하기" class="p_plogging-btn" onclick="location.href='/alone/alone_rec_path'"/>					
	                    </div>
	                    <div class="p_section" >
	                        <h3>${data[0].month}월의 기록</h3> <h4>이번 달 기록을 확인하세요!</h4><br/>
	                        <div class="p_section-ment" style="font-weight:normal">	
	                        총 ${data[0].trash_sum}L의 쓰레기가 수거되었어요!<br/>
	                        총 ${data[0].total_distance}km를 걸으셨어요!<br/>
													총 ${data[0].total_step}보를 걸으셨어요!<br/>
													총 ${data[0].total_time}분을 걸으셨어요!<br/>
	                        총 ${data[0].plog_count}번의 프로깅이 기록되었어요!<br/>		
	                        </div>
	                    </div>
	                </div>
						</div>
					</div>
			</div>
			<div class="swiper-slide">
				<div class="p_main-plogging">
	                    <div class="p_plogging-ment">
	                        <img src="./img/plogging-ment.jpg" alt="플로깅" class="plogging-img" style="height: 200px; width:300px;" />
	                        <h1 style="color:#2fb86a; font-family: 'Jua', sans-serif;">플로깅(plogging)?</h1><br/>
	                        <h5 style="font-family: 'Noto Sans KR', sans-serif;">
	                        스웨덴어의 '플로카 우프(plocka upp 줍다)'와 영어단어 조깅(jogging)을 합성한 단어로<br/>
	                        '쓰레기를 주으며 조깅하기'라는 의미에요.<br/>
	                        한국에서는 '줍다'와 '조깅'을 결합한 '줍깅'이라는 용어를 사용하기도 해요.<br/>
	                        조깅을 하는 동안 눈에 띄는 쓰레기를 줍는 일로, 운동으로 건강을 챙기는 동시에 환경을 지키기 위한<br/>
	                        작은 실천에 동참하자는 취지로 행하는 환경보호운동이라 할 수 있어요.<br/>
	                        </h5>
	                        <h1> </h1><br/>
	                        <a href="/introductionForm">프로젝트 소개 보러가기</a>
	                    </div>
	                </div>
			</div>
			<div class="swiper-slide">
				<div class="p_main-event"> 
				<br/>              
	                    <h2 class="p_title">진행중인 이벤트</h2><br/>
	                    <h5>여러곳에서 진행하는 다양한 플로깅 이벤트를 확인해보세요.</h5>
	                    <br/>	
	                     <div class="container">
											 <div class="row">
											 	<c:forEach var="vo" items="${list }">
													  <div class="col-4">
	                              <div class="card">
	                                <div class="card-header">
	                                	${vo.writedate}
	                                </div>
	                                <div class="card-body" style="height:340px">
	                                  <h5 class="card-title" style="white-space: nowrap;overflow: hidden;text-overflow: ellipsis;">${vo.subject}</h5>
	                                  <%-- <img src="./img/event1.png" alt="이벤트" class="card-img" style="height: 70%; width:100%;" />
																		--%>
																		<c:if test="${vo.imgName!=null}">
																			<img alt="이벤트 사진" src="${vo.imgName}" class="card-img" style="height:70%"/>
																		</c:if>
																		<c:if test="${vo.imgName==null}">
																			<img alt="이벤트 사진" src="/img/event1.png" class="card-img" style="height:70%"/>
																		</c:if>
	                                  <p class="card-text"></p>
	                                  <a href="/event/eventView?no=${vo.no}" class="btn btn-primary" style="background-color:#2fb86a; border:1px solid #2fb86a; font-family: 'Noto Sans KR', sans-serif; font-weight: bold;">이벤트 바로가기</a>
	                                </div>
	                              </div>
	                            </div>

												</c:forEach>
											</div>
	                          <div class="p_event-btn-area">
	                            <input type="button" value="더보기" onclick="location.href='/event/eventList';" class="p_event-btn">
	                          </div>
	                        </div>
	                        
	                        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
	                        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>  
	              </div>
			</div>
			<div class="swiper-pagination"></div>
		
		  <!-- If we need navigation buttons -->
		  <div class="swiper-button-prev"></div>
		  <div class="swiper-button-next"></div>
		
		  <!-- If we need scrollbar -->
		  <div class="swiper-scrollbar"></div>
			<script>
			const swiper = new Swiper('.swiper-container', {
				  //기본 셋팅
				  //방향 셋팅 vertical 수직, horizontal 수평 설정이 없으면 수평
				  direction: 'horizontal',
				  //한번에 보여지는 페이지 숫자
				  slidesPerView: 1,
				  //페이지와 페이지 사이의 간격
				  spaceBetween: 30,
				  //드레그 기능 true 사용가능 false 사용불가
				  debugger: true,
				  //마우스 휠기능 true 사용가능 false 사용불가
				  mousewheel: true,
				  //반복 기능 true 사용가능 false 사용불가
				  loop: true,
				  //선택된 슬라이드를 중심으로 true 사용가능 false 사용불가 djqt
				  centeredSlides: true,
				  // 페이지 전환효과 slidesPerView효과와 같이 사용 불가
				  // effect: 'fade',
				  
				  
				  //자동 스크를링
				  autoplay: {
				    //시간 1000 이 1초
				    delay: 8000,
				    disableOnInteraction: false,
				   },
				  
				  //페이징
				  pagination: {
				    //페이지 기능
				    el: '.swiper-pagination',
				    //클릭 가능여부
				    clickable: true,
				  },

				  //방향표
				  navigation: {
				    //다음페이지 설정
				    nextEl: '.swiper-button-next',
				    //이전페이지 설정
				    prevEl: '.swiper-button-prev',
				  },
				  
				});
			</script>
		</div>
	</div>
	</div>   
</body>
<div class="mobileHome">
	<div class="container" style="height:100px; width:110%; margin:0 auto 0 -15px;">
		<div class="mobileTop" style="position: fixed; width:100%;">
		    <div class="moble_logo" style="height:100px;">
	       	<img src="../img/logo3.png" alt="로고" style="width:150px; height:80px; margin-top:10px;">
			</div>
			<div class="mobileMenu">
			<ul>
			<c:if test="${logStatus==null}">
              	<li><a href="/login" class="mobileMenu-log">로그인</a></li>         
			</c:if>
			<c:if test="${logStatus=='Y'}">
				<li><a href="/logout" class="mobileMenu-logout">로그아웃</a></li>
			</c:if>
			</ul>
			</div>
		</div>	
	</div>
	<div class="mobileBody" style="height:1000px; background-image:url(./img/plogging4.jfif);">
			<!--  <input type="button" value="모바일페이지" class="mobile-plogging-btn" onclick="location.href='/mobile/mobileHome'"/>-->			
				  <input type="button" value="시작하기" name="시작버튼" class="mobile-plogging-btn" onclick="location.href='/mobile/mobileHome'"/>		
		</div>
</div>	
</html>