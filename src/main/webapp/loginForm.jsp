<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import = "java.sql.*" %>

<%

%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>LOGIN</title>
	</head>

	<body>
		<h1>LOGIN</h1>
		<form action="<%=request.getContextPath()%>/loginAction.jsp">
			<table>
				<tr>
					<td>ID</td>
					<td><input type="text" name="memberId"></td>
				</tr>
				<tr>
					<td>PW</td>
					<td><input type="password" name="memberPw"></td>
				</tr>
			</table>
			<button type="submit">login</button>
		</form>
	</body>
</html>