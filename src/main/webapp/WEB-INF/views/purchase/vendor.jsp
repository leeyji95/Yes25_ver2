<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>거래처·도서관리</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="generator" content="Codeply">
<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />

<style>
    .container-fluid 
    {padding-top: 15px;}
    
    #publisher-list tr
   	{cursor : pointer;}
   	
    .pagination
    {justify-content : center;}
   	
   	.pagination li
   	{cursor : pointer;}
   	
   	.error 
   	{color : red;}
   	
   	.spaceRight
   	{padding-right : 0.5em;}
   	
   	.page-info-panel, .page-info-panel > div
   	{margin : 0 !important;
   	padding : 0 !important;}
   	
   	#title
   	{font-size: 38px;
	    font-weight: bold;
	    padding: 15px 20px;
	    letter-spacing: 5px;}
</style>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.14/dist/css/bootstrap-select.min.css">
<link rel="stylesheet"	href="${pageContext.request.contextPath}/CSS/navmenu_template.css" />
</head>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.2/dist/jquery.validate.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.18/js/bootstrap-select.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.18/js/i18n/defaults-ko_KR.min.js"></script>

<script src="${pageContext.request.contextPath}/JS/purchase/vendor.js"></script>

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
						<h1 class="display-4 d-none d-sm-block" id="title">거래처관리</h1>
					</div>
					<hr>
					<div class="lead mt-5 d-none d-sm-block">
					
						<!-- 시작________________본문____해당파트___삽입하기(내부분)_________________ -->


												 <div class="container-fluid">
        <div class="row">
        	<!-- 거래처 목록 -->
            <div class="col-sm-6">
                <div class="card">
                <div class="card-header bg-dark text-white">거래처 목록</div>
                <div class="card-body">
                	<div class="col-sm-12 row page-info-panel">
               			<div class="col-sm-8 text-left align-self-end" id="page-info"></div>
               			<div class="col-sm-4 text-right">
	               			<button type="button" class="btn btn-warning" id="reset-publisher-list">
								<i class="fa fa-refresh spaceRight"></i>초기화
							</button>
						</div>
                	</div>
                    <div class="table-responsive table-hover">
                        <table class="table">
                            <thead class="thead-inverse">
                                <tr>
                                    <th>거래처명</th>
                                    <th>대표자명</th>
                                    <th>연락처</th>
                                </tr>
                            </thead>
                            <tbody id="publisher-list"></tbody>
                        </table>
                    </div>
                </div>
	            <ul class="pagination" id="pagination"></ul>
                </div>
            </div>
           	
			<div class="col-sm-6">
				<ul class="nav nav-tabs" style="display: flex;">
					<li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#pub-reg-tab">거래처 등록</a></li>
					<li class="nav-item"><a class="nav-link" data-toggle="tab" href="#pub-search-tab">거래처 검색</a></li>
				</ul>

				<div class="tab-content">
					<!-- 거래처 등록 -->
					<div class="tab-pane fade show active" id="pub-reg-tab">
						<div class="card">
							<div class="card-body">
								<form role="form" id="reg-pub" method="POST">
									<div class="form-group">
										<label for="reg-pub-pub-name">거래처명</label>
										<input type="text" class="form-control" id="reg-pub-pub-name" name="pub_name" placeholder="거래처명" required>
									</div>
									<div class="form-group">
										<label for="reg-pub-pub-num">사업자 등록번호</label>
										<input type="text" class="form-control" id="reg-pub-pub-num" name="pub_num" placeholder="사업자 등록번호" required>
									</div>
									<div class="form-group">
										<label for="reg-pub-pub-rep">대표자명</label>
										<input type="text" class="form-control" id="reg-pub-pub-rep" name="pub_rep"	placeholder="대표자명" required>
									</div>
									<div class="form-group">
										<label for="reg-pub-pub-contact">연락처</label>
										<input type="text" class="form-control" id="reg-pub-pub-contact" name="pub_contact"	placeholder="연락처" required>
									</div>
									<div class="form-group">
										<label for="reg-pub-pub-address">주소</label>
										<input type="text" class="form-control" id="reg-pub-pub-address" name="pub_address"	placeholder="주소" required>
									</div>

									<div class="form-group text-right">
										<button type="reset" class="btn btn-warning" id="reset-reg-pub">
											<i class="fa fa-refresh spaceRight"></i>초기화
										</button>
										<button class="btn btn-primary" id="insert-reg-pub">
											<i class="fa fa-check spaceRight"></i>등록
										</button>
									</div>
								</form>
							</div>
						</div>
					</div>
					
					<!-- 거래처 검색 -->
					<div class="tab-pane fade" id="pub-search-tab">
						<div class="card">
							<div class="card-body">
								<form role="form" id="pub-search" method="POST">
									<div class="form-group row justify-content-center">
										<div class="input-group col-sm-10">
											<select class="form-control selectpicker col-sm-3"
												name="searchType" title="검색옵션">
												<option value="pub_name">거래처명</option>
												<option value="pub_rep">대표자명</option>
												<option value="all">전체</option>
											</select> <input type="text" class="form-control" name="keyword">
											<div class="input-group-append">
												<button class="btn btn-primary" id="search">
													<i class="fa fa-search"></i>
												</button>
											</div>
										</div>
									</div>
								</form>
							</div>
						</div>
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
	<form role="form" id="edit-pub" method="POST">
	<input type="hidden" name="pub_uid" id="pub_uid">
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title"></h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
					<table class="table table-boardered">
						<tr>
							<th>거래처명</th>
							<td><input type="text" class="form-control" name="pub_name" placeholder="거래처명" required></td>
						</tr>
						<tr>
							<th>사업자 등록번호</th>
							<td><input type="text" class="form-control" name="pub_num" placeholder="사업자 등록번호" required></td>
						</tr>
						<tr>
							<th>대표자명</th>
							<td><input type="text" class="form-control" name="pub_rep" placeholder="대표자명"></td>
						</tr>
						<tr>
							<th>연락처</th>
							<td><input type="text" class="form-control" name="pub_contact" placeholder="연락처"></td>
						</tr>
						<tr>
							<th>주소</th>
							<td><input type="text" class="form-control" name="pub_address" placeholder="주소"></td>
						</tr>																					
					</table>
				</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<div id="view-btns">
						<button type="button" id="delete" class="btn btn-danger">삭제</button>
						<button type="button" id="update" class="btn btn-success">수정</button>
					</div>
					<div id="update-btns">
						<button type="button" id="cancel" class="btn btn-danger">취소</button>
						<button id="apply" class="btn btn-primary">적용</button>
					</div>
				</div>
			</div>
		</div>
	</form>
</div>
<!-- JS, Popper.js -->
	 <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
	 <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
    <script src="${pageContext.request.contextPath}/JS/navmenu_template.js"></script>
</html>