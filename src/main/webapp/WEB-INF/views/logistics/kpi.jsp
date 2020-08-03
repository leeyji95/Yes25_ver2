<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>재고관리</title>
<meta name="description"
	content="A Bootstrap 4 admin dashboard theme that will get you started. The sidebar toggles off-canvas on smaller screens. This example also include large stat blocks, modal and cards. The top navbar is controlled by a separate hamburger toggle button." />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="generator" content="Codeply">
<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/styles.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/logistics/basic.css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="${pageContext.request.contextPath }/JS/logistics/kpi.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.bundle.min.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>
</head>
<body>
	<div class="container-fluid" id="main">
		<div class="row row-offcanvas row-offcanvas-left">

			<!-- 본문, 내가 할 거 -->
			<div class="col main pt-5 mt-3">
				<div class="div_title">
					<h1 class="display-4 d-none d-sm-block" id="title">현황요약</h1>
				</div>
				
				<div>
					<div class="container text-center">
						<div class="div_datepicker">
							<button id="btnLeft">
							<i class="fas fa-chevron-left"></i>
							</button>
							<span>2020.<span id="month"></span>. <i class="far fa-calendar-alt fa-1x calendar"></i></span>
							<button id="btnRight">
							<i class="fas fa-chevron-right"></i>
							</button>
						</div>
						<div class="btn-group">
						  <button type="button" id="btnDay" class="btn btn-primary">월간</button>
						  <button type="button" id="btnMonth" class="btn btn-primary">연간</button>
						</div>
					</div>
				</div>


				<form id="query">
					<div class="infor_wrap">
						<div class="data_section">
							<div class="dashboard_component">
								<ul class="list">
									<li class="item">
										<span class="item_title">입고량 누계</span>
										<p><strong class="item_value1"></strong></p>
									</li>
									<li class="item">
										<span class="item_title">출고량 누계</span>
										<p><strong class="item_value2"></strong></p>
									</li>
 									<li class="item">
										<span class="item_title">GAP (입고량 - 출고량)</span>
										<p><strong class="item_value3"></strong></p>
									</li>
									<!-- <li class="item">
										<span class="item_title">최다 출고 서적</span>
										<p><strong class="item_value4"></strong></p>
									</li>  -->
								</ul>
							</div>
						</div>
					</div>
				</form> 
				

				<div class="row my-4">
					<div class="col-lg-6 col-md-6" id="div_graph">
						<div id="list" class="table-responsive">
							<div class="table-background1">
								<p class="chart_title">&lt;기간별 입고량 집계&gt;</p>
							</div>
								<form id="frmList" name="frmList">
									<div class="chartAreaWrapper">
										<canvas id="myChart1" width="580" height="400"></canvas>
									</div>
								</form>
							<!-- <div class="table-background2"></div> -->
						</div>
					</div>
					<div class="col-lg-6 col-md-6" id="div_graph">
						<div id="list" class="table-responsive">
							<div class="table-background1">
								<p class="chart_title">&lt;기간별 출고량 집계&gt;</p>
							</div>
								<form id="frmList" name="frmList">
									<div class="chartAreaWrapper">
										<canvas id="myChart2" width="580" height="400"></canvas>
									</div>
								</form>
							<!-- <div class="table-background2"></div> -->
						</div>
					</div>
				</div>
				


			</div>
			<!--/main col-->
			<!-- 본문, 내가 할 거 끝 -->
		</div>

	</div>

	<script
		src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="https://kit.fontawesome.com/a076d05399.js"></script>

	<script src="${pageContext.request.contextPath}/JS/scripts.js"></script>
</body>
</html>