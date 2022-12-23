<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Black+And+White+Picture&family=Black+Han+Sans&family=Cute+Font&family=Do+Hyeon&family=Dokdo&family=East+Sea+Dokdo&family=Gaegu&family=Gamja+Flower&family=Gothic+A1&family=Gugi&family=Hi+Melody&family=Jua&family=Kirang+Haerang&family=Nanum+Brush+Script&family=Nanum+Gothic&family=Nanum+Gothic+Coding&family=Nanum+Myeongjo&family=Nanum+Pen+Script&family=Noto+Sans+KR&family=Noto+Serif+KR&family=Poor+Story&family=Single+Day&family=Song+Myung&family=Stylish&family=Sunflower:wght@300&family=Yeon+Sung&display=swap" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="/css/p_style.css" type="text/css"/>
<link rel="stylesheet" href="/css/k_style.css">
<link rel="stylesheet" href="https://use.typekit.net/mss6mty.css">
<script src="https://kit.fontawesome.com/ab847241fd.js" crossorigin="anonymous"></script>
<style>
.listEdit-btn, .listDel-btn {    
	height: 28px;
    width: 40px;
    border : 1px solid white;
    border-radius:5px;
    color: white;
    font-weight: bold;
	border-color:#191919;color:#fff;
	background-color:#333;
	text-decoration:none;
	font-family: 'Noto Sans KR', sans-serif; 
	   
}
.k_section_title>div>i{ /*아이콘*/
	font-size: calc(var(--size-medium-1)*1.2);
}
#tbody > tr > td > a{
	text-decoration:none;
	color:black;
}
a:visited {
  color : black;
  text-decoration: none;
}
a:link { 
  color: black; 
  text-decoration: none;
}
</style>
<script>
function eventDelete(){
	if(confirm("글을 삭제하시겠습니까?")){
		location.href="/event/eventDel?no=${vo.no}";
	}
};
</script>
<body style="font-family: 'Noto Sans KR', sans-serif; ">
<div style="height:100%;">
<table width="80%" class="table01">
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
		<section>
		<div class="k_wrapper">

			<div class="k_section_title_s">
				<div>이벤트 관리</div>
			</div>

		</div>
	</section>
                    <colgroup>
                        <col width="4%" />
                        <col width="41%" />
                        <col width="17%" />
                        <col width="10%" />
                        <col width="8%" />
                    </colgroup>
                    <thead>        
                        <tr style="font-family: 'Noto Sans KR', sans-serif;">
                            <th>글번호</th>
                            <th>제목</th>
                            <th>작성자</th>
                            <th>작성일</th>   
              				<th>수정/삭제</th>
                        </tr>  
                       
                    </thead>
                    <tbody id="tbody">
                    <c:forEach var="vo" items="${list }">
                    	<tr>
                            <td>${vo.no}</td>
                            <td style="text-align:left;">                           
                            	<a href="/event/eventView?no=${vo.no }">${vo.subject }</a>               
                           </td>
                            <td>${vo.id}</td>
                            <td>${vo.writedate}</td>
                            <td>
                            <input type="hidden" name="no" value="${vo.no }"/>
                            <input type="button" class="listEdit-btn" value="수정" onclick="location.href='/event/eventEdit/${vo.no }'"> / 
                            <input type="button" class="listDel-btn" value="삭제" onclick="location.href='/admin/eventDel?no=${vo.no}'"></td>
                        </tr>
                     </c:forEach> 
                      <div class="p_eventServicePage">
				        <ul>
						<!-- 페이지 번호 -->
							<c:if test="${pVO.nowPage<=1 }"><!-- 이전페이지가 없을때 -->
								<li>이전</li>
							</c:if>
							<c:if test="${pVO.nowPage>1 }"><!-- 이전페이지가 있을때 -->
								<li><a href="/admin/eventList?nowPage=${pVO.nowPage-1 }<c:if test='${pVO.searchWord!=null}'>&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>">이전</a></li>
							</c:if>
							<c:forEach var="p" begin="${pVO.startPage }" end="${pVO.startPage+pVO.onePageCount-1 }">
								<!--  출력할 페이지번호 총페이지수 보다 작거나 같을 떄 -->
								<c:if test="${p<=pVO.totalPage }">
									<li
									<c:if test="${p==pVO.nowPage }">
									</c:if>
									><a href="/admin/eventList?nowPage=${p}<c:if test='${pVO.searchWord!=null}'>&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>">${p}</a></li>
								</c:if>
							</c:forEach>
							
							<!-- 다음페이지 -->
							<c:if test="${pVO.nowPage==pVO.totalPage }">
								<li>다음</li>
							</c:if>
							<c:if test="${pVO.nowPage<pVO.totalPage }">
								<li><a href="/admin/eventList?nowPage=${pVO.nowPage+1 }<c:if test='${pVO.searchWord!=null}'>&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>">다음</a></li>
							</c:if>
						</ul>
						</div>
                    </tbody>    
                </table>
</div>
</body>
</html>