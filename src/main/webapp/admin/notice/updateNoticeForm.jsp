<%@page import="dao.NoticeDao"%>
<%@page import="vo.Notice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>

<%
	

	if(request.getParameter("noticeNo") == null ||
		request.getParameter("noticeNo").equals("")) {
			response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp");
			return;
	}
	
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	
	NoticeDao noticeDao = new NoticeDao();
	Notice noticeByNo = noticeDao.selectNoticeByNo(noticeNo);
	

%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>

	<body>
		<h1>공지사항 수정</h1>
		
		<form action="<%=request.getContextPath()%>/admin/notice/updateNoticeAction.jsp">
			<table border="1">
				<tr>
					<th colspan="2">공지사항 수정</th>	
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea name="noticeMemo" cols="50" rows="20"><%=noticeByNo.getNoticeMemo()%></textarea></td>
				</tr>
			</table>
			<input type="hidden" name="noticeNo" value="<%=noticeByNo.getNoticeNo()%>">
			<button type="submit">수정</button>
		</form>
		
		<div>
			<a href="<%=request.getContextPath()%>/admin/noticeList.jsp">뒤로가기</a>
		</div>
	</body>
</html>