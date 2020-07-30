<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
    <script src="${pageContext.request.contextPath}/JS/financial/incomeView.js"></script>
    
    
    <!-- 내 CSS -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/financial/main.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/financial/imcome.css"/>
      

  </head>

<body>
<!-- 공통 헤더 -->
<jsp:include page="nav.jsp" />
        <div class="container-fluid" id="main">
		<div class="row row-offcanvas row-offcanvas-left">
			<jsp:include page="left_menu.jsp" />
			
			 <div class="col main pt-5 mt-3">
<!-- 작업페이지 -->
<h1 class="display-4 d-none d-sm-block" style="text-align: center; padding-top: 50px; padding-bottom: 10px;">손익계산서</h1>

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
<!--------------------------- 공통 헤더, 공통 nav ---------------------------->
</div>
<!--/main col-->
</div>
<!-- 본문, 내가 할 거 끝 -->
</div>
<!--------------------------- 공통 헤더, 공통 nav ---------------------------->
</body>
</html>