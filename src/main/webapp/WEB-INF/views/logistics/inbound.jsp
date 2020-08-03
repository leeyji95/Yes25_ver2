<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>입고관리</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/logistics/basic.css" />
<link rel="stylesheet"	href="${pageContext.request.contextPath}/CSS/navmenu_template.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="${pageContext.request.contextPath }/JS/logistics/inbound.js"></script>
</head>
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
					<div class="div_title">
					<h1 class="display-4 d-none d-sm-block" id="title">입고관리</h1>
				</div>
					<div class="lead mt-5 d-none d-sm-block">
					
						<!-- 시작________________본문____해당파트___삽입하기(내부분)_________________ -->


												
				<%--버튼 --%>
				<div class="container div_btn">
					<div class="pull-right">
					<button type="button" id="btnQuery" class="btn btn-primary">조회</button>
					<button type="button" id="btnUpdate" class="btn btn-primary">입고</button>
					</div>
				</div>
				
				<form id="query">
				  	<div class="form-group">
				  	<table class="table table-cols">
				  		<tbody>
				  			<tr>
				  				<th>입고상태</th>
				  				<td>
				  					<select name='order_state'>
				  						<option value='1'selected>입고대기</option>
				  						<option value='2'>입고완료</option>
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
								<div class="table-background1">
									<p>총 <span></span>건 검색</p>
								</div>
									<form id="frmList" name="frmList">
									<table class="table table-striped table-main">
										<thead class="thead-inverse">
											<tr>
												<th>번호선택</th>
												<th>입고번호</th>
												<th>주문번호</th>
												<th>도서제목</th>
												<th>ISBN</th>
												<th>매입원가</th>
												<th>입고수량</th>
												<th>발주일자</th>
												<th>입고일자</th>
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
												


						<!-- 끝________________본문____해당파트___삽입하기(내부분)_________________ -->
						
					</div>
				</div>
			</section>
		</div> <!-- </div content> --> 
    </div> <!-- </div wrap -->
   


	<script
		src="http://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
 <!-- JS, Popper.js -->
	 <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
	 <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
    <script src="${pageContext.request.contextPath}/JS/navmenu_template.js"></script>
	<script src="${pageContext.request.contextPath}/JS/scripts.js"></script>
</body>
</html>