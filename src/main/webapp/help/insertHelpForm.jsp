<%@page import="java.net.URLEncoder"%>
<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>

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
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>문의사항 작성</title>
		<!-- Latest compiled and minified CSS -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
		<!-- Latest compiled JavaScript -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
		<link href="<%=request.getContextPath() %>/css/css/style.css" rel="stylesheet">
		
		<style>
			textarea {
				width:100%;
				height: 400px;
				border: none;
				resize: none;
			}
			
			th {
				vertical-align: middle;
				text-align: center;
			}
		</style>
	</head>

	<body>
		<div class="container-fluid">
		
			<jsp:include page="/inc/header.jsp"></jsp:include>
			<div class="mt-4 p-5 text-white bg-light rounded">
				<h1><label>문의사항 작성</label></h1>
			</div>
			
			<div class="table-responsive container-fluid">
				<div class="mt-2 p-2">
					<div class="card">
						<div class="card-body">
							<form action="<%=request.getContextPath()%>/help/insertHelpAction.jsp" method="post" id="form">
								<table class="table table-bordered">
									<thead class="thead-light">
										<tr>
											<th colspan="2" class="col-sm-12"><label>문의사항 작성</label></th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td class="col-sm-1 text-center"><label><strong>내용</strong></label></td>
											<td class="col-sm-11"><textarea name="helpMemo"></textarea></td>
										</tr>
									</tbody>
								</table>
								<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
							</form>
							
							<div class="d-flex justify-content-between">
								<a href="<%=request.getContextPath()%>/help/helpList.jsp" class="btn btn-dark btn-sm">뒤로가기</a>
								<button type="submit" class="btn btn-outline-success btn-sm" form="form">문의하기</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			
		</div>
	</body>
</html>