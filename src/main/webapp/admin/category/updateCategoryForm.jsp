<%@page import="vo.Category"%>
<%@page import="dao.CategoryDao"%>
<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>

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
	
	if(request.getParameter("categoryNo") == null) { // 수정하려는 카테고리 넘버가 없을 시 list 페이지로 이동
		response.sendRedirect(request.getContextPath()+"/admin/categoryList.jsp");
	}
	
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	CategoryDao categoryDao = new CategoryDao();
	Category categoryOne = categoryDao.selectCategoryOne(categoryNo);
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>카테고리 수정</title>
		<!-- Latest compiled and minified CSS -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
		<!-- Latest compiled JavaScript -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
		
		<style>
			th {
				vertical-align: middle;
				text-align: center;
			}
			
			.alignCenter {
				vertical-align: middle;
				text-align: center;
			}
			
			input {
				width: 100%
			}
		</style>
		
	</head>

	<body>
		<div class="container">
			<jsp:include page="/inc/header.jsp"></jsp:include>
			<div class="mt-4 p-5 bg-primary text-white">
				<h1><label>카테고리 수정</label></h1>
			</div>
			<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
			
			<div class="mt-4">
				<form action="<%=request.getContextPath()%>/admin/category/updateCategoryAction.jsp" method="post" id="form">
					<table class="table table-bordered">
						<tr>
							<th class="col-sm-2">카테고리 번호</th>
							<th class="col-sm-2">카테고리 종류</th>
							<th class="col-sm-8">카테고리 이름</th>
	
						</tr>
						<tr>
							<td class="col-sm-2 alignCenter"><%=categoryOne.getCategoryNo() %></td>
							<td class="col-sm-2 alignCenter"><%=categoryOne.getCategoryKind() %></td>
							<td class="col-sm-8"><input type="text" name ="categoryName" value="<%=categoryOne.getCategoryName() %>"></td>
						</tr>
					</table>
					<input type="hidden" name="categoryNo" value="<%=categoryOne.getCategoryNo() %>">
				</form>
				<div class="d-flex justify-content-between">
					<a href="<%=request.getContextPath()%>/admin/categoryList.jsp" class="btn btn-dark btn-sm">뒤로가기</a>
					<button type="submit" class="btn btn-sm btn-outline-secondary" form="form">수정</button>
				</div>
			</div>
		</div>
	</body>
</html>