<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="/css/p_style.css" type="text/css"/>
<link rel="preconnect" href="https://fonts.gstatic.com">
<script src="//cdn.ckeditor.com/4.19.1/full/ckeditor.js"></script>
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
        
    });
        
    /** 게시판 - 목록 페이지 이동 */
    function goQnaList(){                
        location.href = "/qna/qnaList";
    }
    
    
    $(document).ready(function(){        
        CKEDITOR.replace("qna_replyContent");
        
    	$("#qnaReplyForm").submit(function(){
    		if($("#qna_replySubject").val()==""){
    			alert("제목을 입력하세요.");
    			return false;
    		}
    		if(CKEDITOR.instances.content.getData()==""){
    			alert("글내용을 입력하세요.");
    			return false;
    		}
    		return true;
    	});
    });
    
    /** 게시판 - 작성 콜백 함수 */
    function qnaReplyCallback(obj){
    
        if(obj != null){        
            
            var result = obj.result;
            
            if(result == "SUCCESS"){                
                alert("게시글 답글 등록을 성공하였습니다.");                
                goQnaList();                 
            } else {                
                alert("게시글 답글 등록을 실패하였습니다.");    
                return;
            }
        }
    }
    
</script>
</head>
<body>
    <div class="p_container">
        <div class="inner">        
            <br/><h1 class="p_title">Qna 답글작성</h1><br/>
            <form id="qnaReplyForm" name="qnaReplyForm" method="post" action="/qna/qnaReplyOk">
                <input type="hidden" id="qna_parent_seq" name="qna_parent_seq" value="${vo.no}"/> <!-- 부모 게시글 번호 -->
                <input type="hidden" id="qna_reply_group" name="reply_group" value="${vo.reply_group}"/>
                <input type="hidden" id="qna_depth" name="qna_depth" value="${vo.depth}"/>
                <input type="hidden" id="qna_reply_seq" name="qna_reply_seq" value="${vo.reply_seq}"/>
                <table width="100%" class="table02">
                <caption><strong><span class="t_red">*</span> 표시는 필수입력 항목입니다.</strong></caption>
                    <colgroup>
                        <col width="20%">
                        <col width="*">
                    </colgroup>
                    <tbody id="tbody">
                        <tr>
                            <th>제목<span class="t_red">*</span></th>
                            <td><input id="qna_replySubject" name="subject" value="" class="tbox01"/></td>
                        </tr>
                        <tr>
                            <th>내용<span class="t_red">*</span></th>
                            <td><textarea id="qna_replyContent" name="content" cols="10" rows="5" class="textarea01"></textarea></td>
                        </tr>
                    </tbody>
                </table>
				<div class="btn_right mt15" style="width:80%; margin:0 auto; float:center;">
	                <button type="button" class="btn black mr5" onclick="location.href='/qna/qnaList'">목록으로</button>
		            <input type="submit" class="btn black" value="등록하기"/>
            	</div>                
            </form>

        </div>
    </div>
</body>
</html>