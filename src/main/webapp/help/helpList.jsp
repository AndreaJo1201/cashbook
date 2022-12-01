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
		<link href="<%=request.getContextPath() %>/css/css/style.css" rel="stylesheet">
		<title>개인 문의내역</title>
		
		<style>
			#login {
			  height: 100px;
			  width: 500px;
			  margin: auto;
			  text-align: center;
			}
			
			th {
				vertical-align: middle;
				text-align: center;
			}
			
			td {
				vertical-align: middle;
				text-align: center;
			}
		</style>
	</head>

	<body>
		<div class="container">
			<jsp:include page="/inc/header.jsp"></jsp:include>
		</div>
		
		<div class="container">
			<div class="mt-4 p-5 text-dark bg-light rounded">
				<h1><label>개인 문의 내역</label></h1>
			</div>
			
			<div class="mt-2">
				<table class="table table-bordered table-hover">
					<tr class="table-dark">
						<th colspan="7"><label>문의하기</label></th>
					</tr>
					<tr>
						<th><label>번호</label></th>
						<th><label>문의내용</label></th>
						<th><label>작성자</label></th>
						<th><label>작성일</label></th>
						<th><label>답변일</label></th>
						<th><label>수정</label></th>
						<th><label>삭제</label></th>
					</tr>
					<tr>
					<%
						for(HashMap<String, Object> h : helpList) {
					%>
							<td><label><%=h.get("helpNo") %></label></td>
							<td><a href="<%=request.getContextPath() %>/help/helpListOne.jsp?helpNo=<%=h.get("helpNo") %>" class="text-decoration-none"><%=h.get("helpMemo") %></a></td>
							<td><label><%=h.get("memberId") %></label></td>
							<td><label><%=h.get("helpCreatedate") %></label></td>
							<td>
								<%
									if(h.get("commentCreateDate") == null) {
								%>
										<label>답변대기중</label>
								<%
									} else {
								%>
										<label><%=h.get("commentCreateDate") %></label>
								<%
									}
								%>
							</td>
							<td>
								<%
									if(h.get("commentMemo") == null) {
								%>
										<a href="<%=request.getContextPath() %>/help/updateHelpForm.jsp?helpNo=<%=h.get("helpNo") %>" class="btn btn-outline-primary btn-sm">수정</a>
								<%
									}
								%>
							</td>
							<td>
								<%
									if(h.get("commentMemo") == null) {
								%>
										<a href="<%=request.getContextPath() %>/help/deleteHelpAction.jsp?helpNo=<%=h.get("helpNo") %>" class="btn btn-outline-danger btn-sm">삭제</a>
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
			
			<div class="d-flex justify-content-end">
				<a href="<%=request.getContextPath()%>/help/insertHelpForm.jsp" class="btn btn-dark btn-sm">문의하기</a>
			</div>
		</div>

	</body>
</html>