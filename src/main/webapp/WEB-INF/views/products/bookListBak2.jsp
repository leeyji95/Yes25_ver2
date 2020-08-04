<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>도서관리</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="generator" content="Codeply">
<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
</head>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.2/dist/jquery.validate.min.js"></script>
<link rel="stylesheet"	href="${pageContext.request.contextPath}/CSS/navmenu_template.css" />
<style>
[v-cloak]{display : none;}
</style>

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
        <aside id="side-menu" class="aside" role="navigation" style="overflow-y:scroll;">            
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
						<h1 class="display-4 d-none d-sm-block" id="title">도서관리</h1>
					</div>
					<hr>
					<div class="lead mt-5 d-none d-sm-block">
					
						<!-- 시작________________본문____해당파트___삽입하기(내부분)_________________ -->
						<div id="app" v-cloak>
            <v-app>

                <div class="input-group mb-3 row">
                    <div class="form-group input-group-prepend">
                        <select v-model="searchOption" class="form-control">
                            <option value=1>전체</option>
                            <option value=2>제목</option>
                            <option value=3>내용</option>
                            <option value=4>저자</option>
                            <option value=5>출판사</option>
                            <option value=6>카테고리</option>
                        </select>
                    </div>                    
                    <v-autocomplete class="form-control" 
                    v-model="model"
                    :items="searchItems"
                    :search-input.sync="keyword"
                    color="white"
                    hide-no-data
                    hide-selected
                    item-text="subject"
                    item-value="subject"
                    @keyUp.enter="doSearch"
                    >
                </v-autocomplete>
                    <div class="input-group-append">
                        <button class="btn btn-success form-control" type="submit" @click="doSearch">검색</button>
                    </div>
                </div>



                <p>총 {{count}}건</p>
                <div class="form-group row">
                    <div class="col-2">
                        <select v-model="pageRows" class="form-control" @change="getList">
                            <option value=5>5개씩 보기</option>
                            <option value=10>10개씩 보기</option>
                            <option value=20>20개씩 보기</option>
                            <option value=50>50개씩 보기</option>

                        </select>
                    </div>
                </div>

                <table class="table table-hover">
                    <tr v-for="post in posts" :key="post.bookUid">
                        <td style="display: none;">{{post.bookUid}}</td>
                        <td style="height: 200px; width: 24.99%;">
                            <img class="img-thumbnail mx-auto d-block" v-if="post.serName" :src="post.serName"
                                style="max-height: 100%;">
                        </td>
                        <td style="width: 50%;">
                            <h4>[{{post.categoryName}}] <a class="text-dark font-weight-bold" href="#" @click="viewItem"
                                    data-toggle="modal" data-target="#viewModal">{{post.subject}}</a></h4>
                            <h5>{{post.author}} / {{post.pubName}}</h5>
                            <br>
                            <h4>정가: {{post.price | comma}}원</h4>
                        </td>
                        <td style="width: 24.99%;"><a @click.prevent="deleteItem" class="text-danger">삭제</a></td>
                    </tr>
                </table>
                <div class="row">
                    <div class="col-10"></div>
                    <div class="col-2">
                        <button class="btn btn-danger" @click="init">초기화면</button>
                        <button class="btn btn-primary" data-toggle="modal" data-target="#myModal">등록</button>
                    </div>

                </div>

                <ul class="pagination justify-content-center" style="margin:20px 0">
                    <li class="page-item" :class="{disabled : startPage == 1}"><a class="page-link" href="#"
                            @click.prevent="prevPage">Previous</a></li>
                    <li class="page-item" v-for="(n, index) in writePages"
                        :class="{active : page == n + startPage - 1, disabled : n + startPage - 1 > endPage}">
                        <a class="page-link" href="#" @click.prevent="curPage">{{n + startPage - 1}}</a>
                    </li>
                    <li class="page-item" :class="{disabled : startPage > endPage - writePages}"><a class="page-link"
                            href="#" @click.prevent="nextPage">Next</a></li>
                </ul>

                <!-- The Modal -->
                <div class="modal" id="myModal">
                    <div class="modal-dialog modal-lg">
                        <form @submit.prevent="submitForm">
                            <div class="modal-content">

                                <!-- Modal Header -->
                                <div class="modal-header">
                                    <h4 class="modal-title">도서등록</h4>
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                </div>

                                <!-- Modal body -->

                                <div class="modal-body">
                                    <div class="row">
                                        <div class="col-4">
                                            <div class="card" style="height: 200px;" @dragover.prevent
                                                @dragenter.prevent @drop.prevent="onDrop" for="fileinput">
                                                <img class="img-thumbnail mx-auto d-block" v-if="url" :src="url"
                                                    style="max-height: 100%;">
                                                <div class="card-body">

                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-4">
                                            <div class="form-group">
                                                <label for="subject">제목</label>
                                                <input :value="subject" @input="subject=$event.target.value"
                                                    class="form-control">
                                            </div>

                                        </div>
                                        <div class="col-4">
                                            <div class="form-group">
                                                <label for="author">저자</label>
                                                <input :value="author" @input="author=$event.target.value"
                                                    class="form-control">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-4">
                                            <input type="file" @change="onFileChange" accept="image/*" ref="myFileInput"
                                                id="fileinput" style="display: none;">
                                            <label for="fileinput">사진 업로드</label>
                                        </div>
                                        <div class="col-4">
                                            <div class="form-group">
                                                <label for="price">정가</label>
                                                <input v-model.number.trim="price" @input="maxLengthCheck"
                                                    class="form-control" type="number">	
                                            </div>
                                        </div>

                                    </div>
                                    <br>
                                    <div class="row">
                                        <div class="col-4">

                                        </div>
                                        <div class="col-4">
                                            <div class="form-group">
                                                <label for="categoryUid">카테고리</label>
                                                <v-autocomplete v-model="categoryUid" :items="categories"
                                                    :item-text="item => item.rootName + '/' + item.down1Name + '/' + item.down2Name"
                                                    :debounce-search="0" item-value="down2Uid" clearable>

                                                </v-autocomplete>

                                            </div>

                                        </div>
                                        <div class="col-4">
                                            <div class="form-group">
                                                <label for="pubUid">출판사</label>
                                                <v-autocomplete v-model="pubUid" :items="publishers" item-text="pubName"
                                                    :debounce-search="0" item-value="pubUid" clearable>
                                                </v-autocomplete>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-4">
                                            <p>내용</p>
                                        </div>
                                        <div class="col-8">
                                            <div class="form-group">
                                                <textarea :value="content" @input="content=$event.target.value"
                                                    class="form-control"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>


                                <!-- Modal footer -->
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
                                    <button type="button" @click="clearForm" class="btn btn-primary">초기화</button>
                                    <button type="submit" class="btn btn-primary">등록</button>
                                </div>

                            </div>
                        </form>
                    </div>
                </div>

                <!-- The ViewModal -->
                <div class="modal" id="viewModal">
                    <div class="modal-dialog modal-lg">
                        <form @submit.prevent="submitForm">
                            <div class="modal-content">

                                <!-- Modal Header -->
                                <div class="modal-header">
                                    <h4 class="modal-title">도서정보</h4>
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                </div>

                                <!-- Modal body -->

                                <div class="modal-body">
                                    <div class="row">
                                        <div class="col-4">
                                            <div class="card" style="height: 200px;" @dragover.prevent
                                                @dragenter.prevent @drop.prevent="onDrop">
                                                <img class="img-thumbnail mx-auto d-block" v-if="url" :src="url"
                                                    style="max-height: 100%;">
                                                <div class="card-body">

                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-4">
                                            <div class="form-group">
                                                <label for="subject">제목</label>
                                                <input :value="subject" @input="subject=$event.target.value"
                                                    class="form-control" :readonly="!isEditable">
                                            </div>

                                        </div>
                                        <div class="col-4">
                                            <div class="form-group">
                                                <label for="author">저자</label>
                                                <input :value="author" @input="author=$event.target.value"
                                                    class="form-control" :readonly="!isEditable">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-4">
                                            <input type="file" @change="onFileChange" accept="image/*" ref="myFileInput"
                                                :disabled="!isEditable" id="viewfile" style="display: none;">
                                            <label for="viewfile">사진 업로드</label>
                                        </div>
                                        <div class="col-4">
                                            <div class="form-group">
                                                <label for="price">정가</label>
                                                <input v-model.number.trim="price" @input="maxLengthCheck"
                                                    class="form-control" type="number" :readonly="!isEditable">
                                            </div>
                                        </div>

                                    </div>
                                    <br>
                                    <div class="row">
                                        <div class="col-4">

                                        </div>
                                        <div class="col-4">
                                            <div class="form-group">
                                                <label for="categoryUid">카테고리</label>
                                                <v-autocomplete v-model="categoryUid" :items="categories"
                                                    :item-text="item => item.rootName + '/' + item.down1Name + '/' + item.down2Name"
                                                    :debounce-search="0" item-value="down2Uid" clearable
                                                    :disabled="!isEditable">

                                                </v-autocomplete>
                                            </div>
                                        </div>
                                        <div class="col-4">
                                            <div class="form-group">
                                                <label for="pubUid">출판사</label>
                                                <v-autocomplete v-model="pubUid" :items="publishers" item-text="pubName"
                                                    :debounce-search="0" item-value="pubUid" clearable
                                                    :disabled="!isEditable">
                                                </v-autocomplete>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-4">
                                            <p>내용</p>
                                        </div>
                                        <div class="col-8">
                                            <div class="form-group">
                                                <textarea :value="content" @input="content=$event.target.value"
                                                    class="form-control" :readonly="!isEditable"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>


                                <!-- Modal footer -->
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
                                    <button type="button" @click="editMode" class="btn btn-primary"
                                        :disabled="isEditable">수정</button>
                                    <button type="submit" @click.prevent="updateItem" class="btn btn-primary"
                                        :disabled="!isEditable">완료</button>
                                </div>

                            </div>
                        </form>
                    </div>
                </div>

            </v-app>
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
    <script src="${pageContext.request.contextPath}/JS/navmenu_template.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>

    <link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/@mdi/font@5.x/css/materialdesignicons.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/vuetify@2.x/dist/vuetify.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/vuetify@2.x/dist/vuetify.js"></script>
    <script src="${pageContext.request.contextPath}/JS/product/main.js"></script>
</html>