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
	
	if(request.getParameter("msg") != null) {
		String msg = request.getParameter("msg");
		out.println("<script>alert('"+msg+"');</script>");
		msg = null;
	}
	
	if(request.getParameter("helpNo") == null ||
		request.getParameter("helpNo").equals("")) {
			response.sendRedirect(request.getContextPath()+"/help/helpList.jsp");
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
		<title>문의사항 수정</title>
		<!-- Latest compiled and minified CSS -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
		<!-- Latest compiled JavaScript -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
		
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
		<div class="container">
			<jsp:include page="/inc/header.jsp"></jsp:include>
		</div>
		
		<div class="container">
			<div class="mt-4 p-5 text-dark bg-light rounded">
				<h1><label>문의사항 수정</label></h1>
			</div>
			
			<div class="mt-4">
				<table class="table table-bordered">
					<tr>
						<th colspan="2" class="col-sm-12 table-dark"><label>기존 문의내역</label></th>
					</tr>
					<tr>
						<th class="col-sm-1"><label>내용</label></th>
						<td>
							<p><label><%=help.getHelpMemo() %></label></p>
						</td>
					</tr>
				</table>
			</div>
			
			<div class="mt-2 p-2">
				<form action="<%=request.getContextPath()%>/help/updateHelpAction.jsp" method="post" id="form">
					<table class="table table-bordered">
						<tr>
							<th colspan="2" class="table-dark col-sm-12"><label>수정 사항</label></th>
						</tr>
						<tr>
							<th class="col-sm-1"><label>내용</label></th>
							<td class="col-sm-11"><textarea name="helpMemo" placeholder="수정할 내용을 작성해주세요."></textarea></td>
						</tr>
					</table>
					<input type="hidden" name="helpNo" value="<%=help.getHelpNo() %>">	
				</form>
				
				<div class="d-flex justify-content-between">
					<a href="<%=request.getContextPath()%>/help/helpList.jsp" class="btn btn-dark btn-sm">뒤로가기</a>
					<button type="submit" class="btn btn-outline-success btn-sm" form="form">수정</button>
				</div>
			</div>
			
		</div>

	</body>
</html>