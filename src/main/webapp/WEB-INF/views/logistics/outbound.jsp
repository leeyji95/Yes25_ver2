<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>출고관리</title>
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
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/CSS/styles.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/logistics/basic.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="${pageContext.request.contextPath }/JS/logistics/outbound.js"></script>
</head>
<body>
	<div class="container-fluid" id="main">
		<div class="row row-offcanvas row-offcanvas-left">

			<!-- 본문, 내가 할 거 -->
			<div class="col main pt-5 mt-3">
				<div class="div_title">
					<h1 class="display-4 d-none d-sm-block" id="title">YES25 출고관리</h1>
				</div>
				
				<%--버튼 --%>
				<div class="container div_btn">
					<div class="pull-right">
					<button type="button" id="btnQuery" class="btn btn-primary">조회</button>
					<button type="button" id="btnUpdate" class="btn btn-primary">출고</button>
					</div>
				</div>

				<form id="query">
					<div class="form-group">
					<table class="table table-cols">
						<tbody>
							<tr>
								<th>출고상태</th>
								<td>
									<select name='order_state'>
										<option value='1' selected>출고대기</option>
										<option value='2'>출고완료</option>
									</select>
								</td>
							</tr>
							<tr>
				  				<th>ISBN</th>
				  				<td>
				  					<textarea style='width:300px; height:200px' name='book_isbn' class="form-control" placeholder="ISBN을 입력하세요"></textarea>
				  				</td>
				  			</tr>
						</tbody>
					</table>
					</div>
				</form>

				<div class="row my-4">
					<div class="col-lg-12 col-md-12">
						<div id="list" class="table-responsive">
							<div class="table-background"></div>
							<form id="frmList" name="frmList">
								<table class="table table-striped table-main">
									<thead class="thead-inverse">
										<tr>
											<th>번호선택</th>
											<th>출고번호</th>
											<th>도서제목</th>
											<th>ISBN</th>
											<th>판매가격</th>
											<th>출고수량</th>
											<th>결재금액</th>
											<th>출고상태</th>
											<th>출고일자</th>
										</tr>
									</thead>
									<tbody>

									</tbody>
								</table>
							</form>
							<div class="table-background"></div>
						</div>
					</div>
				</div>



			</div>
			<!--/main col-->
			<!-- 본문, 내가 할 거 끝 -->
		</div>

	</div>

	<script
		src="http://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

	<script src="${pageContext.request.contextPath}/JS/scripts.js"></script>
</body>
</html>