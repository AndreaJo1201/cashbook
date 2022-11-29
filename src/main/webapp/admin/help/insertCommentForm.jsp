<%@page import="vo.Help"%>
<%@page import="dao.HelpDao"%>
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
	
	if(request.getParameter("helpNo") == null ||
		request.getParameter("helpNo").equals("")) {
			response.sendRedirect(request.getContextPath()+"/admin/helpListAll.jsp");
			return;
	}
	
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	
	HelpDao helpDao = new HelpDao();
	Help help = helpDao.selectHelp(helpNo);
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>문의 답변 작성</title>
	</head>

	<body>
		<table border="1">
			<tr>
				<th>문의내용</th>
				<td><textarea name="helpMemo"><%=help.getHelpMemo() %></textarea></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><span><label><%=help.getMemberId() %></label></span></td>
			</tr>
			<tr>
				<th>작성일</th>
				<td><span><label><%=help.getCreatedate() %></label></span></td>
			</tr>
		</table>
		
		<form action="<%=request.getContextPath()%>/admin/help/insertCommentAction.jsp" method="post">
			<table border="1">
				<tr>
					<th>답변</th>
					<td><textarea name="commentMemo"></textarea></td>
				</tr>
			</table>
			<button type="submit">답변작성</button>
			<input type="hidden" name="helpNo" value="<%=helpNo %>">
		</form>
	</body>
</html>