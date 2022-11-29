<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<%
	if(session.getAttribute("loginMember") == null) {
		String msg = "로그인이 필요합니다.";
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
		return;
	}

	if(request.getParameter("msg") != null) {
		String msg = request.getParameter("msg");
		out.println("<script>alert('"+msg+"');</script>");
		msg = null;
	}
	
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	
	Help help = new Help();
	help.setMemberId(memberId);
	
	HelpDao helpDao = new HelpDao();
	
	ArrayList<HashMap<String, Object>> helpList = helpDao.selectHelpList(help);
%>

<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1" charset="UTF-8">
		<!-- Latest compiled and minified CSS -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
		
		<!-- Latest compiled JavaScript -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
		<title>개인 문의내역</title>
		
		<style>
			#login {
			  height: 100px;
			  width: 500px;
			  margin: auto;
			  text-align: center;
			}
		</style>
	</head>

	<body>
		<div>
			<h1>개인 문의내역</h1>
			<table border="1">
				<tr>
					<th>번호</th>
					<th>문의내용</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>답변일</th>
					<th>수정</th>
					<th>삭제</th>
				</tr>
				<tr>
				<%
					for(HashMap<String, Object> h : helpList) {
				%>
						<td><%=h.get("helpNo") %></td>
						<td><%=h.get("helpMemo") %></td>
						<td><%=h.get("memberId") %></td>
						<td><%=h.get("helpCreatedate") %></td>
						<td>
							<%
								if(h.get("commentCreateDate") == null) {
							%>
									답변대기중
							<%
								} else {
							%>
									<%=h.get("commentCreateDate") %>
							<%
								}
							%>
						</td>
						<td>
							<%
								if(h.get("commentMemo") == null) {
							%>
									<a href="">수정</a>
							<%
								}
							%>
						</td>
						<td>
							<%
								if(h.get("commentMemo") == null) {
							%>
									<a href="">삭제</a>
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
		</div>
		<div>
			<a href="<%=request.getContextPath()%>/help/insertHelpForm.jsp">문의하기</a>
		</div>
		<!-- 
		<div>
			<jsp:include page="/inc/footer.jsp"></jsp:include>
		</div>
		-->
	</body>
</html>