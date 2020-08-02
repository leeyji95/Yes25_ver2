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
    <script src="${pageContext.request.contextPath}/JS/financial/financialList.js"></script>
    
    


    
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
<!-- 현제 로그인된 아이디, 부서 정보 -->
<input name="thisLogId" hidden="true"
	value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username}">

<!-- 제목 -->
<h1 class="display-4 d-none d-sm-block" style="padding-top: 50px; text-align: center;">전표 목록</h1>

<!-- 검색 기능 -->
<div id="searchBlock" style="text-align: right; float: right;">
	
	<select id="choiceYearMonth">
		<option value="today" selected="selected">금일</option>
		<option value="year">연별</option>
		<option value="month">월별</option>
	</select>

	<select id="YearMonth"></select>
	
</div>

<!-- 전표 목록  -->
<div id="list">
	<div class="d01">
		<div class="left" id="pageinfo"></div>
	</div>
	
	<div class="clear"></div>
	
	
	<table class="width100">
		
		<thead class="width100">
			<th style="width: 5%; text-align: center;">삭제</th>
			<th style="width: 10%; text-align: center;">날짜</th>
			<th style="width: 15%; text-align: center;">계정과목</th>
			<th style="width: 35%; text-align: center;">적요</th>
			<th style="width: 20%; text-align: center;">금액</th>
			<th style="width: 15%; text-align: center;">결제 진행 사항</th>
		</thead>
		
		<tbody id="tbodyList" class="width100"></tbody>
	</table>
	
	
<!-- 내가 작상한 전표 목록보기 끝 -->	
</div>

<!-- 페이징 -->
<div id="questions-paginator">
	<ul class="pagination" id="pagination"></ul>
</div>

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