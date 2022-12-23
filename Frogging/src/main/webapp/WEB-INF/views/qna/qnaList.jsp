<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="/css/p_style.css" type="text/css"/>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Black+And+White+Picture&family=Black+Han+Sans&family=Cute+Font&family=Do+Hyeon&family=Dokdo&family=East+Sea+Dokdo&family=Gaegu&family=Gamja+Flower&family=Gothic+A1&family=Gugi&family=Hi+Melody&family=Jua&family=Kirang+Haerang&family=Nanum+Brush+Script&family=Nanum+Gothic&family=Nanum+Gothic+Coding&family=Nanum+Myeongjo&family=Nanum+Pen+Script&family=Noto+Sans+KR&family=Noto+Serif+KR&family=Poor+Story&family=Single+Day&family=Song+Myung&family=Stylish&family=Sunflower:wght@300&family=Yeon+Sung&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/css/k_style.css">
<link rel="stylesheet" href="https://use.typekit.net/mss6mty.css">
<script src="https://code.jquery.com/jquery-3.6.1.min.js" 
       integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
<style>
/* button */
.btn {    
	height: 35px;
    width: 90px;
    background-color: #2fb86a;
    border : 1px solid white;
    border-radius:5px;
    color: white;
    font-weight: bold;
    font-size: 18px;
    font-family: 'Noto Sans KR', sans-serif;
    margin: 0 10px;
    }
.btn.black {border-color:#191919;color:#fff;background-color:#333;text-decoration:none;}
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
</head>
<body>
    <div class="p_container">
        <div class="inner">        
            <br/><h1 class="p_title">QnA</h1> 
            <div class="k_section_title" style="width:80%; margin:0 auto;">
				<div class="k_green" >
					궁금한게 있으면 
				</div>
				<div>뭐든지 물어보세요 <i class="fa-solid fa-magnifying-glass k_green"></i></div>
			</div> 
			<br>          
            <form id="qnaForm" name="qnaForm">
            	<input type="hidden" id="function_name" name="function_name" value="getQnaList" />
				<input type="hidden" id="current_page_no" name="current_page_no" value="1" />
                <table class="table01">
                    <colgroup>
                        <col width="4%" />
                        <col width="42%" />
                        <col width="4%" />
                        <col width="20%" />
                        <col width="10%" />
                    </colgroup>
                    <thead>        
                        <tr>
                            <th>글번호</th>
                            <th>제목</th>
                            <th>조회수</th>
                            <th>작성자</th>
                            <th>작성일</th>             
                        </tr>                        
                    </thead>
                    <tbody id="tbody">
                    <c:forEach var="vo" items="${list }">
                    	<tr>
                            <td>${vo.no}</td>
                            <td style="text-align:left;">                           
                            <c:if test="${vo.depth== 0 }">
                            	<a href="/qna/qnaDetail?no=${vo.no }">Q: ${vo.subject }</a>
                            
                            </c:if>
                            <c:if test="${vo.depth > 0 }">
                            	<a href="/qna/qnaDetail?no=${vo.no }"><span style="padding-left:${vo.depth *40}px;"> A:</span>${vo.subject }</a>
                            </c:if> 
                           </td>
                            <td>${vo.hit}</td>
                            <td>${vo.name}</td>
                            <td>${vo.writedate}</td>
                        </tr>
                        	</c:forEach> 
                    </tbody>    
                </table>               
             <div class="btn_right mt15" style="width:70%; margin:5px auto; float:right;">
                <button type="button" class="btn black mr5" onclick="location.href='/qna/qnaWrite'" style="font-family: 'Noto Sans KR', sans-serif;">작성하기</button>
            </div>    
            </form>
     	<div class="p_qnaPage">
			<ul>
			<!-- 페이지 번호 -->
				<c:if test="${pVO.nowPage<=1 }"><!-- 이전페이지가 없을때 -->
					<li>이전</li>
				</c:if>
				<c:if test="${pVO.nowPage>1 }"><!-- 이전페이지가 있을때 -->
					<li><a href="/qna/qnaList?nowPage=${pVO.nowPage-1 }<c:if test='${pVO.searchWord!=null}'>&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>">이전</a></li>
				</c:if>
				<c:forEach var="p" begin="${pVO.startPage }" end="${pVO.startPage+pVO.onePageCount-1 }">
					<!--  출력할 페이지번호 총페이지수 보다 작거나 같을 떄 -->
					<c:if test="${p<=pVO.totalPage }">
						<li
						<c:if test="${p==pVO.nowPage }">
						</c:if>
						><a href="/qna/qnaList?nowPage=${p}<c:if test='${pVO.searchWord!=null}'>&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>">${p}</a></li>
					</c:if>
				</c:forEach>
				
				<!-- 다음페이지 -->
				<c:if test="${pVO.nowPage==pVO.totalPage }">
					<li>다음</li>
				</c:if>
				<c:if test="${pVO.nowPage<pVO.totalPage }">
					<li><a href="/qna/qnaList?nowPage=${pVO.nowPage+1 }<c:if test='${pVO.searchWord!=null}'>&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>">다음</a></li>
				</c:if>
			</ul>
			<div>
			 <form method="get" action="/qna/qnaList" class="p_searchForm" style="width:100%;">
                <select name="searchKey" class="p_searchKey" style="height:30px; width:90px; font-size: 16px;">
                    <option value="subject">제목</option>
                    <option value="nickname">작성자</option>
                    <option value="content">글내용</option>
                </select>
                <input type="text" name="searchWord" class="p_searchWord" style="height:35px; width:500px;"/>
                <input type="submit" value="찾기" class="p_qnasearch-btn" style="font-family: 'Noto Sans KR', sans-serif; height:35px;"/>
            </form>
            </div>	
		</div>            
        </div>     
    </div>
</body>    
</html>