<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>

<%

%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>

	<body>
		<div>
			<h1>회원탈퇴</h1>
			<form action="<%=request.getContextPath()%>/member/deleteMemberAction.jsp">
				<table>
					<tr>
						<td>ID 확인</td>
						<td><input type="text" name ="memberId"></td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><input type="password" name="memberPw"></td>
					</tr>
					<tr>
						<td>비밀번호 확인</td>
						<td><input type="password" name="memberPwCheck"></td>
					</tr>
				</table>
				<button type="submit">탈퇴</button>
			</form>
		</div>
	</body>
</html>