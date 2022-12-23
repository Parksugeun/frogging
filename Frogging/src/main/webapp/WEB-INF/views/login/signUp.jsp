<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
		<link rel="stylesheet" href="/css/k_style.css" type="text/css"/>
		<link rel="preconnect" href="https://fonts.gstatic.com">
		<link href="https://fonts.googleapis.com/css2?family=Black+And+White+Picture&family=Black+Han+Sans&family=Cute+Font&family=Do+Hyeon&family=Dokdo&family=East+Sea+Dokdo&family=Gaegu&family=Gamja+Flower&family=Gothic+A1&family=Gugi&family=Hi+Melody&family=Jua&family=Kirang+Haerang&family=Nanum+Brush+Script&family=Nanum+Gothic&family=Nanum+Gothic+Coding&family=Nanum+Myeongjo&family=Nanum+Pen+Script&family=Noto+Sans+KR&family=Noto+Serif+KR&family=Poor+Story&family=Single+Day&family=Song+Myung&family=Stylish&family=Sunflower:wght@300&family=Yeon+Sung&display=swap" rel="stylesheet">
		
		<style>
		.nickchk1{
			display:none;
		}
		.nickchk2{
			display:none;
		}
		.nickchk3{
			display:none;
		}
		.nickchk4{
			display:none;
		}
		</style>
	</head>
<script>
function maxLengthChk(object){
    if (object.value.length > object.maxLength){
      object.value = object.value.slice(0, object.maxLength);
    }    
  }
</script>
<script>

$(document).ready(function(){      
	var pattern_blank = /[\s]/g;//공백
	var pattern_num = /[0-9]/;	// 숫자     	
	var pattern_eng = /[a-zA-Z]/;	// 문자     	
	var pattern_spc = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/g; // 특수문자    	
	var pattern_kor = /[ㄱ-ㅎ|ㅏ-ㅣ]/; // 한글체크
	var check=0;


	//유효성 검사
	$("#sign").submit(function(){
		
		//문자열에 공백이 있는 경우
		if(pattern_blank.test($("#nickname").val()) == true){
		    alert('닉네임에 공백을 사용할수없습니다.');
		    return false;
		}
		//ㅎㄱㅁㅎㅁㄱㅎㅁ 자음모음이있는경우
		if(pattern_kor.test($("#nickname").val()) == true){
		    alert('닉네임에 특수문자를 사용할수없습니다');
		    return false;
		}
		
		//특수문자가 있는 경우
		if(pattern_spc.test($("#nickname").val()) == true){
		    alert('닉네임에 특수문자를 사용할수없습니다');
		    return false;
		}
		if($("#nickname").val()==""){
			alert("닉네임 입력하세요..");
			return false;
		}
		if($("#nickname").val().length<2 || $("#nickname").val().length>8){
			alert("닉네임을 2~8글자 사이로 입력해주세요");
			return false;
		}
		if($("#height").val()==""){
			alert("키를 입력하세요.");
			return false;
		}
		if(check==0){
			alert("닉네임 확인바람");
			return false;
		}
		return true;
	});
	
	$('#nickname').on("propertychange change keyup paste input", function() {
		var nickname = $('#nickname').val();
		var data = {nickname : nickname}
		$.ajax({
			type : "post",
			url : "/login/nicknameCheck",
			data : data,
			success : function(result){
				// 닉네임 중복
				if(result !='success'){
					 check=0;
					 $('.nickchk1').css("display","inline-block");
					 $('.nickchk2').css("display",'none');
		             $('.nickchk3').css("display",'none');
		             $('.nickchk4').css("display",'none');
		        //공백 및 특수문자
				}else if(nickname.match(pattern_blank) || nickname.match(pattern_spc) || nickname.match(pattern_kor)){
					 check=0;
					 $('.nickchk2').css("display","inline-block");
					 $('.nickchk1').css("display",'none');
		             $('.nickchk3').css("display",'none');
		             $('.nickchk4').css("display",'none');
		        //닉네임 입력칸 비어있을때 
				}else if(nickname.length==0){
					 check=0;
		             $('.nickchk1').css("display",'none');
		             $('.nickchk2').css("display",'none');
		             $('.nickchk3').css("display",'none');
			         $('.nickchk4').css("display",'none');
		        }else if(nickname.length < 2 && nickname.length>8){
		        	 check=0;
		        	 $('.nickchk3').css("display","inline-block");
		             $('.nickchk2').css("display",'none');
		             $('.nickchk1').css("display",'none');
			         $('.nickchk4').css("display",'none');
		        }else{
		        	 check=1;
		        	 $('.nickchk4').css("display","inline-block");
		             $('.nickchk1').css("display",'none');
		             $('.nickchk2').css("display",'none');
			         $('.nickchk3').css("display",'none');
		        }
		
				}
		
		});
	});

});
	
</script>


<body class="k_body_b" style="font-family: 'Noto Sans KR', sans-serif;">
<div class="k_bg">
<div class="k_wrapper">
		<span>&nbsp</span>
		<div class="k_section_title_s" style="">
					<div>[회원가입] - 사용자 정보 입력</div>
		</div>
<div class="k_agree_wrapper">
<div id="#">
	<%-- <h1>회원가입</h1> --%>
	<div id="#">
		<%-- <h2>작성자정보<span> --%>
	</div>
	<form method="post" action="/signUpOk" id="sign">
		<div id="#">
			<ul class="k_user_info">
				<li>아이디</li>
					<li><input type="text" name="id" id="id" value="${vo.id }" readonly/></li>
				<li>이름</li>
					<li><input type="text" name="name" id="name" value="${vo.name }" readonly/></li>
				<li>닉네임</li>
					<li><input type="text" name="nickname" id="nickname" />
					<li><span class="nickchk1">이미 사용중인 닉네임입니다.</span></li>
					<li><span class="nickchk2">닉네임에 공백 및 특수문자를 사용할 수 없습니다.</span></li>
					<li><span class="nickchk3">닉네임은2~8글자 사이여야합니다.</span></li>
					<li><span class="nickchk4">사용 가능한 닉네임 입니다.</span></li>
				<li id="sex">성별</li>
				<li >
					<select name="sex">
						<option id="sex" value=1>남</option>
						<option id="sex" value=2>여</option>
					</select>
				</li>
				<li>키(cm)</li>
				<li><input type="number" name="height" id="height" maxlength="3" oninput="maxLengthChk(this)" /></li>
			</ul>
			<input type="submit" value="가입하기" class="k_user_btn"/>
		</div>
	</form>
</div>
</div>
</div>
</div>
</body>
</html>