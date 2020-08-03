<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- default header name is X-CSRF-TOKEN -->
<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>
<title>도서관리</title>
<link rel="stylesheet"	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/personnel/main.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/personnel/register.css" />	
<link rel="stylesheet"	href="${pageContext.request.contextPath}/CSS/navmenu_template.css" />


</head>
<body>
	<div class="wrap">
        <nav class="nav-bar navbar-inverse fixed-top" role="navigation">
            <div id ="top-menu" class="container-fluid active" style="background-color: #222;">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/personnel/main">Yes25 ERP</a>
                <ul class="nav navbar-nav">        
                    <li class="dropdown movable">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="caret"></span><span class="fa fa-4x fa-child"></span></a>
                        <ul class="dropdown-menu" role="menu">
                         <!-- 관리자인 사원에게만 보이도록한다. -->
                        	 <sec:authorize access="hasRole('ROLE_ADMIN')"> 
										<li><a href="" data-target="#myModal" data-toggle="modal"><span class="fa fa-user"></span>신규사원등록</a></li>
									 </sec:authorize>
                            <li><a href="#"><span class="fa fa-gear"></span>비밀번호변경</a></li>
                            <li class="divider"></li>
                            <li><a href="${pageContext.request.contextPath }/personnel/logout"><span class="fa fa-power-off"></span>Logout</a></li>
                        </ul>
                    </li>
                    
                </ul>
            </div>      
        </nav>
        
        <!-- 왼쪽 메뉴바 -->
        <aside id="side-menu" class="aside" role="navigation">            
              <ul class="nav nav-list accordion">                    
                <li class="nav-header">
                     <div class="link"><i class="fa fa-lg fa-users"></i>인사관리<i class="fa fa-chevron-down"></i></div>
                  <ul class="submenu">
                    <li><a href="${pageContext.request.contextPath }/personnel/main">출퇴근 등록</a></li>  
                    <li><a href="${pageContext.request.contextPath }/personnel/commutelist">근태현황 조회</a></li>  
                  </ul>
                </li>
                
                <li class="nav-header">
                  <div class="link"><i class="fas fa-piggy-bank"></i>재무관리<i class="fa fa-chevron-down"></i></div>
                  <ul class="submenu">
                    <li><a href="${pageContext.request.contextPath }/financial/financialMain.bn">재무메인</a></li>
                  </ul>
                </li>
                
                <li class="nav-header">
                  <div class="link"><i class="fas fa-boxes"></i>물류관리<i class="fa fa-chevron-down"></i></div>
                  <ul class="submenu">
                    <li><a href="${pageContext.request.contextPath }/logistics/inbound">입고관리</a></li>
                    <li><a href="${pageContext.request.contextPath }/logistics/outbound">출고관리</a></li>
                    <li><a href="${pageContext.request.contextPath }/logistics/stock">재고관리</a></li>
                    <li><a href="${pageContext.request.contextPath }/logistics/kpi">현황요약</a></li>
                  </ul>
                </li>  
                
                 <li class="nav-header">
                  <div class="link"><i class="fas fa-book-open"></i>제품관리<i class="fa fa-chevron-down"></i></div>
                  <ul class="submenu">
                    <li><a href="${pageContext.request.contextPath }/products/list">제품관리</a></li>
                  </ul>
                </li>
                
                <li class="nav-header">
                  <div class="link"><i class="fas fa-calculator"></i>구매관리<i class="fa fa-chevron-down"></i></div>
                  <ul class="submenu">
                    <li><a href="${pageContext.request.contextPath }/purchasing/vendor.do">거래처관리</a></li> 
                    <li><a href="${pageContext.request.contextPath }/purchasing/order.do">발주요청</a></li> 
                    <li><a href="${pageContext.request.contextPath }/purchasing/status.do">발주현황</a></li>          
                  </ul>
                </li>
            </ul>
        </aside>
        
        <!--Body content-->
        <div class="content">
          <div class="top-bar">       
            <a href="#menu" class="side-menu-link burger"> 
              <span class='burger_inside' id='bgrOne'></span>
              <span class='burger_inside' id='bgrTwo'></span>
              <span class='burger_inside' id='bgrThree'></span>
            </a>      
          </div>

			<section class="content-inner">
				<div class="col main pt-5 mt-3">
					<h3 class="display-4 d-none d-sm-block">
					<c:choose>
						<c:when test="${empty list || fn:length(list) == 0}">  <!-- list 라는 이름으로 요청 받은 결과들의 배열이 있는가, 혹은 fn 사용해서, length 값으로 없으면 -->
						</c:when>
						<c:otherwise>
							<c:forEach var="dto" items="${list }">
								  ${dto.name} 님 안녕하세요!
							</c:forEach>
						</c:otherwise>
					</c:choose>
					</h3>
					<hr>
					<div class="lead mt-5 d-none d-sm-block">
					
						<!-- 시작________________본문____해당파트___삽입하기(내부분)_________________ -->

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


						<!-- 끝________________본문____해당파트___삽입하기(내부분)_________________ -->
						
					</div>
				</div>
			</section>
		</div> <!-- </div content> --> 
    </div> <!-- </div wrap -->
		 	
	
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
                                                    <input type="text" name="name"  placeholder="Name" required />
                                                </div>
                                            </div>
                                            <div class="col_half">
                                                <!-- 전화번호 -->
                                                <div class="input_field"> <span><i aria-hidden="true" class="fa fa-phone"></i></span>
                                                    <input type="text" name="phone" placeholder="PhoneNumber" required />
                                                </div>
                                            </div>
                                        </div>
                                        <!-- 부서코드 / 이메일 -->
                                        <div class="row clearfix">
                                            <div class="col_half">
                                                <!-- 부서코드 -->
                                                <div class="input_field select_option"> <span><i aria-hidden="true" class="fa fa-sitemap"></i></span>
                                                    <select name="deptno" required>
                                                        <option selected>---부서코드---</option>
                                                        <option value="10">인사</option>
                                                        <option value="20">재무</option>
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
                                                    <input type="email" name="email" placeholder="Email" required />
                                                </div>
                                            </div>
                                        </div>

                                        <!-- 직급코드 / 입사일 -->
                                        <div class="row clearfix">
                                            <div class="col_half">
                                                <!-- 직급코드 -->
                                                <div class="input_field select_option"> <span><i aria-hidden="true" class="fa fa-address-card"></i></span>
                                                    <select name="positionno" required>
                                                        <option selected>---직급코드---</option>
                                                        <option value="300">사원</option>
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
                                                    	<input type="date" id="datepicker" name="hiredate" required style="letter-spacing: 3px; text-align: center;" />
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
                                                        <option selected>---선택하세요---</option>
                                                        <option value="ROLE_MEMBER">일반</option>
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
    
    	
	<script>
//	alert("${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username}님이 로그인 하셨습니다.");
	</script>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>
	
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	<!-- JS, Popper.js -->
	 <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
	 <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
	 <script src="${pageContext.request.contextPath}/JS/navmenu_template.js"></script>
	<script src="${pageContext.request.contextPath}/JS/personnel/main.js"></script>
	<script	src="${pageContext.request.contextPath}/JS/personnel/register.js"></script>
</body>
</html>