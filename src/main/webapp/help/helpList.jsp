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
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<link href="<%=request.getContextPath() %>/css/css/style.css" rel="stylesheet">
		<title>개인 문의내역</title>
		
		<style>		
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
	<div class="main-wrapper">
		
		<jsp:include page="/inc/header.jsp"></jsp:include>
			
		<div class="content-body">
			<div class="container-fliud table-reponsive mt-2">
				<div class="container-fluid">
					<div class="mt-2 card" >
						<div class="card-body mt-4 p-5">
							<h1>개인 문의 내역</h1>
						</div>
					</div>
				</div>
				<%
					if(request.getParameter("msg") != null) {
				%>
						<div class="alert alert-danger mt-1 alert-dismissible fade show">
							<%=request.getParameter("msg") %>
							<button type="button" class="close" data-dismiss="alert" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
				<%
					}
				%>
			
				<div class="table-responsive container-fluid">
					<div class="mt-2 p-2">
						<div class="card">
							<div class="card-body">
								<table class="table table-bordered table-hover">
									<thead class="thead-light">
										<tr>
											<th colspan="7">문의하기</th>
										</tr>
										<tr>
											<td><strong>번호</strong></td>
											<td><strong>문의내용</strong></td>
											<td><strong>작성자</strong></td>
											<td><strong>작성일</strong></td>
											<td><strong>답변일</strong></td>
											<td><strong>수정</strong></td>
											<td><strong>삭제</strong></td>
										</tr>
									</thead>
									<tbody>
										<tr>
										<%
											for(HashMap<String, Object> h : helpList) {
										%>
												<td><%=h.get("helpNo") %></td>
												<td><a href="<%=request.getContextPath() %>/help/helpListOne.jsp?helpNo=<%=h.get("helpNo") %>" class="text-decoration-none"><%=h.get("helpMemo") %></a></td>
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
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<div class="d-flex justify-content-end">
						<a href="<%=request.getContextPath()%>/help/insertHelpForm.jsp" class="btn btn-dark btn-sm">문의하기</a>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
	</body>
</html>