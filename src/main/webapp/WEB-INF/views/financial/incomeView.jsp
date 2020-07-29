<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
  <head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>서점ERP시스템</title>
    
    
    
    
    <!-- Latest compiled and minified CSS --> 
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"> 
	
	<!-- jQuery library --> 
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 
	
	<!-- Popper JS --> 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script> 
	
	<!-- Latest compiled JavaScript -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
    
    
    
    <!-- jQuery 선언 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <!-- 내 자바스크립트 -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/JS/financial/main.js"></script>
    
    
    <!-- 내 CSS -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/financial/main.css"/>
      

    
  </head>



<body>
<!-- 공통 헤더 -->
<jsp:include page="nav.jsp" />
        <div class="container-fluid" id="main">
		<div class="row row-offcanvas row-offcanvas-left">
			<jsp:include page="left_menu.jsp" />
			
			 <div class="col main pt-5 mt-3">
<!-- 작업페이지 -->

손익계산서

<table >
	<tr>
		<th>과목</th>
		<th>금액</th>
	</tr>
	
	<tr>
		<td>매출액</td>
	</tr>
	<tr>
		<td>매출원가</td>
	</tr>
	<tr>
		<td>매출총이익</td>
	</tr>
	<tr>
		<td>일반관리비</td>
	</tr>
</table>











<!-- 버튼 -->
<button type="button" class="btnMyself info" style="float: right;"
	onclick="location.href='financialMain.bn'">재무 메인</button>
<br><br><br><br>


<!--------------------------- 공통 헤더, 공통 nav ---------------------------->
</div>
<!--/main col-->
</div>
<!-- 본문, 내가 할 거 끝 -->
</div>
<!--------------------------- 공통 헤더, 공통 nav ---------------------------->
</body>
</html>