<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>

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

	int currentPage = 1;
	//페이징 처리하기 currentPage
	
	int rowPerPage = 10;
	int beginRow = (currentPage-1) * rowPerPage;
	
	HelpDao helpDao = new HelpDao();
	
	ArrayList<HashMap<String,Object>> list = helpDao.selectHelpList(beginRow, rowPerPage);
%>

<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1" charset="UTF-8">
		<!-- Latest compiled and minified CSS -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
		
		<!-- Latest compiled JavaScript -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
		<title>Insert title here</title>
	</head>

	<body>
		<jsp:include page="/inc/header.jsp"></jsp:include>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
		
		<table border="1">
			<tr>
				<th>번호</th>
				<th>문의내용</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>답변내용</th>
				<th>답변일</th>
				<th>답변추가 / 수정 / 삭제</th>				
			</tr>
			<tr>
			<%
				for(HashMap<String,Object> m : list) {
			%>
					<td><%=m.get("helpNo") %></td>
					<td><%=m.get("helpMemo") %></td>
					<td><%=m.get("memberId") %></td>
					<td><%=m.get("helpCreateDate") %></td>
					<td><%=m.get("commentMemo") %></td>
					<td><%=m.get("commentCreateDate") %></td>
					<td>
						<%
							if(m.get("commentMemo") == null) {
						%>
								<a href="<%=request.getContextPath()%>/admin/help/insertCommentForm.jsp?helpNo=<%=m.get("helpNo")%>">답변 입력</a>
						<%
							} else {
						%>
								<a href="<%=request.getContextPath()%>/admin/help/updateCommentForm.jsp?commentNo=<%=m.get("commentNo")%>">답변 수정</a>
								<a href="<%=request.getContextPath()%>/admin/help/deleteComment.jsp?commentNo=<%=m.get("commentNo")%>">답변 삭제</a>
								<!-- 수정 삭제 주소 변경 필요 -->
						<%
							}
						%>
					</td>
					</tr><tr>
			<%
				}
			%>
			</tr>
		</table>
	</body>
</html>