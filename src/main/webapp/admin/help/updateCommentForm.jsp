<%@page import="vo.Comment"%>
<%@page import="dao.CommentDao"%>
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
	
	if(request.getParameter("commentNo") == null ||
		request.getParameter("commentNo").equals("")) {
			response.sendRedirect(request.getContextPath()+"/admin/helpListAll.jsp");
			return;
	}
	
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	
	CommentDao commentDao = new CommentDao();
	Comment comment = commentDao.selectCommentOne(commentNo);
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>

	<body>
		<table>
			<tr>
				<th>이전 답변내용</th>
			</tr>
			<tr>
				<td><%=comment.getCommentMemo() %></td>
			</tr>
		</table>
		<form action="<%=request.getContextPath()%>/admin/help/updateCommentAction.jsp" method="post">
			<table border="1">
				<tr>
					<th>답변내용</th>
					<td><textarea name="commentMemo"></textarea></td>
				</tr>
				<tr>
					<th>작성일</th>
					<td><span><label><%=comment.getCreatedate() %></label></span></td>
				</tr>
				<tr>
					<th>수정일</th>
					<td><span><label><%=comment.getUpdatedate() %></label></span></td>
				</tr>
			</table>
			<button type="submit">수정</button>
			<input type="hidden" name="commentNo" value="<%=comment.getCommentNo() %>">
		</form>
	</body>
</html>