<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>

<%
	if(session.getAttribute("loginMember") != null) { //로그인 상태로는 접속 불가, 로그인 상태일시 가계부 페이지로 이동
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
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
		<title>SIGN UP</title>
		
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
		<div class="mt-2 p-2 text-end">
			<span><a href="<%=request.getContextPath()%>/loginForm.jsp" class="btn btn-sm btn-dark">뒤로가기</a></span>
		</div>
		
		<div class="container" id="update">
			<div class="mt-4 p-4 text-white bg-dark">
				<h1><label>회원가입</label></h1>
			</div>
			<form action="<%=request.getContextPath()%>/member/insertMemberAction.jsp" method="post">
				<table class="table table-bordered">
					<tr>
						<td>ID</td>
						<td><input type="text" name="memberId"></td>
					</tr>
					<tr>
						<td>PW</td>
						<td><input type="password" name="memberPw"></td>
					</tr>
					<tr>
						<td>닉네임</td>
						<td><input type="text" name="memberName"></td>
					</tr>
				</table>
				<div class="d-grid">
					<button type="submit" class="btn btn-dark btn-block">회원가입</button>
				</div>
			</form>
		</div>
	</div>	
	</body>
</html>