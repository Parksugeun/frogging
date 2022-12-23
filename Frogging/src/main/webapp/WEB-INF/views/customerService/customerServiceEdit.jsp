<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="/css/p_style.css" type="text/css"/>
<link rel="preconnect" href="https://fonts.gstatic.com">
<script src="https://code.jquery.com/jquery-3.6.1.min.js" 
       integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
<link href="https://fonts.googleapis.com/css2?family=Black+And+White+Picture&family=Black+Han+Sans&family=Cute+Font&family=Do+Hyeon&family=Dokdo&family=East+Sea+Dokdo&family=Gaegu&family=Gamja+Flower&family=Gothic+A1&family=Gugi&family=Hi+Melody&family=Jua&family=Kirang+Haerang&family=Nanum+Brush+Script&family=Nanum+Gothic&family=Nanum+Gothic+Coding&family=Nanum+Myeongjo&family=Nanum+Pen+Script&family=Noto+Sans+KR&family=Noto+Serif+KR&family=Poor+Story&family=Single+Day&family=Song+Myung&family=Stylish&family=Sunflower:wght@300&family=Yeon+Sung&display=swap" rel="stylesheet">
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
    margin: 0 2px;
    font-family: 'Noto Sans KR', sans-serif;
    }
.btn.black {border-color:#191919;color:#fff;background-color:#333;text-decoration:none;}
</style>
 
<script type="text/javascript">
    
    $(document).ready(function(){        
        getcustomerServiceDetail();        
    });
    
    /* 목록 페이지 이동 */
    function gocustomerServiceList(){                
        location.href = "/customerService/customerServiceList";
    }
     
    

        
</script>
</head>
<body>
    <div class="p_container">
        <div class="inner">    
            <br/><h1 class="p_title">고객센터 수정</h1><br/>
            <form id="customerServiceForm" name="customerServiceForm" method="post" action="/customerService/customerServiceEditOk">    
                <table width="100%" class="table02">
                <caption><strong><span class="t_red">*</span> 표시는 필수입력 항목입니다.</strong></caption>
                    <colgroup>
                         <col width="20%">
                         <col width="*">
                    </colgroup>
                    <tbody id="tbody">
                       <tr>
                            <th>제목<span class="t_red">*</span></th>
                            <td><input id="customerService_subject" name="subject" value="${vo.subject}" class="tbox01"/></td>
                        </tr>
                        <tr>
                            <th>내용<span class="t_red">*</span></th>
                            <td colspan="3"><textarea id="content" name="content" cols="50" rows="5" class="textarea01">${vo.content}</textarea></td>
                        </tr>
                    </tbody>
                </table>    
                <input type="hidden" id="customerService_seq" name="no" value="${vo.no}"/> <!-- 게시글 번호 -->
              	<div class="btn_right mt15" style="width:80%; margin:0 auto; float:center;">
	                <button type="button" class="btn black mr5" onclick="javascript:gocustomerServiceList();">목록으로</button>
	                <input type="submit" class="btn black" value="수정하기"/>
           		 </div>
            </form>
        </div>
    </div>
</body>
</html>