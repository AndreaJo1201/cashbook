<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>

<%
	if(session.getAttribute("loginMember") == null) { // 세션 정보가 없을 시 로그인 페이지로 이동
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} else {
		Member loginMember = (Member)session.getAttribute("loginMember");
		if(loginMember.getMemberLevel() < 1) { // 관리자 레벨이 아닐 시 가계부 페이지로 이동
			response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
			return;
		}
	}

	int currentPage = 1;
	if(request.getParameter("currentPage") != null ) { // 현재 페이지 
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 10; // 페이지당 보여줄 갯수
	
	CategoryDao categoryDao = new CategoryDao();
	int categoryCount = categoryDao.selectCategoryCount(); // 총 칼럼 갯수
	int lastPage = (int)Math.ceil(((double)(categoryCount)/rowPerPage)); // 마지막 페이지
	
	if(currentPage < 1) { // 없는 페이지로 이동 시 페이지 자동 이동
		response.sendRedirect(request.getContextPath()+"/admin/categoryList.jsp?currentPage=1");
	} else if(currentPage > lastPage) {
		response.sendRedirect(request.getContextPath()+"/admin/categoryList.jsp?currentPage="+lastPage);
	}
	
	int beginRow = (currentPage - 1) * rowPerPage; // 페이지 가장 첫 글
	
	final int PAGE_COUNT = 10;
	int beginPage = (currentPage-1)/PAGE_COUNT*PAGE_COUNT+1;
	int endPage = beginPage+PAGE_COUNT-1;
	
	
	//Model 호출

	ArrayList<Category> categoryList = categoryDao.selectCategoryListByAdmin();
	
	
	
	//view
%>

<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1" charset="UTF-8">
		<!-- Latest compiled and minified CSS -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
		
		<!-- Latest compiled JavaScript -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
		<link href="<%=request.getContextPath() %>/css/css/style.css" rel="stylesheet">
		<title>CategoryList</title>
		
		<style>		
			th {
				vertical-align: middle;
				text-align: center;
			}
			
			td {
				vertical-align: middle;
				text-align: center;
			}
		</style>
	</head>

	<body>
		<div class="container-fluid">
			<jsp:include page="/inc/header.jsp"></jsp:include>
			<div class="mt-4 p-5 bg-light text-white">
				<h1><label>카테고리</label></h1>
			</div>
			<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
		
			<div class="table-reponsive container-fluid">
				<div class="mt-2 p-2">
					<!-- category contents... -->
					<div class="card">
						<div class="card-body">
							<table class="table table-bordered table-hover">
								<!-- 모델 데이터 카테고리 리스트 출력 -->
								<thead class="thead-light">
									<tr>
										<th class="col-sm-1"><label>번호</label></th>
										<th class="col-sm-1"><label>종류</label></th>
										<th class="col-sm-1"><label>이름</label></th>
										<th class="col-sm-2"><label>갱신일</label></th>
										<th class="col-sm-2"><label>추가일</label></th>
										<th class="col-sm-1"><label>수정</label></th>
										<th class="col-sm-1"><label>삭제</label></th>
									</tr>
								</thead>
								
								<tbody>
								<tr>
									<%
										for(Category c : categoryList) {
									%>
											<td><label><%=c.getCategoryNo() %></label></td>
											<td><label><%=c.getCategoryKind() %></label></td>
											<td><label><%=c.getCategoryName() %></label></td>
											<td><label><%=c.getUpdatedate() %></label></td>
											<td><label><%=c.getCreatedate() %></label></td>
											<td>
												<a href="<%=request.getContextPath()%>/admin/category/updateCategoryForm.jsp?categoryNo=<%=c.getCategoryNo() %>" class="btn btn-primary btn-sm">
													수정
												</a>
											</td>
											<td>
												<a href="<%=request.getContextPath()%>/admin/category/deleteCategoryAction.jsp?categoryNo=<%=c.getCategoryNo() %>" class="btn btn-danger btn-sm">
													삭제
												</a>
											</td>
											</tr><tr class="table-hover">
									<%
										}
									%>
								</tr>
								</tbody>
							</table>
							<div class="text-center">
								<ul class="pagination justify-content-center">				
									<li class="page-item">
										<a href="<%=request.getContextPath()%>/admin/categoryList.jsp?currentPage=1" class="page-link">처음</a>
									</li>
									<%
										if(currentPage > 1){
									%>
											<li class="page-item">
												<a href="<%=request.getContextPath()%>/admin/categoryList.jsp?currentPage=<%=currentPage-1%>" class="page-link">이전</a>
											</li>
									<%
										}
										if(endPage <= lastPage) {
											for(int i=beginPage; i<=endPage; i++){
												if(currentPage == i){
												%>
													<li class="page-item active">
														<a href="<%=request.getContextPath()%>/admin/categoryList.jsp?currentPage=<%=i%>" class="page-link"><%=i%></a>
													</li>
												<%		
												}else{
												%>
													<li class="page-item">
														<a href="<%=request.getContextPath()%>/admin/categoryList.jsp?currentPage=<%=i%>" class="page-link"><%=i%></a>
													</li>
												<%	
												}
											}
										} else if(endPage > lastPage) {
											for(int i=beginPage; i<=lastPage; i++) {
												if(currentPage == i) {
									%>
													<li class="page-item active">
														<a href="<%=request.getContextPath()%>/admin/categoryList.jsp?currentPage=<%=i%>" class="page-link"><%=i%></a>
													</li>
									<%				
												} else {
									%>
													<li class="page-item">
														<a href="<%=request.getContextPath()%>/admin/categoryList.jsp?currentPage=<%=i%>" class="page-link"><%=i%></a>
													</li>
									<%				
												}
											}
										}
										if(currentPage < lastPage){
									%>
											<li class="page-item">
												<a href="<%=request.getContextPath()%>/admin/categoryList.jsp?currentPage=<%=currentPage+1%>" class="page-link">다음</a>
											</li>
									<%
										}
									%>
									<li class="page-item">
										<a href="<%=request.getContextPath()%>/admin/categoryList.jsp?currentPage=<%=lastPage%>" class="page-link">마지막</a>	
									</li>
								</ul>
							</div>

						</div>
					</div>
				</div>
				<div class="d-flex justify-content-end">
					<a href="<%=request.getContextPath()%>/admin/category/insertCategoryForm.jsp" class="btn btn-sm btn-outline-primary">카테고리 추가</a>
				</div>
			</div>
		</div>	
	</body>
</html>