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
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>

	<body>
		<form action="<%=request.getContextPath()%>/member/updateMemberPwAction.jsp" method="post">
			<table border="1">
				<tr>
					<td>현재 비밀번호</td>
					<td><input type="password" name="memberPw"></td>
				</tr>
				<tr>
					<td>변경할 비밀번호</td>
					<td><input type="password" name="changePw"></td>
				</tr>
				<tr>
					<td>변경할 비밀번호 확인</td>
					<td><input type="password" name="changePw2"></td>
				</tr>
			</table>
			<button type="submit">수정</button>
		</form>
		
	</body>
</html>