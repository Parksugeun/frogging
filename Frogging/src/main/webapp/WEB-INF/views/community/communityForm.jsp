<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="//cdn.ckeditor.com/4.19.1/full/ckeditor.js"></script>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link rel="stylesheet" href="/css/p_style.css" type="text/css"/>
<link href="https://fonts.googleapis.com/css2?family=Black+And+White+Picture&family=Black+Han+Sans&family=Cute+Font&family=Do+Hyeon&family=Dokdo&family=East+Sea+Dokdo&family=Gaegu&family=Gamja+Flower&family=Gothic+A1&family=Gugi&family=Hi+Melody&family=Jua&family=Kirang+Haerang&family=Nanum+Brush+Script&family=Nanum+Gothic&family=Nanum+Gothic+Coding&family=Nanum+Myeongjo&family=Nanum+Pen+Script&family=Noto+Sans+KR&family=Noto+Serif+KR&family=Poor+Story&family=Single+Day&family=Song+Myung&family=Stylish&family=Sunflower:wght@300&family=Yeon+Sung&display=swap" rel="stylesheet">
<style>
.cke_screen_reader_only {
	position: inherit;
}
</style>
<script>
	$(function(){
		CKEDITOR.replace("content");
		
		$("#p_communityForm").submit(function(){
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
	<br><h1 class="p_title">커뮤니티 글쓰기</h1>
	<form method="post" action="/community/communityFormOk" id="p_communityForm">
	<div id="p_textwrite">
		<ul>
			<li>제목</li>
			<li><input type="text" name="subject" id="p_subject"/></li>
			<li><textarea name="content" id="p_content"></textarea></li>
			<li><input type="submit" value="글등록" id="p_textok" style="margin:10px;"/></li>
		</ul>
	</div>	
	</form>		
</div>