<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>

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
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>카테고리 추가</title>
		<!-- Latest compiled and minified CSS -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
		<!-- Latest compiled JavaScript -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
		
		<style>
			th {
				vertical-align: middle;
				text-align: center;
			}
			
			.NameCategory {
				width: 50%
			}
		</style>
	</head>

	<body>
	<div class="container">
		<jsp:include page="/inc/header.jsp"></jsp:include>
		<div class="mt-4 p-5 bg-primary text-white">
			<h1><label>카테고리 추가</label></h1>
		</div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
		
		<div class="mt-2 p-2">
			<form action="<%=request.getContextPath()%>/admin/category/insertCategoryAction.jsp" method="post" id="form">
				<table class="table table-bordered">
					<tr>
						<th class="col-sm-2"><label>카테고리 종류</label></th>
						<td class="col-sm-10">
							<input type="radio" name="categoryKind" value="수입"><label>수입</label>
							<input type="radio" name="categoryKind" value="지출"><label>지출</label>
						</td>
					</tr>
					<tr>
						<th class="col-sm-2"><label>카테고리 이름</label></th>
						<td class="col-sm-10"><input type="text" name="categoryName" placeholder="카테고리 이름을 입력해주세요." class="NameCategory"></td>
					</tr>
				</table>
			</form>
			<div class="d-flex justify-content-between">
				<a href="<%=request.getContextPath()%>/admin/categoryList.jsp" class="btn btn-dark btn-sm">뒤로가기</a>
				<button type="submit" class="btn btn-outline-secondary btn-sm" form="form">추가</button>
			</div>
			
		</div>
	</div>
	</body>
</html>