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

		</style>
<script>

</script>
</head>
<body>
<table width="70%" class="table01">
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
                            <td><input type="button" value="수정" onclick="location.href='/listEdit?id=${vo.id }'">/<input type="button" id="listDel" value="삭제" onclick="location.href='/listDel?id=${vo.id }'"></td>
                       
                        </tr>
                     </c:forEach>
                     
                    </tbody>    
                </table>
       
</body>
</html>