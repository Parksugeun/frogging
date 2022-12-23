
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
		<link rel="stylesheet" href="/js_css/style.css" type="text/css"/>
		<style>
			h1{
				text-align:center;
			}
			.edit-btn{
				text-align: center;
				margin-top:20px;
				margin-bottom:20px;
			}
			
			.edit-btn > .edit-btn1{
				width:100px;
				height:40px;
				border : 0px;
   			    border-radius:5px;
    			color: white;
   			    font-weight: bold;
				border-color:#191919;color:#fff;
				background-color:#017935;
			}
			.edit-btn > .edit-btn2{
				width:100px;
				height:40px;
				border : 0px;
  			    border-radius:5px;
                color: white;
                font-weight: bold;
	            border-color:#191919;color:#fff;
	            background-color:#333;
			}
		</style>
		<script>
		
		</script>
	</head>
<body>
<h1 style="margin-top:40px">회원정보수정</h1>
<form method="post" action="/admin/editProfile">
			<table width="50%" class="table01" style="width:70%;margin:20px auto;">
                    <colgroup>
                        <col width="40%" />
                        <col width="60%" />
                    </colgroup>
                        <tr>
                            <th>아이디(이메일)</th>
                            <th style="text-align:left;"><input style="width:100%" type="text" name="id" value="${vo.id}" readonly }></th>
                        </tr>  
                         <tr>
                            <th>이름</th>
                            <th style="text-align:left;">${vo.name }</th>
                        </tr>
                        <tr>
                            <th>닉네임</th>
                            <th style="text-align:left;">${vo.nickname }</th>
                        </tr>
                        <tr>
                            <th>성별</th>
                            <c:if test="${vo.sex==1 }"><th style="text-align:left;">남</th></c:if>
                            <c:if test="${vo.sex==2 }"><th style="text-align:left;">여</th></c:if>
                        </tr>
                        <tr>
                            <th>키</th>
                            <th style="text-align:left;">${vo.height } cm</th>
                        </tr>
                        <tr>
                            <th>상태</th>
                          	<c:if test="${vo.restriction==0 }">
                          		<th style="text-align:left;">
                          			<select name="restriction" style="width:100%">
                          				<option selected value=0>정상</option>
                          				<option value=1>불량</option>
                          			</select>
                          		</th>
                          	</c:if>
                            <c:if test="${vo.restriction==1 }">
                          		<th style="text-align:left;">
                          			<select name="restriction" style="width:100%">
                          				<option selected value=1>불량</option>
                          				<option value=0>정상</option>
                          			</select>
                          		</th>
                          	</c:if>
                        </tr>
                        
                </table>
                <div class="edit-btn">
               	 <input type="submit" value="수정하기" class="edit-btn1">&nbsp<input type="button" value="뒤로가기" onclick="history.back()" class="edit-btn2">
                </div>
                </form>
</body>
</html>