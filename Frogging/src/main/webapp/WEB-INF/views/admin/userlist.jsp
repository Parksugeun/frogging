
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
</style>
<script>
$(function(){
	$('.listDel-btn').on("click", function() {
		if (confirm("삭제하시겠습니까?")) {
			return true;
		}
	});
});
</script>
<body style="font-family: 'Noto Sans KR', sans-serif;">
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
				<div>사용자 관리</div>
			</div>

		</div>
	</section>
                    <colgroup>
                        <col width="20%" />
                        <col width="10%" />
                        <col width="10%" />
                        <col width="3%" />
                        <col width="5%" />
                        <col width="5%" />
                        <col width="5%" />
                    </colgroup>
                    <thead>        
                        <tr>
                            <th>아이디(이메일)</th>
                            <th>이름</th>
                            <th>닉네임</th>
                            <th>성별</th>
                            <th>키</th>
              				<th>상태</th>
              				<th>수정/삭제</th>
                        </tr>  
                       
                    </thead>
                    <tbody id="tbody">
   
                    <c:forEach var="vo" items="${userList }">
                    	<tr>
                    	
                            <td>${vo.id}</td>
                            <td>${vo.name}</td>
                            <td>${vo.nickname}</td>
                            <c:if test="${vo.sex==1 }"><td>남</td></c:if>
                            <c:if test="${vo.sex==2 }"><td>여</td></c:if>
                            <td>${vo.height}</td>
                            <c:if test="${vo.restriction==0 }"><td>정상</td></c:if>
                            <c:if test="${vo.restriction==1 }"><td>불량</td></c:if>
                            <td><input type="button" class="listEdit-btn" value="수정" onclick="location.href='/admin/profile?id=${vo.id }'"> / <input type="button" class="listDel-btn" value="삭제" onclick="location.href='/admin/listDel?id=${vo.id }'"></td>
                       
                        </tr>
                     </c:forEach>
                     
                    </tbody>    
                </table>
</div>
</body>
</html>