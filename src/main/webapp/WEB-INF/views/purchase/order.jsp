<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>발주요청</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="generator" content="Codeply">
<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />

<style>
    .container-fluid
    {padding-top: 15px;}
    
    #search-result-table tr
    {cursor : pointer;}
    
    .pagination
    {justify-content : center;}
   	
   	.pagination li
   	{cursor : pointer;}
   	
   	.none, .none *
   	{display : none !important;}
   	
   	.error 
   	{color : red;}
   	
   	.spaceRight
   	{padding-right : 0.5em;}
   	
   	#order-paper-table th:nth-of-type(n+1):nth-of-type(-n+2),
   	#order-paper-table td:nth-of-type(n+1):nth-of-type(-n+2)
   	{display : none;}
   	
   	[contenteditable="true"] {
   	border : 1px solid #CED4DA;
   	border-radius : 0.25rem;
   	}
</style>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
</head>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.2/dist/jquery.validate.min.js"></script>
<link rel="stylesheet"	href="${pageContext.request.contextPath}/CSS/navmenu_template.css" />

<script src="${pageContext.request.contextPath}/JS/purchase/order.js"></script>

<body>
<div class="wrap">
        <nav class="nav-bar navbar-inverse" role="navigation">
            <div id ="top-menu" class="container-fluid active">
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
                  <div class="link"><i class="fa fa-lg fa-globe"></i>인사관리<i class="fa fa-chevron-down"></i></div>
                  <ul class="submenu">
                    <li><a href="${pageContext.request.contextPath }/personnel/main">출퇴근 등록</a></li>  
                    <li><a href="${pageContext.request.contextPath }/personnel/commutelist">근태현황 조회</a></li>  
                  </ul>
                </li>
                
                <li class="nav-header">
                  <div class="link"><i class="fa fa-lg fa-users"></i>재무관리<i class="fa fa-chevron-down"></i></div>
                  <ul class="submenu">
                    <li><a href="${pageContext.request.contextPath }/financial/">재무메인</a></li>
                    <li><a href="${pageContext.request.contextPath }/financial/">재무서브1</a></li>
                    <li><a href="${pageContext.request.contextPath }/financial/">재무서브2</a></li>
                  </ul>
                </li>
                
                <li class="nav-header">
                  <div class="link"><i class="fa fa-cloud"></i>물류관리<i class="fa fa-chevron-down"></i></div>
                  <ul class="submenu">
                    <li><a href="${pageContext.request.contextPath }/logistics/inbound">입고관리</a></li>
                    <li><a href="${pageContext.request.contextPath }/logistics/outbound">출고관리</a></li>
                    <li><a href="${pageContext.request.contextPath }/logistics/stock">재고관리</a></li>
                    <li><a href="${pageContext.request.contextPath }/logistics/kpi">현황요약</a></li>
                  </ul>
                </li>  
                
                 <li class="nav-header">
                  <div class="link"><i class="fa fa-lg fa-map-marker"></i>제품관리<i class="fa fa-chevron-down"></i></div>
                  <ul class="submenu">
                    <li><a href="${pageContext.request.contextPath }/products/list">제품관리</a></li>
                  </ul>
                </li>
                
                <li class="nav-header">
                  <div class="link"><i class="fa fa-lg fa-file-image-o"></i>구매관리<i class="fa fa-chevron-down"></i></div>
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
					<!-- <h3 class="display-4 d-none d-sm-block">
							_____큰____제목______
					</h3> -->
					<hr>
					<div class="lead mt-5 d-none d-sm-block">
					
						<!-- 시작________________본문____해당파트___삽입하기(내부분)_________________ -->
		<div class="col-sm-12">
        <div class="row">
        	<!-- 거래처, 도서 목록 -->
			<div class="col-sm-6">
				<ul class="nav nav-tabs" style="display: flex;">
					<li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#search-result-tab">검색결과</a></li>
					<li class="nav-item"><a class="nav-link" data-toggle="tab" href="#order-paper-tab">발주서</a></li>
				</ul>
				
				<div class="tab-content">
					<div class="tab-pane fade show active" id="search-result-tab">
						<div class="card" id="search-result">
							<div class="card-body">
								<div id="page-info"></div>
								<div class="table-responsive table-hover">
									<table class="table" id="search-result-table"></table>
								</div>
							</div>
							<ul class="pagination" id="pagination"></ul>
						</div>
						<div class="card none" id="detail-info">
							<div class="card-header bg-dark text-white"></div>
							<div class="card-body">
								<table class="table table-boardered" id="detail-info-table"></table>
							</div>
						</div>
					</div>
					<div class="tab-pane fade" id="order-paper-tab">
						<!-- 발주서 -->
						<div class="card" id="order-paper">
							<div class="card-body">
								<div style="padding-bottom : 16px; overflow : hidden;">
									<button type="button" class="btn btn-danger pull-left" id="delete-order">
										<i class="fa fa-trash spaceRight"></i>삭제
									</button>
									<button type="button" class="btn btn-primary pull-right" id="insert-order">
										<i class="fa fa-check spaceRight"></i>발주요청
									</button>
								</div>
								<div class="card-header bg-dark text-white" id="order-parer-title">수주처</div>
								<table class="table" id="order-paper-table">
									<thead class="thead-inverse">
										<tr>
											<th>pub_uid</th>
											<th>book_uid</th>
											<th>선택</th>
											<th>도서명</th>
											<th>단가</th>
											<th>수량</th>
										</tr>
									</thead>
									<tbody id="order-list"></tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<!-- 발주 요청 -->
            <div class="col-sm-6">
                <div class="card">
					<div class="card-header bg-dark text-white">발주 품목 추가</div>
					<div class="card-body">
						<form role="form" id="add-order">
						<input type="hidden" name="pub_uid" id="add-order-pub-uid">
						<input type="hidden" name="book_uid" id="add-order-book-uid">
							<div class="form-group">
								<label for="add-order-pub-name">거래처명</label>
								<div class="input-group">
									<input type="text" class="form-control enable-search" name="pub_name" id="add-order-pub-name" placeholder="거래처명">
									<span class="input-group-append">
										<button type="button" class="btn btn-danger" id="clear-pub-name"><i class="fa fa-times"></i></button>
									</span>
								</div>
							</div>
							<div class="form-group">
								<label for="add-order-book-subject">도서명</label>
								<div class="input-group">
									<input type="text" class="form-control enable-search" name="book_subject" id="add-order-book-subject" placeholder="도서명">
									<span class="input-group-append">
										<button type="button" class="btn btn-danger" id="clear-book-subject"><i class="fa fa-times"></i></button>
									</span>
								</div>
							</div>
							<div class="form-group">
								<label for="add-order-order-unit-cost">단가</label>
								<input type="number" class="form-control" name="ord_unit_cost" id="add-order-order-unit-cost" placeholder="단가">
							</div>
							<div class="form-group">
								<label for="add-order-order-quantity">수량</label>
								<input type="number" class="form-control" name="ord_quantity" id="add-order-order-quantity" placeholder="수량">
							</div>

							<div class="form-group text-right">
								<button type="button" id="reset" class="btn btn-warning">
									<i class="fa fa-refresh spaceRight"></i>초기화
								</button>
								<button class="btn btn-primary">
									<i class="fa fa-check spaceRight"></i>추가
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
		</div> <!-- </div content> --> 
    </div> <!-- </div wrap -->
   
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

			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-success" id="pub-info-select">선택</button>
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

			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-success" id="book-info-select">선택</button>
			</div>
		</div>
	</div>
</div>
<!-- JS, Popper.js -->
	 <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
	 <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
    <script src="${pageContext.request.contextPath}/JS/navmenu_template.js"></script>
</html>