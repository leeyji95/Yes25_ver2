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
<title>도서관리</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/personnel/main.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/personnel/register.css" />	


</head>
<body>
	<jsp:include page="nav.jsp" />

	<div class="container-fluid" id="main">
		<div class="row row-offcanvas row-offcanvas-left">
			<jsp:include page="left_menu.jsp" />

			<!-- 본문, 내가 할 거 -->
			<div class="col main pt-5 mt-3">
			 
				<h1 class="display-3 d-none d-sm-block"> ${sessionScope.username } 님의 근태현황</h1>
				<hr>
				 <div class="lead mt-5 d-none d-sm-block">
					<!-- 물결 슬라이드 컨테이너 -->
					<div class="container">
						<div class="cont">
							<div class="app">
								<div class="app__bgimg">
									<div class="app__bgimg-image app__bgimg-image--1"></div>
								</div>
								<div class="app__img">
									<img onmousedown="return false"
										src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/537051/whiteTest4.png"
										width="1050px" height="2000px" alt="city" />
								</div>

								<div class="app__text app__text--1">
									<div class="app__text-line app__text-line--4">
										<p id="changetext" style="font-size: 26px; margin: 0px; padding: 5px 0;">
											버튼을 눌러 출근을 기록하세요</p>
										<!-- 출근/ 퇴근 버튼-->
										<div class="btn-group btn-group-toggle" data-toggle="buttons">
											<div class="top-buttons">
												<button class="goWork top-active-button">출근</button>
												<button class="outWork">퇴근</button>
											</div>
										</div>
									</div>

									<!-- date 박스 -->
									<div class="box app__text-line app__text-line--3">
										<div class="date">
											<div id="daymonthyear"></div>
										</div>
										<div class="time">
											<div id="hourminutesecond"></div>
										</div>
									</div>
								</div>

							</div>
						</div>
					</div>
					<!-- 끝! 물결 슬라이드 -->
				</div>
			</div>
			<!--/main col--><!-- 본문, 내가 할 거 끝 -->
		</div>
		<!-- /row row-offcanvas row-offcanvas-left -->
	</div>
	
	
		 <!-- Modal -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="myModalLabel">신규사원등록</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                        <span class="sr-only">Close</span>
                    </button>
                </div>
                <div class="modal-body">



                    <div class="form_wrapper">
                        <div class="form_container">
                            <!-- <div class="title_container">
                            <h2>신규사원등록</h2>
                        </div> -->
                            <div class="row clearfix">
                                <div class="">
                                
                                	<!-- ///////   F___O___R____M____태___그  ///// -->
                                    <form method="post" id="frmWrite" >
                                    <input type="hidden"name="${_csrf.parameterName}"value="${_csrf.token}"/>
                                        <!-- 이름/전화번호 -->
                                        <div class="row clearfix">
                                            <div class="col_half">
                                                <!-- 이름 -->
                                                <div class="input_field"> <span><i aria-hidden="true" class="fa fa-user"></i></span>
                                                    <input type="text" name="name" value="yeji" placeholder="Name" required />
                                                </div>
                                            </div>
                                            <div class="col_half">
                                                <!-- 전화번호 -->
                                                <div class="input_field"> <span><i aria-hidden="true" class="fa fa-phone"></i></span>
                                                    <input type="text" name="phone" value="01022234400" placeholder="PhoneNumber" required />
                                                </div>
                                            </div>
                                        </div>
                                        <!-- 부서코드 / 이메일 -->
                                        <div class="row clearfix">
                                            <div class="col_half">
                                                <!-- 부서코드 -->
                                                <div class="input_field select_option"> <span><i aria-hidden="true" class="fa fa-sitemap"></i></span>
                                                    <select name="deptno" required>
                                                        <option>---부서코드---</option>
                                                        <option value="10">인사</option>
                                                        <option value="20" selected>재무</option>
                                                        <option value="30">제품</option>
                                                        <option value="40">물류</option>
                                                        <option value="50">구매</option>
                                                    </select>
                                                    <div class="select_arrow"></div>
                                                </div>
                                            </div>
                                            <div class="col_half">
                                                <!-- 이메일 -->
                                                <div class="input_field"> <span><i aria-hidden="true" class="fa fa-envelope"></i></span>
                                                    <input type="email" name="email" value="leeyji95@naver.com" placeholder="Email" required />
                                                </div>
                                            </div>
                                        </div>

                                        <!-- 직급코드 / 입사일 -->
                                        <div class="row clearfix">
                                            <div class="col_half">
                                                <!-- 직급코드 -->
                                                <div class="input_field select_option"> <span><i aria-hidden="true" class="fa fa-address-card"></i></span>
                                                    <select name="positionno" required>
                                                        <option>---직급코드---</option>
                                                        <option value="300" selected>사원</option>
                                                        <option value="400">대리</option>
                                                        <option value="500">과장</option>
                                                        <option value="600">부장</option>
                                                        <option value="700">대표</option>
                                                    </select>
                                                    <div class="select_arrow"></div>
                                                </div>
                                            </div>
                                            <div class="col_half">
                                                <!-- 입사일 -->
                                                <div class="input_field"> <span class="reg">입사일</span>
                                                	<label>
                                                    	<input type="date" id="datepicker" name="hiredate" value="2020-08-10" required style="letter-spacing: 3px; text-align: center;" />
                                                    </label>
                                                    
                                                    <script type="text/javascript">
                                                    $('#datepicker').change(function(){
                                                        $(this).attr('value', $('#datepicker').val());
                                                    });
                                                    </script>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- 관리자여부 -->
                                        <div class="row clearfix">
                                            <div class="col_half">
                                                <!-- 관리자여부 -->
                                                <div class="input_field select_option"> <span><i aria-hidden="true" class="fa fa-address-card"></i></span>
                                                    <select name="admin" required>
                                                        <option>---선택하세요---</option>
                                                        <option value="ROLE_MEMBER" selected>일반</option>
                                                        <option value="ROLE_ADMIN">관리자</option>
                                                    </select>
                                                    <div class="select_arrow"></div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- 등록 완료 제출 버튼 -->
                                        <input class="button" type="submit" value="Register"  />
                                    </form>
                                    <!-- ///////   F___O___R____M____끝   ///// -->
                                    
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

            </div>
        </div>
    </div>
<%-- 	<sec:authentication property="principal.username" var="username"/> --%>
	<c:out value="${sessionScope.username }"/><br>
	
	
	
	<%--
		UserDTO userdto = (UserDTO)request.getSession(false).getAttribute("userdto");
		System.out.println(userdto);
	
		System.out.println(request.getSession().getAttribute("username"));
	
	--%>
<!-- 		<script>alert("${username} ")</script> -->
		
    	
    <% 
     	String username = (String)session.getAttribute("username");
    	System.out.println("username : " + username);
    %>
    	<c:choose>
			<c:when test="${empty list || fn:length(list) == 0}">  <!-- list 라는 이름으로 요청 받은 결과들의 배열이 있는가, 혹은 fn 사용해서, length 값으로 없으면 -->
			</c:when>
			<c:otherwise>
				<c:forEach var="dto" items="${list }">
				<c:out value="${list }"/><br>
				<tr>
					<td>dto.username ::::::  ${dto.username}</td><br>
<%-- 					<td><a href="view.do?uid=${dto.uid}">${dto.subject}</a></td> --%>
					<td>dto.name ::::   ${dto.name}</td><br>
					<td>dto.phone ::::: ${dto.phone}</td><br>
					<td>dto.email ::::  ${dto.email}</td><br>
					<td>dto.deptno ::::  ${dto.deptno}</td><br>
					<td>dto.positionno ::::  ${dto.positionno}</td><br>
				</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
    	
    	
	<script>
//	alert("${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username}님이 로그인 하셨습니다.");
	</script>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>
	
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/JS/personnel/main.js"></script>
	<script	src="${pageContext.request.contextPath}/JS/personnel/register.js"></script>
</body>
</html>