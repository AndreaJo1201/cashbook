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
		<title>카테고리 수정</title>
		<meta name="viewport" content="width=device-width, initial-scale=1" charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<link href="<%=request.getContextPath() %>/css/css/style.css" rel="stylesheet">
		
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
		<div class="container-fluid">
			<jsp:include page="/inc/header.jsp"></jsp:include>
			<div class="mt-4 p-5 bg-light text-white">
				<h1>카테고리 수정</h1>
			</div>
			<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
			
			<div class="table-responsive container-fluid">
				<div class="mt-4">
					<div class="card">
						<div class="card-body">
							<form action="<%=request.getContextPath()%>/admin/category/updateCategoryAction.jsp" method="post" id="form">
								<table class="table table-bordered">
									<thead class="thead-light">
										<tr>
											<th class="col-sm-2">카테고리 번호</th>
											<th class="col-sm-2">카테고리 종류</th>
											<th class="col-sm-8">카테고리 이름</th>
					
										</tr>
									</thead>
									<tbody>
										<tr>
											<td class="col-sm-2 alignCenter"><%=categoryOne.getCategoryNo() %></td>
											<td class="col-sm-2 alignCenter"><%=categoryOne.getCategoryKind() %></td>
											<td class="col-sm-8"><input type="text" name ="categoryName" value="<%=categoryOne.getCategoryName() %>"></td>
										</tr>
									</tbody>
								</table>
								<input type="hidden" name="categoryNo" value="<%=categoryOne.getCategoryNo() %>">
							</form>
						</div>
					</div>
					<div class="d-flex justify-content-between">
						<a href="<%=request.getContextPath()%>/admin/categoryList.jsp" class="btn btn-dark btn-sm">뒤로가기</a>
						<button type="submit" class="btn btn-sm btn-outline-secondary" form="form">수정</button>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</body>
</html>