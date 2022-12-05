<%@page import="dao.HelpDao"%>
<%@page import="vo.Help"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>

<%
	if(session.getAttribute("loginMember") == null) { //비 로그인 페이지 접속 시 로그인 폼으로 안내
		String msg = "로그인이 필요합니다.";
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
		return;
	}
	
	if(request.getParameter("helpNo") == null ||
		request.getParameter("helpNo").equals("")) {
			response.sendRedirect(request.getContextPath()+"/help/helpList.jsp");
			return;
	}
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	
	HelpDao helpDao = new HelpDao();
	Help help = helpDao.selectHelp(helpNo);
	
	//test commit
	
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>문의사항 수정</title>
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
		
			<div class="mt-4 p-5 text-dark bg-light rounded">
				<h1><label>문의사항 수정</label></h1>
			</div>
			
			<div class="table-responsive container-fluid">
				<div class="mt-4">
					<div class="card">
						<div class="card-body">
							<table class="table table-bordered">
								<thead class="thead-light">
									<tr>
										<th colspan="2" class="col-sm-12"><label><strong>기존 문의내역</strong></label></th>
									</tr>
								</thead>
								<tbody>
								<tr>
									<td class="col-sm-1 text-center"><label><strong>내용</strong></label></td>
									<td class="col-sm-11">
										<p><label><%=help.getHelpMemo() %></label></p>
									</td>
								</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<%
	             	if(request.getParameter("msg") != null) {
	             %>
	             		<div class="alert alert-danger mt-1 alert-dismissible">
	             			<label><%=request.getParameter("msg") %></label>
	             			<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
	             		</div>
	             <%
	             	}
	             %>
				<div class="mt-2 p-2">
					<div class="card">
						<div class="card-body">
							<form action="<%=request.getContextPath()%>/help/updateHelpAction.jsp" method="post" id="form">
								<table class="table table-bordered">
									<thead class="thead-light">
										<tr>
											<th colspan="2" class="col-sm-12"><label>수정 사항</label></th>
										</tr>
									</thead>
									<tr>
										<td class="col-sm-1 text-center"><label><strong>내용</strong></label></td>
										<td class="col-sm-11"><textarea name="helpMemo" placeholder="수정할 내용을 작성해주세요."></textarea></td>
									</tr>
								</table>
								<input type="hidden" name="helpNo" value="<%=help.getHelpNo() %>">	
							</form>
						</div>
					</div>
					
					<div class="d-flex justify-content-between">
						<a href="<%=request.getContextPath()%>/help/helpList.jsp" class="btn btn-dark btn-sm">뒤로가기</a>
						<button type="submit" class="btn btn-outline-success btn-sm" form="form">수정</button>
					</div>	
				</div>
			</div>
		</div>
	</body>
</html>