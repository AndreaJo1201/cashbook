<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>

<%
	if(session.getAttribute("loginMember") != null) {
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
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>

	<body>
		<form action="<%=request.getContextPath()%>/member/insertMemberAction.jsp" method="post">
			<table border="1">
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
			<button type="submit">회원가입</button>
		</form>
	</body>
</html>