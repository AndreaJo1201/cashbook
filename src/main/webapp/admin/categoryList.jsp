<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>

<%
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} else {
		Member loginMember = (Member)session.getAttribute("loginMember");
		if(loginMember.getMemberLevel() < 1) {
			response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
			return;
		}
	}

	int currentPage = 1;
	if(request.getParameter("currentPage") != null ) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 10;
	int beginRow = (currentPage - 1) * rowPerPage;
	
	
	//Model 호출
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryListByAdmin();
	
	int categoryCount = categoryDao.selectCategoryCount();
	int lastPage = (int)Math.ceil(((double)(categoryCount)/rowPerPage));
	
	
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
	<div class="container">
		<jsp:include page="/inc/header.jsp"></jsp:include>
		<div class="mt-4 p-5 bg-primary text-white">
			<h1><label>카테고리</label></h1>
		</div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
		<div class="mt-2 p-2">
			<!-- category contents... -->
			<table class="table table-bordered table-striped">
				<!-- 모델 데이터 카테고리 리스트 출력 -->
				<tr>
					<th class="col-sm-1"><label>번호</label></th>
					<th class="col-sm-1"><label>종류</label></th>
					<th class="col-sm-1"><label>이름</label></th>
					<th class="col-sm-2"><label>갱신일</label></th>
					<th class="col-sm-2"><label>추가일</label></th>
					<th class="col-sm-1"><label>수정</label></th>
					<th class="col-sm-1"><label>삭제</label></th>
				</tr>
				
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
							</tr><tr>
					<%
						}
					%>
				</tr>
				
			</table>
		</div>
		<div class="text-center">
			<a href="<%=request.getContextPath()%>/admin/categoryList.jsp?currentPage=1" class="btn btn-light">처음</a>
			<%
				if(currentPage > 1) {
			%>
					<a href="<%=request.getContextPath()%>/admin/categoryList.jsp?currentPage=<%=currentPage-1%>" class="btn btn-light">이전</a>
			<%		
				}
			%>
			<span><label><%=currentPage %> / <%=lastPage %></label></span>
			<%
				if(currentPage < lastPage) {
			%>
					<a href="<%=request.getContextPath()%>/admin/categoryList.jsp?currentPage=<%=currentPage+1%>" class="btn btn-light">다음</a>
			<%		
				}
			%>
			<a href="<%=request.getContextPath()%>/admin/categoryList.jsp?currentPage=<%=lastPage%>" class="btn btn-light">마지막</a>
		</div>
		<div class="d-flex justify-content-end">
			<a href="<%=request.getContextPath()%>/admin/category/insertCategoryForm.jsp" class="btn btn-sm btn-outline-secondary">카테고리 추가</a>
		</div>
	</div>	
	</body>
</html>