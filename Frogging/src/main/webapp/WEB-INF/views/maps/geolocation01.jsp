<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src = "https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Black+And+White+Picture&family=Black+Han+Sans&family=Cute+Font&family=Do+Hyeon&family=Dokdo&family=East+Sea+Dokdo&family=Gaegu&family=Gamja+Flower&family=Gothic+A1&family=Gugi&family=Hi+Melody&family=Jua&family=Kirang+Haerang&family=Nanum+Brush+Script&family=Nanum+Gothic&family=Nanum+Gothic+Coding&family=Nanum+Myeongjo&family=Nanum+Pen+Script&family=Noto+Sans+KR&family=Noto+Serif+KR&family=Poor+Story&family=Single+Day&family=Song+Myung&family=Stylish&family=Sunflower:wght@300&family=Yeon+Sung&display=swap" rel="stylesheet">  
<script
	src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xxc6985a9bef1d438f939779b9bf5e79d8"></script>
<script>
	var check = "${course.course_no}";
	if(check == -1){
		alert("해당 코스는 없습니다.");
		history.go(-1);
	} else {
		var courseType = "${course.type}";
		var detail_arr = new Array();
			<c:forEach items = "${courseDetail}" var = "courseDetail">
				detail_arr.push({
					course_no : "${courseDetail.course_no}",
					waypoint : "${courseDetail.waypoint}",
					lat : "${courseDetail.lat}",
					log : "${courseDetail.log}",
					addr : "${courseDetail.addr}"
				});
			</c:forEach>
	}
</script>
<script src="/js/watch_position.js" ></script>
<link rel = "stylesheet" href = "/js_css/style.css" type = "text/css">
<style>

.container{
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 24px;
}
#checkCourseForm{
	height: 40px;
}
#amount_trash{
	height: 40px;
    width: 180px;
}
#sort{
	height: 40px;
    width: 180px;
}
.ploggingSave-btn{
	height: 50px;
    width: 200px;
    background-color: #2fb86a;
    border : 1px solid white;
    border-radius:5px;
    color: white;
    font-weight: bold;
    font-size: 22px;
    margin: 0 10px;
    font-family: 'Noto Sans KR', sans-serif;
}
.ploggingStart-btn, .ploggingEnd-btn{
    height: 100px;
    width: 180px;
    background-color: #2fb86a;
    border : 1px solid white;
    border-radius:5px;
    color: white;
    font-weight: bold;
    font-size: 24px;
    margin: 0 10px;
    font-family: 'Noto Sans KR', sans-serif;
}
@media screen and (min-width:152px) and (max-width:1024px){
	.p_container1{
		    min-height: 100%;
   			position: relative;
	}
	.map_wrap3{
		height:70%;
	}
	#map_div{
		height:700px;
	}

	.ploggingStart-btn, .ploggingEnd-btn{
	    height: 150px;
	    width: 150px;
	    background-color: #2fb86a;
	    border : 1px solid white;
	    border-radius:5px;
	    color: white;
	    font-weight: bold;
	    font-size: 18px;
	    text-align:center;
	    margin: 0 10px;
	    font-family: 'Noto Sans KR', sans-serif;
	}
}

</style>
</head>
<body onload="initTmap();">
<div class="p_container" >
	<div id="map_wrap" class="map_wrap3">
			<div id="map_div"></div>
	</div>
	<br>
	<div class = "container">
	    <form method = "post" id = "checkCourseForm">
	    	쓰레기 처리량 : <input type = "text" id = "amount_trash" name = "amount_trash">
	    	파티번호 : <input type = "text" id = "sort" name = "sort">
	    	<input type = "submit" value = "이동한 코스 저장" class="ploggingSave-btn">
	    </form>
	    <br>
	<div style="margin: 0 auto;  text-align:center;  justify-content: space-between; float:center; width:80%;">
		<input type = "button" value = "출발지 동기화" class="ploggingStart-btn" onclick = "synchronizeStart();">
	    <input type = "button" value = "플로깅 시작" class="ploggingStart-btn" onclick = "startChecking();">
	    <input type = "button" value="플로깅 종료" class="ploggingEnd-btn" onclick = "endChecking();" />
	</div>
	</div>
</div>	
</body>
</html>