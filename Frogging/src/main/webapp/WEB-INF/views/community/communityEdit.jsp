<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="//cdn.ckeditor.com/4.19.1/full/ckeditor.js"></script>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Black+And+White+Picture&family=Black+Han+Sans&family=Cute+Font&family=Do+Hyeon&family=Dokdo&family=East+Sea+Dokdo&family=Gaegu&family=Gamja+Flower&family=Gothic+A1&family=Gugi&family=Hi+Melody&family=Jua&family=Kirang+Haerang&family=Nanum+Brush+Script&family=Nanum+Gothic&family=Nanum+Gothic+Coding&family=Nanum+Myeongjo&family=Nanum+Pen+Script&family=Noto+Sans+KR&family=Noto+Serif+KR&family=Poor+Story&family=Single+Day&family=Song+Myung&family=Stylish&family=Sunflower:wght@300&family=Yeon+Sung&display=swap" rel="stylesheet">
<script>
	$(function(){
		CKEDITOR.replace("content");
		
		$("#communityFrm").submit(function(){
			if($("#p_subject").val()==""){
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
</script>
<div class="p_container">
	<h1 class="p_title">커뮤니티 글수정</h1>
		<div id="p_writeedit">
			<form method="post" action="/community/communityEditOk" id="communityFrm">
				<input type="hidden" name="no" value="${vo.no}"/>
					<ul>
						<h5><li>제목</li>
						<li><input type="text" name="subject" id="p_subject" value="${vo.subject}" size="200"/></li>
						<li>글내용</li>
						<li><textarea name="content" id="p_content">${vo.content}</textarea></li></h5>
						<li><input type="submit" value="글수정" id="p_edit" style="font-family: 'Noto Sans KR', sans-serif;"/></li>
					</ul>
			</form>	
		</div>	
</div>