<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- default header name is X-CSRF-TOKEN -->
<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>
<title>사원검색</title>

<!-- jQuery 선언 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/a076d05399.js"></script>
<script src="${pageContext.request.contextPath}/JS/financial/main.js"></script>

<style type="text/css">

button {
	text-align: center;
	width: 100%;
	border: none;
	background-color: white;
	padding: 10px 0;
}
button:hover {
	background: #007bff!important;
	color: white;
}

</style>


</head>
<body>
<div class="col main pt-5 mt-3">
<h1 class="display-4 d-none d-sm-block" 
	style="text-align: center;">결재자를 선택해주세요.</h1>
<c:choose>
	<c:when test="${empty list || fn:length(list) == 0}">
등록된 사원이 없습니다.
	</c:when>
<c:otherwise>
<table style="width: 100%;">
<c:forEach var="dto" items="${list}">
	<tr style="width: 100%;">
		<td style="width: 100%;">
			<c:choose>
			<c:when test="${dto.deptno == 10}">
				<button class="listValue" 
					value="${dto.username}">${dto.username}&nbsp;${dto.name}&nbsp;인사팀</button>
			</c:when>
			<c:when test="${dto.deptno == 20}">
				<button class="listValue" 
					value="${dto.username}">${dto.username}&nbsp;${dto.name}&nbsp;재무팀</button>
			</c:when>
			<c:when test="${dto.deptno == 30}">
				<button class="listValue" 
					value="${dto.username}">${dto.username}&nbsp;${dto.name}&nbsp;제품팀</button>
			</c:when>
			<c:when test="${dto.deptno == 40}">
				<button class="listValue" 
					value="${dto.username}">${dto.username}&nbsp;${dto.name}&nbsp;물류팀</button>
			</c:when>
			<c:when test="${dto.deptno == 50}">
				<button class="listValue" 
					value="${dto.username}">${dto.username}&nbsp;${dto.name}&nbsp;구매팀</button>
			</c:when>
			</c:choose>
		</td>
	</tr>
</c:forEach>
</table>
</c:otherwise>
</c:choose>




<!-- 실질적으로 부모창으로 값을 보내는 곳 -->
<form name="frmMember">
<input type="Number" id="usernameSelect" hidden="true">
<input type="text" id="nameSelect" hidden="ture">

<input type="button" id="sendBtn" type="button" onclick="sendTxt()" hidden="true">
</form>

<script type="text/javascript">

	$(".listValue").click(function() {
		// 기존 버튼 값 선택 후
		$("#usernameSelect").val($(this).val());
		$("#nameSelect").val($(this).text());
		
		// 강제로 종료 및 값 세팅
		$("#sendBtn").trigger("click");
	});
	
	function sendTxt(){
		window.opener.document.frmUpdate.updateApproverInputNumber.value = document.frmMember.usernameSelect.value;
		window.opener.document.frmUpdate.updateApproverInputText.value = document.frmMember.nameSelect.value;
		self.close();
	}
</script>

</div>
</body>
</html>