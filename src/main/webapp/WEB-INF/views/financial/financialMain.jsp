<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
    
    <!-- 월별 매출 그래프를 사용하기 위한 Chart.js 선언 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
    
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
<!-- 월별 매출 그래프 -->
<h1 class="display-4 d-none d-sm-block" style="padding-top: 50px; text-align: center;">월별 매출 그래프</h1>

<div style="width: 80%; margin: 50px auto 5px auto; height: 500px;">
    <canvas id="monthSales"></canvas>
</div>



<!-- 현제 로그인된 아이디 정보 -->
<input name="thisLogId" hidden="true"
	value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username}">

	
<!-- 결재 목록과 작성 목록을 선택할 수 있는 버튼 -->
<table class="width100" style="margin: 50px 0 20px 0">
<tr class="width100">
	<td class="width50">
		<button id="proceedChoiceBtn" class="width100 infohover" 
			style="padding: 15px; border: none; border-radius: 10px 0 0 0">결제를 기다리고 있는 전표 목록</button>
	</td>
	<td class="width50">
		<button id="writeChoiceBtn" class="width100 info" 
			style="padding: 15px; border: none; border-radius: 0 10px 0 0">작성한 전표 목록</button>
	</td>
</tr>
</table>


<!-- 제목 -->
<h1 id="proceedHeader" class="display-4 d-none d-sm-block">결제를 기다리고 있는 전표 목록</h1>
<h1 id="writeHeader" class="display-4 d-none d-sm-block">작성한 전표 목록</h1>


<!-- 전표 목록  -->
<div id="list">
	<div class="d01">
		<div class="left" id="pageinfo"></div>
	</div>
	
	<div class="clear"></div>
	
	<form id="frmList" name="frmList">
	
	<table class="width100">
		<thead class="width100"></thead>
		
		<tbody id="tbodyList" class="width100"></tbody>
	</table>
	
	</form>
	
	<!-- 전표 수정, 전표 삭제 -->
	<div style="text-align:right; margin: 20px 0;">
		<button type="button" id="updateBtn"
			data-target="#UpdateModal" data-toggle="modal" 
			class="btn btn-lg skyinfo btn-toggle" id="btnUpdate" style="color: white;">전표수정</button>
		<button type="button" id="deleteBtn"
			class="btn btn-default btn-lg skyinfo" style="color: white;" id="btnDel">전표삭제</button>
	</div>

<!-- 내가 작상한 전표 목록보기 끝 -->	
</div>

<!-- 페이징 -->
<div id="questions-paginator">
	<ul class="pagination" id="pagination"></ul>
</div>

<!-- 버튼 -->
<div style="text-align:center; margin: 20px 0;">
<button type="button" data-toggle="modal" data-target="#WriteModal"
	class="btnMyself info btn-toggle" id="btnWrite">전표입력</button>

<!-- 목록보기는 재무부서만 -->
<c:if test="${curDept == 20}">
<button type="button" class="btnMyself info" 
	onclick="location.href='financialDeptList.bn'">목록보기</button>
</c:if>

<button type="button" class="btnMyself info"
	onclick="location.href='incomeView.bn'">손익계산서 확인</button>
<br><br><br><br>


<!--------------------------- 공통 헤더, 공통 nav ---------------------------->
</div>
<!--/main col-->
</div>
<!-- 본문, 내가 할 거 끝 -->
</div>
<!--------------------------- 공통 헤더, 공통 nav ---------------------------->

	
	

<!-- 글작성 모달창 -->
<div id="WriteModal" class="modal fade" 
	data-backdrop="static" data-keyboard="false" role="dialog" tabindex="-1">
	
	<!-- Modal content-->
	<div class="modal-dialog modal-dialog-centered" style="max-width: 80%;">
	<div class="modal-content">
	
	<!-- Modal 헤더 -->
	<div class="modal-header">전표입력</div>
	
	<form id="frmWrite" name="frmWrite" method="post">
		<!-- Modal 텍스트 문구 -->
		<div class= "modal-body" style="max-width: 100%;">
		
				<!-- AJAX 요청에 CSRF 토큰 담아서 보내기용 -->				
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
 
				<div class="statementBlock">
					<span style="float: left; margin-left: 10px;">
						<label for="manager">담당자</label>
						<input id="writeManagerInputNumber" hidden="true" type="number" name="manager" required>
						<input id="writeManagerInputText" type="text" name="manager" disabled required>
						<button type="button" class="btn skyinfo"
							style="color: white; border: 1px solid #4d7cc4!important;"
							onclick="window.open('writeManagerSelect.bn', '사원검색', 'width=500, height=500')">담당자 선택</button>
					</span>
					
					<span style="float: right; position: relative; left: -50%;">
						<i class="fa fa-arrow-right" aria-hidden="true"></i>
					</span>
					
					<span style="float: right;">
						<label for="approver">결재자</label>
						<input id="writeApproverInputNumber" type="number" name="approver" hidden="true" required>
						<input id="writeApproverInputText" type="text" name="approver" disabled required>
						<button type="button" class="btn skyinfo"
							style="color: white; border: 1px solid #4d7cc4!important;"
							onclick="window.open('writeApproverSelect.bn', '사원검색', 'width=500, height=500')">결재자 선택</button><br>
					</span>
				
					<br><br><br><br><br>
					
					<table class="modalTable width100">
						<tr class="width100">
							<th style="width: 15%;"><label for="regDate">날짜</label></th>
							<th style="width: 15%;"><label for="account_uid">계정과목</label></th>
							<th style="width: 50%;"><label for="summary">적요</label></th>
							<th style="width: 20%;"><label for="money">금액</label></th>
						</tr>
						
						<tr class="width100">
							<td style="width: 15%;">
								<input type="text" name="regDate" required>
							</td>
							<td style="width: 20%;">
								<!-- 검색 기능 추가 -->
								<input type="number" name="account_uid" hidden="true" required>
								<input type="text" name="account_name" placeholder="스페이스를 누르면 검색" required>
							</td>
							<td style="width: 45%;">
								<input type="text" name="summary" required>
							</td>
							<td style="width: 20%;">
								<input type="number" name="money" required>
							</td>
						</tr>
						
						<tr class="width100" id="searchList" style="border: none;"></tr>
						
					</table>
				</div>
				 
		</div>
		
		<!-- Modal 푸터 -->
		<footer class="modal-footer">
		  <!-- btn-dismiss 모달 닫는 버튼, data-dismiss="modal" -->
		  <button class="btn-dismiss btnMyself info" type="button" data-dismiss="modal">취소</button>
		  
		  <button class="btnMyself info" data-toggle = "modal" type="submit">등록</button>
		</footer>
	</form>
	</div>
	</div>
</div>

<!-- 글수정 모달창 -->
<div id="UpdateModal" class="modal fade" 
	data-backdrop="static" data-keyboard="false" role="dialog" tabindex="-1">
	
	<!-- Modal content-->
	<div class="modal-dialog modal-dialog-centered" style="max-width: 80%;">
	<div class="modal-content">
	
	<!-- Modal 헤더 -->
	<div class="modal-header">전표수정</div>
	
	<form id="frmUpdate" name="frmUpdate" method="post">
		<!-- Modal 텍스트 문구 -->
		<div class= "modal-body" style="max-width: 100%;">
		
			<!-- AJAX 요청에 CSRF 토큰 담아서 보내기용 -->				
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			
			<div class="statementBlock">
				<span style="float: left; margin-left: 10px;">
					<label for="Umanager">담당자</label>
					<input id="updateManagerInputNumber" type="number" name="Umanager" required hidden="true">
					<input id="updateManagerInputText" type="text" name="UmanagerText" disabled required>
					<button type="button" class="btn skyinfo"
							style="color: white; border: 1px solid #4d7cc4!important;"
							onclick="window.open('updateManagerSelect.bn', '사원검색', 'width=500, height=500')">담당자 선택</button>
				</span>
				
				<span style="float: right; position: relative; left: -50%;">
						<i class="fa fa-arrow-right" aria-hidden="true"></i>
				</span>
				
				<span style="float: right;">
					<label for="Uapprover">결재자</label>
					<input id="updateApproverInputNumber" type="number" name="Uapprover" required hidden="true">
					<input id="updateApproverInputText" type="text" name="UapproverText" disabled required>
					<button type="button" class="btn skyinfo"
							style="color: white; border: 1px solid #4d7cc4!important;"
							onclick="window.open('updateApproverSelect.bn', '사원검색', 'width=500, height=500')">결재자 선택</button><br>
				</span>
	
				<br><br><br><br><br>
					
				<table class="modalTable width100">
					<tr>
						<th><label for="UregDate">날짜</label></th>
						<th><label for="Uaccount_uid">계정과목</label></th>
						<th><label for="Usummary">적요</label></th>
						<th><label for="Umoney">금액</label></th>
					</tr>
					
					<tr>
						<td>
							<input type="text" name="UregDate" required>
						</td>
						<td>
							<!-- 검색 기능 추가 -->
							<input type="number" name="Uaccount_uid" hidden="true" required>
							<input type="text" name="Uaccount_name" placeholder="스페이스를 누르면 검색" required>
						</td>
						<td>
							<input type="text" name="Usummary" required>
						</td>
						<td>
							<input type="number" name="Umoney" required>
						</td>
					</tr>
					
					<tr id = "UsearchList" style="border: none;"></tr>
					
				</table>
			</div>
			
			<!-- 전표번호 -->
			<input type="number" name="Ustmt_uid" hidden="true" required><br>
			
			<label for="Uwriter" hidden="ture">작성자</label>
			<input type="number" name="Uwriter" required hidden="true"><br>
		</div>
		
		<!-- Modal 푸터 -->
		<footer class="modal-footer">
		  <!-- btn-dismiss 모달 닫는 버튼, data-dismiss="modal" -->
		  <button class="btn-dismiss btnMyself info" type="button" data-dismiss="modal">취소</button>
		  
		  <button class="btnMyself info" data-toggle = "modal" type="submit">수정</button>
		</footer>
	</form>
	</div>
	</div>
</div>
</div>

		


</body>
</html>