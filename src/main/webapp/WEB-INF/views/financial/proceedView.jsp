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
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
    <!-- 내 CSS -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/financial/main.css"/>
    <link rel="stylesheet"	href="${pageContext.request.contextPath}/CSS/navmenu_template.css" />
    <style type="text/css">
    #title
   	{font-size: 38px;
	    font-weight: bold;
	    padding: 15px 20px;
	    letter-spacing: 5px;}
    </style>
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
					<div class="div_title">
						<h1 class="display-4 d-none d-sm-block" id="title">결재대기</h1>
					</div>
					<hr>
					<div class="lead mt-5 d-none d-sm-block">
					
						<!-- 시작________________본문____해당파트___삽입하기(내부분)_________________ -->


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


						<!-- 끝________________본문____해당파트___삽입하기(내부분)_________________ -->
						
					</div>
				</div>
			</section>
		</div> <!-- </div content> --> 
    </div> <!-- </div wrap -->		
    
    <!-- jQuery library --> 
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 
	<!-- Popper JS --> 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script> 
	<!-- Latest compiled JavaScript -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <!-- 내 자바스크립트 -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <!-- JS, Popper.js -->
	 <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
	 <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
    <script src="${pageContext.request.contextPath}/JS/navmenu_template.js"></script>
    <script src="${pageContext.request.contextPath}/JS/financial/financialView.js"></script>
    
</body>
</html>

</c:otherwise>
</c:choose>