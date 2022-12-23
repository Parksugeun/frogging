<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="/css/p_style.css" type="text/css"/>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Black+And+White+Picture&family=Black+Han+Sans&family=Cute+Font&family=Do+Hyeon&family=Dokdo&family=East+Sea+Dokdo&family=Gaegu&family=Gamja+Flower&family=Gothic+A1&family=Gugi&family=Hi+Melody&family=Jua&family=Kirang+Haerang&family=Nanum+Brush+Script&family=Nanum+Gothic&family=Nanum+Gothic+Coding&family=Nanum+Myeongjo&family=Nanum+Pen+Script&family=Noto+Sans+KR&family=Noto+Serif+KR&family=Poor+Story&family=Single+Day&family=Song+Myung&family=Stylish&family=Sunflower:wght@300&family=Yeon+Sung&display=swap" rel="stylesheet">
<style>
	#p_replyList li{
		border-bottom:1px solid #ddd;
		margin:10px;
		height:100px;
	}
    #modal.modal-overlay {
       width: 100%;
       height: 100%;
       position: absolute;
       left: 0;
       top: 0;
       display: flex;
       flex-direction: column;
       align-items: center;
       justify-content: center;
       background: rgba(255, 255, 255, 0.25);
       box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
       backdrop-filter: blur(1.5px);
       -webkit-backdrop-filter: blur(1.5px);
       border-radius: 10px;
       border: 1px solid rgba(255, 255, 255, 0.18);
   }
   #modal .modal-window {
       background: #e7e8e6;
       box-shadow: 0 8px 32px 0 rgba( 31, 38, 135, 0.37 );
       backdrop-filter: blur( 13.5px );
       -webkit-backdrop-filter: blur( 13.5px );
       border-radius: 10px;
       border: 1px solid rgba( 255, 255, 255, 0.18 );
       width: 400px;
       height: 500px;
       position: relative;
       top: -100px;
       padding: 10px;
       
   }
   #modal .title {
       padding-left: 10px;
       display: inline;
       text-shadow: 1px 1px 2px gray;
       color: white;
       
   }
   #modal .title h2 {
       display: inline;
   }
   #modal .close-area {
       display: inline;
       float: right;
       padding-right: 10px;
       cursor: pointer;
       text-shadow: 1px 1px 2px gray;
       color: white;
   }
   
   #modal .content {
       margin-top: 20px;
       padding: 0px 10px;
       text-shadow: 1px 1px 2px gray;
       color: white;
   }
   #p_viewbutton, .p_rereply-btn, .p_communityreply-btn{
   	font-family: 'Noto Sans KR', sans-serif;
   }
</style>
<script>
function communityDel(){
	if(confirm("글을 삭제하시겠습니까?")){
		location.href="/community/communityDel?no=${vo.no}";
	}
}

	$(function(){
		//해당원글의 댓글목록 가져오는 함수
		function replyAllList(){
			// 기존목록 지우기
			$("#p_replyList>ul").empty(); 
			var url = "/reply/replyList";
			var params = "no="+${vo.no};
			
			
			$.ajax({
				url : url,
				data : params,
				type : 'GET',
				success : function(result){
					var $reply = $(result);
					
					var tag="";
					$reply.each(function(i, vo){
						tag = "<li ";
						if (vo.depth >0){
							tag+= "style='padding-left:"
							tag+= "30px'>"; //tag+= (vo.depth*10)+"px'>";
						}						
	
						tag += "<div><b>"+vo.nickname+"("+vo.writedate+")</b>"

						tag += "<input type='hidden' name='reply_no' value='"+vo.reply_no+"'/>";
						tag += "<input type='button' value='답글' class='p_reReply' onclick=''/>";
						//수정삭제버튼(자신이 쓴 글일때만)표시
						if(vo.id=='${logId}'){
							tag += "<input type='button' value='수정' class='p_replyEdit'/>";
							tag += "<input type='button' value='삭제' class='p_replyDel' title='"+vo.reply_no+"'/>";
						}
						tag += "<br/>"+vo.content+"</div>";
						//수정폼
						if(vo.id=='${logId}'){
							tag += "<div style='display:none'><form method='post'>";
							tag += "<input type='hidden' name='reply_no' value='"+vo.reply_no+"'/>";
							tag += "<textarea name='content' rows='4' cols='50'>"+vo.content+"</textarea>";
							tag += "<input type='submit' value='수정' class='p_replyEditOk'/>";
							tag += "</form></div>";
						}	
						
						tag += "</li>";
					
						$("#p_replyList>ul").append(tag);
					});
					
					
				},error:function(e){
					console.log(e.responseText);
				}
			});
			
		}
		
		//댓글쓰기	
		$("#p_replyForm").submit(function(){
			event.preventDefault();
			var params = $("#p_replyForm").serialize();
			
			
				if($("#p_replycontent").val()==""){
					alert("내용을 입력하세요.");
					return false;
				}
		
			
			$.ajax({	
				url:"/reply/replyWrite",
				data:params,
				type:"POST",
				success:function(result){
					//댓글등록여부
					console.log("댓글등록수:", result);
					
					//이미등록된 글 지우기
					$("#p_replycontent").val("");
					
					replyAllList(); 
					
				},error:function(e){
					console.log(e.responseText);
				}
			});	
		});

		//댓글수정하기
		$(document).on('click','#p_replyList input[value=수정]',function(){
			$(this).parent().css("display","none"); //수정버튼의 부모 숨김
			$(this).parent().next().css("display","block");//수정폼 보여주기
		});
		
		//댓글수정하기
		$(document).on('submit','#p_replyList form', function(){
			event.preventDefault();
			var url = "/reply/replyEdit";
			var params = $(this).serialize();
			
			$.ajax({
				url : url,
				data : params,
				type : "POST",
				success : function(result){
					
					replyAllList();
				}, error:function(e){
					console.log(e.responseText);
				}
			});
		});
		
		//댓글삭제
		$(document).on('click','#p_replyList input[value=삭제]',function(){
			if(confirm("댓글을 삭제하시겠습니까?")){
				var params = {reply_no : $(this).attr('title')};
				
				$.ajax({
					url:"/reply/replyDel",
					data:params,
					success:function(result){
						replyAllList();
					},error:function(e){
						console.log(e.responseText);
					}
				});
			}
	
		});
		
		//대댓글 쓰기
		$(document).on('click','#p_replyList input[value=답글]',function(){
			
			$("#modal").css("display","flex");
			$("#reply_no").val($(this).prev().attr("value"));
		});
		
		$("#p_reReplyForm").submit(function(){
			event.preventDefault();
			var params = $("#p_reReplyForm").serialize();
			
			
			$.ajax({	
				url:"/reply/reReplyInsert",
				data:params,
				type:"POST",
				success:function(result){
					//댓글등록여부
					alert("댓글등록되었습니다." + result);
					$("#modal").css("display","none");
					
					//이미등록된 글 지우기
					$("#p_rereplycontent").val("");
					
					replyAllList(); 
					
				},error:function(e){
					console.log(e.responseText);
				}
			});	
		});
			
		replyAllList();
	});
		
</script>
<div class="p_container">
	<h1 class="p_title">글내용보기</h1>
	
	<div id="p_communityview">
		<ul style="padding: 10 50; margin: 10px 20px;">
			<h5><li>no: ${vo.no }</li>
				<li>닉네임: ${vo.nickname }<hr/></li>
			
				<span style="word-spacing:15px;"><li>조회수:${vo.hit } 등록일:${vo.writedate }</li></span>
				<span style="padding:1px;"><li>제목: ${vo.subject }</li></span></h5>
				
		</ul>	
		<div id="p_content">
			<ul>
				<h5><li>글내용</li>
				<span style="padding:1px;"><li>${vo.content}</li></span></h5><hr/>
			</ul>
		</div>	
	<div id="p_viewselect">
			
			<input type="button" value="목록" id="p_viewbutton" onclick="location.href='/community/communityList?nowPage=${pVO.nowPage }<c:if test='${pVO.searchWord!=null }'>&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>'"/>
			<c:if test="${vo.id==logId}">
			<input type="button" value="수정" id="p_viewbutton" onclick="location.href='/community/communityEdit/${vo.no }'"/>
			<input type="button" value="삭제" id="p_viewbutton" onclick="location.href='javascript:communityDel();'"/>
			</c:if>
		</div>
	</div>
		
	<div>
		<form method="post" id="p_replyForm">			
			<input type="hidden" name="no" value="${vo.no }"/>
			<textarea maxlength="100" name="content" id="p_replycontent" cols="50" rows="3" style="height:120px;"></textarea>
			<input type="submit" value="댓글쓰기"class="p_communityreply-btn"/>
		</form>
	</div>
	<div id="p_replyList">
		<ul style="width:600px;">
		</ul>
	</div>
		
		
	<div id="modal" class="modal-overlay" style="display:none;">
        <div class="modal-window">
            <div class="title">
                <h2>대댓글 등록</h2>
            </div>
            <div class="close-area">X</div>
            <div class="content">
				<form method="post" id="p_reReplyForm">
					<input type="hidden" name="reply_no" id="reply_no" />
					<textarea maxlength="100" name="content" id="p_rereplycontent" cols="50" rows="3" style="height:120px;"></textarea>
					<input type="submit" value="답글쓰기"class="p_rereply-btn"/>
				</form>
                
            </div>
        </div>
    </div>	
<script>
const loremIpsum = document.getElementById("lorem-ipsum")
	fetch("https://baconipsum.com/api/?type=all-meat&paras=200&format=html")
    .then(response => response.text())
    .then(result => loremIpsum.innerHTML = result)
    
const closeBtn = modal.querySelector(".close-area")
	closeBtn.addEventListener("click", e => {
    modal.style.display = "none"
})

modal.addEventListener("click", e => {
    const evTarget = e.target
    if(evTarget.classList.contains("modal-overlay")) {
        modal.style.display = "none"
    }
})

window.addEventListener("keyup", e => {
    if(modal.style.display === "flex" && e.key === "Escape") {
        modal.style.display = "none"
    }
})
</script>		
	
</div>


