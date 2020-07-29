<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
    
<c:choose>
	<c:when test="${result == 0 }">
	<script>
		alert('수정 실패');
		history.back();
	</script>
	</c:when>
	<c:otherwise>
	
		<c:choose>
			<c:when test="${proceed == 4 }">
			<script>
				alert('승인 거절 처리되었습니다.');
				location.href = "financialMain.bn";
			</script>
			</c:when>
			<c:otherwise>
			<script>
				alert('승인 처리되었습니다.');
				location.href = "financialMain.bn";
			</script>
			</c:otherwise>
		</c:choose>
		
	</c:otherwise>
</c:choose>