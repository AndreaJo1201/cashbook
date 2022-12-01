<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import= "java.net.*" %>

<%
	if(session.getAttribute("loginMember") == null) { //비 로그인 페이지 접속 시 로그인 폼으로 안내
		String msg = "로그인이 필요합니다.";
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
		return;
	}
	
	if(request.getParameter("msg") != null) {
		String msg = request.getParameter("msg");
		out.println("<script>alert('"+msg+"');</script>");
		msg = null;
	}

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
		<title>UPDATE PW</title>
		
		<style>
			#update {
			  height: 100px;
			  width: 500px;
			  margin: auto;
			  text-align: center;
			}
		</style>
	</head>

	<body>
	<div class="container">
		<jsp:include page="/inc/header.jsp"></jsp:include>
		<div class="container" id="update">
			<div class="mt-4 p-4 text-dark">
				<h1><label>회원 비밀번호 수정</label></h1>
			</div>
			<form action="<%=request.getContextPath()%>/member/updateMemberPwAction.jsp" method="post">
				<table class="table table-bordered">
					<tr>
						<td><label>현재 비밀번호</label></td>
						<td><input type="password" name="memberPw"></td>
					</tr>
					<tr>
						<td><label>변경할 비밀번호</label></td>
						<td><input type="password" name="changePw"></td>
					</tr>
					<tr>
						<td><label>변경할 비밀번호 확인</label></td>
						<td><input type="password" name="changePw2"></td>
					</tr>
				</table>
				<div class="d-grid">
					<button type="submit" class="btn btn-primary btn-lg btn-block">수정</button>
				</div>
			</form>
		</div>
	</div>	
	</body>
</html>