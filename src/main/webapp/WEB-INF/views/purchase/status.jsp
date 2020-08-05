<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>발주현황</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="generator" content="Codeply">
<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker3.min.css" />
<link rel="stylesheet"	href="${pageContext.request.contextPath}/CSS/navmenu_template.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/purchase/status.css" />

<script src="http://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.ko.min.js"></script>
<script src="${pageContext.request.contextPath}/JS/navmenu_template.js"></script>
<script src="${pageContext.request.contextPath}/JS/purchase/status.js"></script>
</head>

<body>
	<div class="wrap">
		<nav class="nav-bar navbar-inverse fixed-top" role="navigation">
			<div id="top-menu" class="container-fluid active"
				style="background-color: #222;">
				<a class="navbar-brand"
					href="${pageContext.request.contextPath}/personnel/main">Yes25
					ERP</a>
				<ul class="nav navbar-nav">
					<li class="dropdown movable"><a href="#"
						class="dropdown-toggle" data-toggle="dropdown"><span
							class="caret"></span><span class="fa fa-4x fa-child"></span></a>
						<ul class="dropdown-menu" role="menu">
							<li><a href="#"><span class="fa fa-gear"></span>비밀번호변경</a></li>
							<li class="divider"></li>
							<li><a
								href="${pageContext.request.contextPath }/personnel/logout"><span
									class="fa fa-power-off"></span>Logout</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</nav>

		<!-- 왼쪽 메뉴바 -->
		<aside id="side-menu" class="aside" role="navigation">
			<ul class="nav nav-list accordion">
				<li class="nav-header">
					<div class="link">
						<i class="fa fa-lg fa-users"></i>인사관리<i class="fa fa-chevron-down"></i>
					</div>
					<ul class="submenu">
						<li><a
							href="${pageContext.request.contextPath }/personnel/main">출퇴근
								등록</a></li>
						<li><a
							href="${pageContext.request.contextPath }/personnel/commutelist">근태현황
								조회</a></li>
					</ul>
				</li>

				<li class="nav-header">
					<div class="link">
						<i class="fas fa-piggy-bank"></i>재무관리<i class="fa fa-chevron-down"></i>
					</div>
					<ul class="submenu">
						<li><a
							href="${pageContext.request.contextPath }/financial/financialMain.bn">재무메인</a></li>
					</ul>
				</li>

				<li class="nav-header">
					<div class="link">
						<i class="fas fa-boxes"></i>물류관리<i class="fa fa-chevron-down"></i>
					</div>
					<ul class="submenu">
						<li><a
							href="${pageContext.request.contextPath }/logistics/inbound">입고관리</a></li>
						<li><a
							href="${pageContext.request.contextPath }/logistics/outbound">출고관리</a></li>
						<li><a
							href="${pageContext.request.contextPath }/logistics/stock">재고관리</a></li>
						<li><a
							href="${pageContext.request.contextPath }/logistics/kpi">현황요약</a></li>
					</ul>
				</li>

				<li class="nav-header">
					<div class="link">
						<i class="fas fa-book-open"></i>제품관리<i class="fa fa-chevron-down"></i>
					</div>
					<ul class="submenu">
						<li><a
							href="${pageContext.request.contextPath }/products/list">제품관리</a></li>
					</ul>
				</li>

				<li class="nav-header">
					<div class="link">
						<i class="fas fa-calculator"></i>구매관리<i class="fa fa-chevron-down"></i>
					</div>
					<ul class="submenu">
						<li><a
							href="${pageContext.request.contextPath }/purchasing/vendor.do">거래처관리</a></li>
						<li><a
							href="${pageContext.request.contextPath }/purchasing/order.do">발주요청</a></li>
						<li><a
							href="${pageContext.request.contextPath }/purchasing/status.do">발주현황</a></li>
					</ul>
				</li>
			</ul>
		</aside>

		<!--Body content-->
		<div class="content">
			<div class="top-bar">
				<a href="#menu" class="side-menu-link burger"> <span
					class='burger_inside' id='bgrOne'></span> <span
					class='burger_inside' id='bgrTwo'></span> <span
					class='burger_inside' id='bgrThree'></span>
				</a>
			</div>

			<section class="content-inner">
				<div class="col main pt-5 mt-3">
					<div class="div_title">
						<h1 class="display-4 d-none d-sm-block" id="title">발주현황</h1>
					</div>
					<hr>
					<div class="lead mt-5 d-none d-sm-block">
					<!-- 시작________________본문____해당파트___삽입하기(내부분)_________________ -->
						<div class="container-fluid">
							<div class="row">
								<!-- 발주현황  -->
								<div class="col-sm-6">
									<div class="card">
										<div class="card-header bg-dark text-white">발주 목록</div>
										<div class="card-body">
											<div class="col-sm-12 row page-info-panel">
												<div class="col-sm-8 text-left align-self-end"
													id="page-info"></div>
												<div class="col-sm-4 text-right">
													<button type="button" class="btn btn-warning"
														id="reset-order-list">
														<i class="fa fa-refresh spaceRight"></i>초기화
													</button>
												</div>
											</div>
											<div class="table-responsive table-hover">
												<table class="table">
													<thead class="thead-inverse">
														<tr>
															<th>발주일자</th>
															<th>거래처명</th>
														</tr>
													</thead>
													<tbody id="order-list"></tbody>
												</table>
											</div>
										</div>
										<ul class="pagination" id="pagination"></ul>
									</div>
								</div>

								<!-- 발주현황 검색 -->
								<div class="col-sm-6">
									<div class="card">
										<div class="card-header bg-dark text-white">발주현황 검색</div>
										<div class="card-body">
											<form role="form" id="search-order" method="POST">
												<div class="form-group inline-block">
													<label for="search-order-startDate" class="col-sm-3">발주일자</label>
													<input type="text" id="search-order-startDate"
														class="form-control col-sm-3 datePicker"> <span>
														~ </span> <input type="text" id="search-order-endDate"
														class="form-control col-sm-3 datePicker">
												</div>
												<div class="form-group inline-block">
													<label for="search-order-pub-name" class="col-sm-3">거래처명</label>
													<input type="text" id="search-order-pub-name"
														class="form-control col-sm-6">
												</div>
												<div class="form-group inline-block">
													<label for="search-order-book-subject" class="col-sm-3">도서명</label>
													<input type="text" id="search-order-book-subject"
														class="form-control col-sm-6">
												</div>
												<div class="form-group text-right">
													<button type="reset" class="btn btn-warning" id="reset">
														<i class="fa fa-refresh spaceRight"></i>초기화
													</button>
													<button class="btn btn-primary" id="search">
														<i class="fa fa-search spaceRight"></i>검색
													</button>
												</div>
											</form>
										</div>
									</div>
								</div>
							</div>
						</div>
					<!-- 끝________________본문____해당파트___삽입하기(내부분)_________________ -->
					</div>
				</div>
			</section>
		</div>
		<!-- </div content> -->
	</div>
	<!-- </div wrap -->
</body>

<!-- 거래처 정보 모달 -->
<div class="modal" id="pub-info">
	<input type="hidden" name="pub_uid">
	<div class="modal-dialog">
		<div class="modal-content">
			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">거래처 정보</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>

			<!-- Modal body -->
			<div class="modal-body">
				<table class="table table-boardered">
					<tr>
						<th>거래처명</th>
						<td><input type="text" name="pub_name"></td>
					</tr>
					<tr>
						<th>사업자 등록번호</th>
						<td><input type="text" name="pub_num"></td>
					</tr>
					<tr>
						<th>대표자명</th>
						<td><input type="text" name="pub_rep"></td>
					</tr>
					<tr>
						<th>연락처</th>
						<td><input type="text" name="pub_contact"></td>
					</tr>
					<tr>
						<th>주소</th>
						<td><input type="text" name="pub_address"></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>

<!-- 도서 정보 모달 -->
<div class="modal" id="book-info">
	<input type="hidden" name="book_uid">
	<div class="modal-dialog">
		<div class="modal-content">
			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">도서 정보</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>

			<!-- Modal body -->
			<div class="modal-body">
				<table class="table table-boardered">
					<tr>
						<th>도서명</th>
						<td><input type="text" name="book_subject"></td>
					</tr>
					<tr>
						<th>저자</th>
						<td><input type="text" name="book_author"></td>
					</tr>
					<tr>
						<th>출판사</th>
						<td><input type="text" name="pub_name"></td>
					</tr>
					<tr>
						<th>출판일</th>
						<td><input type="text" name="book_pubdate"></td>
					</tr>
					<tr>
						<th>카테고리</th>
						<td><input type="text" name="ctg_name"></td>
					</tr>
					<tr>
						<th>내용</th>
						<td><input type="text" name="book_content"></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>

<!-- 발주서 -->
<div class="modal" id="purchase-order">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title spaceRight">발주서</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>

			<!-- Modal body -->
			<div class="modal-body">
				<div class="col-sm-12">
					<div class="text-center">
						<h1>발주서</h1>
					</div>
					<div class="text-right">
						<h5 class="ord-date"></h5>
					</div>
					<div class="row">
						<div class="col-sm-6">
							<h3>수주처</h3>
							<table class="table">
								<tr>
									<td class="font-weight-bold">상호</td>
									<td class="pub-name"></td>
								</tr>
								<tr>
									<td class="font-weight-bold">사업자 등록번호</td>
									<td class="pub-num"></td>
								</tr>
								<tr>
									<td class="font-weight-bold">대표자</td>
									<td class="pub-rep"></td>
								</tr>
								<tr>
									<td class="font-weight-bold">연락처</td>
									<td class="pub-contact"></td>
								</tr>
								<tr>
									<td class="font-weight-bold">주소</td>
									<td class="pub-address"></td>
								</tr>
							</table>
						</div>
						<div class="col-sm-6">
							<h3>발주처</h3>
							<table class="table">
								<tr>
									<td class="font-weight-bold">상호</td>
									<td>YES25</td>
								</tr>
								<tr>
									<td class="font-weight-bold">사업자 등록번호</td>
									<td>000-00-00000</td>
								</tr>
								<tr>
									<td class="font-weight-bold">대표자</td>
									<td>이승환</td>
								</tr>
								<tr>
									<td class="font-weight-bold">연락처</td>
									<td>010-0000-0000</td>
								</tr>
								<tr>
									<td class="font-weight-bold">주소</td>
									<td>서울특별시 강남구 역삼동</td>
								</tr>
							</table>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12">
							<table class="table table-bordered" id="purchase-order-list"></table>
						</div>
					</div>
				</div>
			</div>

			<!-- Modal footer -->
			<div class="modal-footer">
				<div class="text-right">
					<button type="button" class="btn btn-primary"
						id="print-purchase-order">
						<i class="fa fa-print spaceRight"></i>인쇄
					</button>
				</div>
			</div>
		</div>
	</div>
</div>
</html>