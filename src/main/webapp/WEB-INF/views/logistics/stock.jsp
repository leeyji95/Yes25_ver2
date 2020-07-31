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
	src="${pageContext.request.contextPath }/JS/logistics/stock.js"></script>
</head>
<body>
	<div class="container-fluid" id="main">
		<div class="row row-offcanvas row-offcanvas-left">

			<!-- 본문, 내가 할 거 -->
			<div class="col main pt-5 mt-3">
				<div class="div_title">
					<h1 class="display-4 d-none d-sm-block" id="title">재고관리</h1>
				</div>
				<%--버튼 --%>
				<div class="container div_btn">
					<div class="pull-right">
					<button type="button" id="btnQuery" class="btn btn-primary">조회</button>
					<button type="button" id="btnExcel" class="btn btn-primary">엑셀</button>
					</div>
				</div>


				<form id="query">
					<div class="form-group">
						<table class="table table-cols">
							<tbody>
								<tr>
									<th>조건검색</th>
									<td>
									<div>
										<select name='classification'>
											<option value='0' selected>선택</option>
											<option value='1'>도서제목</option>
											<option value='2'>ISBN</option>
											<option value='3'>출판사명</option>
											<option value='4'>도서저자</option>
										</select>
										<input type="text" name='keyword'>
									</div>
									</td>
								</tr>
								<tr>
									<th>카테고리</th>
									<td>
									<div>
										<select name='category_uid'>
											<option value='0' selected>선택</option>
											<option value='1'>문학</option>
											<option value='2'>소설</option>
											<option value='3'>전산</option>
											<option value='4'>과학</option>
										</select>
									</div>
									</td>	
								</tr>
								<tr>
									<th>출간일자</th>
									<td>
									<div>
										<input type="text" id="datepicker1" name="datepicker1"><i class="far fa-calendar-alt fa-1x calendar"></i> ~ <input type="text" id="datepicker2" name="datepicker2"><i class="far fa-calendar-alt fa-1x calendar"></i>
									</div>
									</td>	
								</tr>
							</tbody>
						</table>
					</div>
				</form>
				

				<div class="row my-4">
					<div class="col-lg-12 col-md-12">
						<div id="list" class="table-responsive">
							<div class="table-background1"></div>
								<form id="frmList" name="frmList">
									<table class="table table-striped table-main">
										<thead class="thead-inverse">
											<tr>
												<th>번      호</th>
												<th>도서제목</th>
												<th>ISBN</th>
												<th>출판사명</th>
												<th>도서저자</th>
												<th>카테고리</th>
												<th>출간일자</th>
												<th>재고수량</th>
											</tr>
										</thead>
										<tbody>
	
										</tbody>
									</table>
								</form>
							<div class="table-background2"></div>
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