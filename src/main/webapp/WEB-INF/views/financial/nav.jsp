<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>nav바</title>
<meta name="description"
	content="A Bootstrap 4 admin dashboard theme that will get you started. The sidebar toggles off-canvas on smaller screens. This example also include large stat blocks, modal and cards. The top navbar is controlled by a separate hamburger toggle button." />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="generator" content="Codeply">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/CSS/styles.css" />
</head>
<body>
	<nav class="navbar fixed-top navbar-expand-md navbar-dark bg-primary mb-3">
		<div class="flex-row d-flex">
			<button type="button" class="navbar-toggler mr-2 "
				data-toggle="offcanvas" title="Toggle responsive left sidebar">
				<span class="navbar-toggler-icon"></span>
			</button>
			<a class="navbar-brand" href="#"
				title="Free Bootstrap 4 Admin Template">YES25 서점ERP시스템</a>
		</div>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#collapsingNavbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="navbar-collapse collapse" id="collapsingNavbar">
			<ul class="navbar-nav">
				<li class="nav-item active"><a class="nav-link" href="${pageContext.request.contextPath }/personnel/main">Home<span class="sr-only">Home</span></a></li>
<!-- 				<li class="nav-item"><a class="nav-link">Link</a></li> -->
			</ul>
			<ul class="navbar-nav ml-auto">
				<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath }/personnel/logout">Logout</a></li>
				<li class="nav-item"><a class="nav-link" href="" data-target="#myModa2" data-toggle="modal">비밀번호변경</a></li>
				
				
			<sec:authorize access="hasRole('ROLE_ADMIN')"> 
				<li class="nav-item">
					<a class="nav-link" href="" data-target="#myModal" data-toggle="modal">신규사원등록</a>
				</li>
			</sec:authorize>
				
				
			</ul>
		</div>
	</nav>
</body>
</html>
