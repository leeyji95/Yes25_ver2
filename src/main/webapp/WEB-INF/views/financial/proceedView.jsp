<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:choose>

	<c:when test="${empty list || fn:length(list) == 0 }">
			<script>
				alert("해당 정보가 삭제되거나 없습니다");
				history.back();
			</script>
	</c:when>
	
<c:otherwise>

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
    <script src="${pageContext.request.contextPath}/JS/financial/financialView.js"></script>
    
    
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
<div style="margin-top: 50px; font-size: 25px;">
[전표번호] ${list[0].stmt_uid }<br>
</div>

<div style="text-align: center; font-size: 30px; margin-top: 50px;">
<!-- 담당 라인(1) , 결제 라인(2), 최종 승인(3), 승인 거절(4) -->
<c:choose>
<c:when test="${list[0].proceed == 1}">
담당자 결재 대기 : ${list[0].manager }
</c:when>
<c:when test="${list[0].proceed == 2}">
결재자 결재 대기 : ${list[0].approver }
</c:when>
</c:choose>
<br><br>
작성자 : ${list[0].writer }
&nbsp;<span><i class="fa fa-arrow-right" aria-hidden="true"></i></span>&nbsp; 
담당자 : ${list[0].manager }
&nbsp;<span><i class="fa fa-arrow-right" aria-hidden="true"></i></span>&nbsp; 
결제자 : ${list[0].approver }<br>
</div>


<table id="viewTable" style="width: 80%; margin: 100px auto 10px auto;">
<tr class="width100">
	<th>날짜</th>
	<th>계정과목</th>
	<th>적요</th>
	<th>금액</th>
</tr>
<tr>
	<td>${list[0].regDate }</td>
	<td id="accountNameUid">
	<input name="accountUid" value="${list[0].account_uid }" hidden="true">
	</td>
	<td>${list[0].summary }</td>
	<td>${list[0].money }</td>
</tr>
</table>
<br><br><br><br>


<div style="text-align: center; margin: 20px 0;">
<form action="financialupdateOk.bn" style="display: inline;">
	<input name="stmtUid" value="${list[0].stmt_uid }" hidden="true">
	<input name="proceed" value="${list[0].proceed + 1}" hidden="true">
	<button class="btnMyself info">승인</button>
</form>

<form action="financialupdateOk.bn" style="display: inline;">
	<input name="stmtUid" value="${list[0].stmt_uid }" hidden="true" >
	<input name="proceed" value="4" hidden="true" >
	<button class="btnMyself info">승인거절</button>
</form>

<button class="btnMyself info" 
	onclick="location.href='financialMain.bn'">재무관리 메인</button>
</div>
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

</c:otherwise>
</c:choose>