<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>도서관리</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/personnel/commutelist.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/personnel/register.css" />
</head>
<body>
<jsp:include page="nav.jsp"/>

	<div class="container-fluid" id="main">
		<div class="row row-offcanvas row-offcanvas-left">
 			<jsp:include page="left_menu.jsp"/>
 			
			<!-- 본문, 내가 할 거 -->
			<div class="col main pt-5 mt-3">
				<h1 class="display-4 d-none d-sm-block">YES25 근태관리</h1>  
				
				 <hr>
                <div class="lead mt-5 d-none d-sm-block">
                    <!-- DatePicker 영역 -->
                    <div id="date-picker-section" class="container">
                    
                        <div id="date-picker-container">
                        
                            <!-- date 선택  -->
                            <div id="date-picker-dates">
                                <!-- 근태조회 text -->
                                <span style="display: block; padding: 20px;">근태조회</span>

                                <div id="date-picker-date-first" class="date-picker-date">
                                    24/12/2017
                                </div>
                                <div class="date-picker-date">
                                    28/12/2017
                                </div>

                                <!-- 조회 버튼 -->
                                <div class="btn_container">
                                    <button type="button" class="btn btn-info">조회</button>
                                </div>
                               
                            </div>

                            <div id="date-picker-display-container">
                            </div>
                            <!-- /date 선택 -->

                            <!-- 캘린더 모달창 -->
                            <div id="date-picker-modal" class="hidden-2">
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
                        <div id="list" class="table-responsive">

                            <form id="frmList" name="frmList">
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
                                    <tbody>
                                        <!-- JS <tr></tr> 들어갈 곳  -->
                                    </tbody>
                                </table>
                            </form>

                        </div>
                    </div>

                </div>
                <!--/row-->
                <!-- 페이징 -->
                <div class="center">
                    <ul class="pagination" id="pagination">

                    </ul>
                </div>
            </div>
            <!-- /col -->
            <hr>

        </div>
        <!-- /row -->

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
                                    <form>
                                        <!-- 이름/전화번호 -->
                                        <div class="row clearfix">
                                            <div class="col_half">
                                                <!-- 이름 -->
                                                <div class="input_field"> <span><i aria-hidden="true"
                                                            class="fa fa-user"></i></span>
                                                    <input type="text" name="name" placeholder="Name" />
                                                </div>
                                            </div>
                                            <div class="col_half">
                                                <!-- 전화번호 -->
                                                <div class="input_field"> <span><i aria-hidden="true"
                                                            class="fa fa-phone"></i></span>
                                                    <input type="text" name="phone" placeholder="PhoneNumber"
                                                        required />
                                                </div>
                                            </div>
                                        </div>
                                        <!-- 부서코드 / 이메일 -->
                                        <div class="row clearfix">
                                            <div class="col_half">
                                                <!-- 부서코드 -->
                                                <div class="input_field select_option"> <span><i aria-hidden="true"
                                                            class="fa fa-sitemap"></i></span>
                                                    <select>
                                                        <option>부서코드</option>
                                                        <option>Option 1</option>
                                                        <option>Option 2</option>
                                                    </select>
                                                    <div class="select_arrow"></div>
                                                </div>
                                            </div>
                                            <div class="col_half">
                                                <!-- 이메일 -->
                                                <div class="input_field"> <span><i aria-hidden="true"
                                                            class="fa fa-envelope"></i></span>
                                                    <input type="email" name="email" placeholder="Email" required />
                                                </div>
                                            </div>
                                        </div>

                                        <!-- 직급코드 / 입사일 -->
                                        <div class="row clearfix">
                                            <div class="col_half">
                                                <!-- 직급코드 -->
                                                <div class="input_field select_option"> <span><i aria-hidden="true"
                                                            class="fa fa-address-card"></i></span>
                                                    <select>
                                                        <option>직급코드</option>
                                                        <option>Option 1</option>
                                                        <option>Option 2</option>
                                                    </select>
                                                    <div class="select_arrow"></div>
                                                </div>
                                            </div>
                                            <div class="col_half">
                                                <!-- 입사일 -->
                                                <div class="input_field"> <span class="reg">입사일</span>
                                                    <input type="date" id="datepicker" name="hiredate"
                                                        style="letter-spacing: 3px; text-align: center;" />
                                                </div>
                                            </div>
                                        </div>

                                        <!-- 관리자여부 -->
                                        <div class="row clearfix">
                                            <div class="col_half">
                                                <!-- 관리자여부 -->
                                                <div class="input_field select_option"> <span><i aria-hidden="true"
                                                            class="fa fa-address-card"></i></span>
                                                    <select>
                                                        <option>Y/N</option>
                                                        <option>Y</option>
                                                        <option>N</option>
                                                    </select>
                                                    <div class="select_arrow"></div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- 등록 완료 제출 버튼 -->
                                        <input class="button" type="submit" value="Register" />
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

            </div>
        </div>
    </div>
    
    
    
    
    <!--scripts loaded here-->
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
  
    <script src="${pageContext.request.contextPath}/JS/personnel/commutelist.js"></script>
    <script	src="${pageContext.request.contextPath}/JS/personnel/register.js"></script>
</body>

</html>