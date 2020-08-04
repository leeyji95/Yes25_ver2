<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>
<title>도서관리</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/><link rel="stylesheet"	href="${pageContext.request.contextPath}/CSS/navmenu_template.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/personnel/commutelist.css" />
<style type="text/css">
#title {
	font-size: 38px;
	font-weight: bold;
	padding: 15px 20px;
	letter-spacing: 5px;
}
</style>
</head>
<body>

    
    	<div class="wrap">
         <nav class="nav-bar navbar-inverse fixed-top" role="navigation">
            <div id ="top-menu" class="container-fluid active" style="background-color: #222;">
                <a class="navbar-brand" href="#">Yes25 ERP</a>
                <ul class="nav navbar-nav">        
                    <li class="dropdown movable">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="caret"></span><span class="fa fa-4x fa-child"></span></a>
                        <ul class="dropdown-menu" role="menu">
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
						<!-- 시작________________본문____해당파트___삽입하기(내부분)_________________ -->

														<!-- 본문, 내가 할 거 -->
			<div class="col main pt-5 mt-3">
				<div class="div_title">
					<h1 class="display-4 d-none d-sm-block" id="title">근태현황</h1>
				</div>
				 <hr>
                <div class="lead mt-5 d-none d-sm-block">
                    <!-- DatePicker 영역 -->
                    <div id="date-picker-section" class="container">
                    
                        <div id="date-picker-container">
                        
                            <!-- date 선택  -->
                            <div id="date-picker-dates">
                                <!-- 근태조회 text -->
                                <span style="display: block; padding: 20px; letter-spacing: 4px;">근태조회</span>
								
								<!-- selected  날짜 들어가는 곳 -->
								<form id="frm">
                                	<div id="date-picker-date-first" class="date-picker-date date1"></div>
                                 	<div class="date-picker-date date2"></div>
									 <input type=hidden name="startDate" id="startDate" />
									 <input type=hidden name="endDate" id="endDate" />
	                                <!-- 조회 버튼 -->
	                                    <input type="submit" class="btn btn-info" value="조회"/>
								</form>
								
                            </div>
                            <div id="date-picker-display-container">
                            </div>
                            <!-- /date 선택 -->
                            

                            <!-- 캘린더 모달창 -->
                            <div id="date-picker-modal" style="top: 190px;" class="hidden-2" >
                                <div id="date-picker-top-bar">
                                    <div id="date-picker-previous-month" class="date-picker-change-month">&lsaquo;
                                    </div>
                                    <div id="date-picker-month">December 17</div>
                                    <div id="date-picker-next-month" class="date-picker-change-month">&rsaquo;</div>
                                </div>
                                <div id="date-picker-exit">&times;</div>
                                <table id="date-picker">
                                    <tr id="date-picker-weekdays">
                                        <th>S</th>
                                        <th>M</th>
                                        <th>T</th>
                                        <th>W</th>
                                        <th>T</th>
                                        <th>F</th>
                                        <th>S</th>
                                    </tr>
                                    <!-- Actual calendar rows added dynamically -->
                                    <!--<tr class="date-picker-calendar-row"></tr>-->
                                </table>
                            </div>
                            <!-- /캘린더 모달 -->
                        </div>
                        <!-- /date-picker-container -->
                    </div>
                    <!-- /DatePicker -->
                </div>
                <!-- /lead mt-5 -->


                <div class="row my-4">
                    <div class="col-lg-12 col-md-8">
                        <div id="list" class="table-responsive" style="overflow: ;">
									<div class="d01">
										<div class="left" id="pageinfo"></div>
										<div class="right" id="pageRows"></div>
									</div>

									<div class="clear"></div>
							
                            <form id="frmList" name="frmList" style="text-align: center;">
                                <table class="table table-striped">
                                    <thead class="thead-inverse table-class" id="table-id">
                                        <tr>
                                            <th>일자</th>
                                            <th>출근시각</th>
                                            <th>퇴근시각</th>
                                            <th>연장근무시간</th>
                                            <th>근태구분</th>
                                            <th>총근무시간</th>
                                            <th>신청상태</th>
                                        </tr>
                                    </thead>
                                    <tbody >
                                        <!-- JS <tr></tr> 들어갈 곳  -->
                                    </tbody>
                                </table>
                            </form>
									 <div class="center">
                 					<ul class="pagination" id="pagination"></ul>
               				</div>
                        </div> <!-- </list> -->
                    
                    </div>
	              	</div>
	              	<!--/row-->
               
            </div>
            <!-- /col -->

						<!-- 끝________________본문____해당파트___삽입하기(내부분)_________________ -->
			</section>
		</div> <!-- </div content> --> 
    </div> <!-- </div wrap -->
    
    <!--scripts loaded here-->
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
      <!-- JS, Popper.js -->
	 <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
	 <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
    <script src="${pageContext.request.contextPath}/JS/navmenu_template.js"></script>
    <script src="${pageContext.request.contextPath}/JS/personnel/commutelistDatepicker.js"></script>
</body>

</html>