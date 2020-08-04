<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
  <head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>서점ERP시스템</title>
    
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"> 
    
    <!-- 내 CSS -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/financial/main.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/financial/imcome.css"/>
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
                            <li><a href="#"><span class="fa fa-gear"></span>비밀번호변경</a></li>
                            <li class="divider"></li>
                            <li><a href="${pageContext.request.contextPath }/personnel/logout"><span class="fa fa-power-off"></span>Logout</a></li>
                        </ul>
                    </li>
                    
                </ul>
            </div>      
        </nav>
        
        <!-- 왼쪽 메뉴바 -->
        <aside id="side-menu" class="aside" role="navigation" style="overflow-y: scroll;">            
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
					<h3 class="display-4 d-none d-sm-block" style="text-align: center; padding-top: 50px; padding-bottom: 10px;">손익계산서</h3>
					<hr>
					<div class="lead mt-5 d-none d-sm-block">




<!-- 시작________________본문____해당파트___삽입하기(내부분)_________________ ------------------------------------>
<div style="text-align: right;">
	<select id="choiceYear" style="padding: 10px 20px;">
		<option value="2019" selected="selected">2019년</option>
		<option value="2018">2018년</option>
	</select>
</div>
<!--
	수익
	* 영업수익 : 회사의 주된 영업과 관련 있음
	* 영업외수익 : 회사의 주된 영업과 관련 없음
	
	비용
	* 영업비용 : 회사의 주된 영업과 관련 있음
		-> 매출원가 : 제품을 '생산 또는 구매'하는 데 들어간 비용
		-> 판매비와 일반관리비 : 제품을 '판매 및 관리'에 소요된 판관비
	* 영업외비용 : 회사의 주된 영업과 관련 없음
	* 법인세비용 : 회사가 벌어들인 소득에 대해 국가에 내는 법인세
-->

<form method="post" action="excelDown.bn">

<!-- 스프링 시큐리티시 post로 넘기고 싶으면 아래의 토큰을 반드시 보내줘야 가능 -->
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

<table style="width: 90%; text-align: center;">
	<tr class="lineBotton">
		<th style="width: 50%; text-align: center; border-right: 1px solid black;">과목</th>
		<th style="width: 50%; text-align: center;">금액</th>
	</tr>
	
	<tr>
		<th class="lineRight">Ⅰ. 매출액</th>
		<td>
			<label class="netSales"></label>
			<input name="netSales" hidden="true">
		</td>
	</tr>
	<tr class="width100">
		<!--
			매출원가 : 수익을 얻기 위하여 발생한 비용, 고객에게 인도한 상품의 원가
			매출원가 = 기초상품재고액 + 당기상품매입액 - 기말상품재고액이나 상품 금액으로 대체
		-->
		<th class="lineRight">Ⅱ. 매출원가</th>
		<td>
			<label class="costOfGoodsSold"></label>
			<input name="costOfGoodsSold" hidden="true">
		</td>
	</tr>
	<tr>
		<td class="lineRight">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;판매비와관리비</td>
		<td>
			<label class="maintenanceSales"></label>
			<input name="maintenanceSales" hidden="true">
		</td>
	</tr>
	<tr class="width100">
		<!-- 매출총이익 = 매출액 - 매출원가 -->
		<th class="lineRight">Ⅲ. 매출총이익</th>
		<td>
			<label class="grossProfit"></label>
			<input name="grossProfit" hidden="true">
			</td>
	</tr>
	<!--------------------------------------------------->
	<tr>
		<!-- 영업이익 = 매출총이익 - 판관비 -->
		<th class="lineRight">Ⅳ. 영업이익</th>
		<td>
			<label class="salesIcome"></label>
			<input name="salesIcome" hidden="true">
		</td>
	</tr>
	<tr class="width100">
		<td class="lineRight">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;기타수익</td>
		<td>
			<label class="etcIncome"></label>
			<input name="etcIncome" hidden="true">
		</td>
	</tr>
	<tr class="width100">
		<td class="lineRight">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;기타비용</td>
		<td>
			<label class="etcCost"></label>
			<input name="etcCost" hidden="ture">
		</td>
	</tr>
	<!--------------------------------------------------->
	<tr>
		<!-- 법인세비용차감전순이익 = 영업이익 + 영업외이익 - 영업외비용 -->
		<th class="lineRight">Ⅴ. 법인세비용차감전순이익</th>
		<td>
			<label class="corporateTaxIncome"></label>
			<input name="corporateTaxIncome" hidden="true">
		</td>
	</tr> 
	<tr>
		<td class="lineRight">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;법인세비용</td>
		<td>
			<label class="corporateTax"></label>
			<input name="corporateTax" hidden="true">
		</td>
	</tr>
	<tr>
		<!-- 당기순이익 = 법인세비용차감전순이익 - 법인세비용 -->	
		<th class="lineRight">Ⅵ. 당기순이익</th>
		<td>
			<label class="currentIncome"></label>
			<input name="currentIncome" hidden="true">
		</td>
	</tr>
</table>

<!-- 버튼 -->
<div style="text-align: right;">
	<button class="btnMyself info">출력</button>
	<button type="button" class="btnMyself info" onclick="location.href='financialMain.bn'">재무 메인</button>
</div>
</form>

	
<br><br><br><br>

<div id="result"></div>

<!-- 끝________________본문____해당파트___삽입하기(내부분)_________________ ------------------------------------>
					</div>
				</div>
			</section>
		</div> <!-- </div content> --> 
    </div> <!-- </div wrap -->
<!----------------------------------------------------------------------------------------------------->	




	<!-- JS 로드 -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script> 
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    
    <!-- 내 자바스크립트 -->
    <script src="${pageContext.request.contextPath}/JS/financial/incomeView.js"></script>
    
    <!-- JS 로드 -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script> 
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    
</body>
</html>