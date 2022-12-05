<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>

<%
	if(session.getAttribute("loginMember") == null) { // 세션 정보가 없을시 로그인 페이지로 이동
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} else {
		Member loginMember = (Member)session.getAttribute("loginMember");
		if(loginMember.getMemberLevel() < 1) { // 관리자 레벨이 아닐 시 가계부 페이지로 이동
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
		
		<link href="<%=request.getContextPath() %>/css/css/style.css" rel="stylesheet">
		
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
		<div class="container-fluid">
			<jsp:include page="/inc/header.jsp"></jsp:include>
			<div class="mt-4 p-5 bg-light text-white">
				<h1><label>카테고리 추가</label></h1>
			</div>
			<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
			
			<div class="table-responsive container-fluid">
				<div class="mt-2 p-2">
					<div class="card">
						<div class="card-body">
							<form action="<%=request.getContextPath()%>/admin/category/insertCategoryAction.jsp" method="post" id="form">
								<table class="table table-bordered">
									<thead class="thead-light">
										<tr>
											<th class="col-sm-12" colspan="2">카테고리 추가</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td class="col-sm-2 text-center"><label><strong>카테고리 종류</strong></label></td>
											<td class="col-sm-10">
												<input type="radio" name="categoryKind" value="수입"><label>수입</label>
												<input type="radio" name="categoryKind" value="지출"><label>지출</label>
											</td>
										</tr>
										<tr>
											<td class="col-sm-2 text-center"><label><strong>카테고리 이름</strong></label></td>
											<td class="col-sm-10"><input type="text" name="categoryName" placeholder="카테고리 이름을 입력해주세요." class="NameCategory"></td>
										</tr>
									</tbody>
								</table>
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
	</body>
</html>