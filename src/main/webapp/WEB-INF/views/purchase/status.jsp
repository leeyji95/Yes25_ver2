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

<style>
    [class^='col-sm']
    {padding-top: 15px;}
    
    #order-list tr
    {cursor: pointer;}
    
    #order-list td:nth-child(n+2):nth-child(-n+3):hover
    {color : #007bff;}
    
    .pagination
    {justify-content : center;}
   	
   	.pagination li
   	{cursor : pointer;}
   	
   	.none, .none *
   	{display : none !important;}
   	
   	.inline-block *
   	{display : inline-block !important;}
   	
   	.spaceLeft
   	{padding-left : 0.5em;}
</style>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker3.min.css" />
</head>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.ko.min.js"></script>

<script src="${pageContext.request.contextPath}/JS/purchase/status.js"></script>

<body>
<div class="container">
    <div class="row">
        <div class="col-sm-12">
        	<div class="card">
				<div class="card-header bg-dark text-white">발주현황 검색</div>
				<div class="card-body">
					<form role="form" id="search-order" method="POST">
						<div class="form-group inline-block">
							<label for="search-order-startDate" class="col-sm-2">발주일자</label>
							<input type="text" id="search-order-startDate" class="form-control col-sm-3 datePicker">
							<span> ~ </span>
							<input type="text" id="search-order-endDate" class="form-control col-sm-3 datePicker">
						</div>
						<div class="form-group inline-block">
							<label for="search-order-pub-name" class="col-sm-2">거래처명</label>
							<input type="text" id="search-order-pub-name" class="form-control col-sm-6">
						</div>
						<div class="form-group inline-block">
							<label for="search-order-book-subject" class="col-sm-2">도서명</label>
							<input type="text" id="search-order-book-subject" class="form-control col-sm-6">
						</div>
						<div class="form-group text-right">
							<button type="reset" class="btn btn-warning" id="reset">
								초기화<i class="fa fa-refresh spaceLeft"></i>
							</button>
							<button class="btn btn-primary" id="search">
								검색<i class="fa fa-search spaceLeft"></i>
							</button>
						</div>
					</form>
				</div>
			</div>
        </div>
    </div>
    <div class="row">
    	<div class="col-sm-12">
	    	<div class="card">
			<div class="card-header bg-dark text-white">검색결과</div>
			<div class="card-body">
				<div id="page-info"></div>
				<div class="table-responsive table-hover">
					<table class="table">
						<thead class="thead-inverse">
							<tr>
								<th>발주일자</th>
								<th>거래처명</th>
								<th>도서명</th>
								<th>단가</th>
								<th>수량</th>
							</tr>
						</thead>
						<tbody id="order-list"></tbody>
					</table>
				</div>
			</div>
			<ul class="pagination" id="pagination"></ul>
			</div>
    	</div>
    </div>
</div>
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

</html>