<%@page import="vo.Help"%>
<%@page import="dao.HelpDao"%>
<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>

<%
	if(session.getAttribute("loginMember") == null) { // 세션 정보가 없을 시 로그인 페이지로 이동
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} else {
		Member loginMember = (Member)session.getAttribute("loginMember");
		if(loginMember.getMemberLevel() < 1) { // 관리자 레벨이 아닐 시 가계부 페이지로 이동
			response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
			return;
		}
	}
	
	if(request.getParameter("helpNo") == null ||
		request.getParameter("helpNo").equals("")) { // 답변 달려는 문의사항 식별 번호가 없을 시 문의 list로 이동
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
		<meta name="viewport" content="width=device-width, initial-scale=1" charset="UTF-8">
		<!-- Latest compiled and minified CSS -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
		
		<!-- Latest compiled JavaScript -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
		<title>문의사항 답변 작성</title>
		<style>		
			th {
				vertical-align: middle;
				text-align: center;
			}
			
			td {
				vertical-align: middle;
				text-align: center;
			}
			
			textarea {
				width:100%;
				height: 400px;
				border: none;
				resize: none;
			}
		</style>
	</head>

	<body>
	<div class='container'>
		<jsp:include page="/inc/header.jsp"></jsp:include>
		<div class="mt-4 p-5 bg-primary text-white">
			<h1><label>문의사항 답변 작성</label></h1>
		</div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
		
		<div class="mt-4">
			<table class="table table-bordered">
				<tr>
					<th colspan="2" class="col-sm-12 table-dark"><label>회원 문의사항</label></th>
				</tr>
				<tr>
					<th class="col-sm-1"><label>문의내용</label></th>
					<td class="col-sm-11"><p><label><%=help.getHelpMemo() %></label></p></td>
				</tr>
				<tr>
					<th class="col-sm-1"><label>작성자</label></th>
					<td class="col-sm-11"><span><label><%=help.getMemberId() %></label></span></td>
				</tr>
				<tr>
					<th class="col-sm-1"><label>작성일</label></th>
					<td class="col-sm-11"><span><label><%=help.getCreatedate() %></label></span></td>
				</tr>
			</table>
		</div>
		
		<div class="mt-2 p-2">
			<form action="<%=request.getContextPath()%>/admin/help/insertCommentAction.jsp" method="post" id="form">
				<table class="table table-bordered">
					<tr>
						<th colspan="2" class="table-dark col-sm-12"><label>답변 작성</label></th>
					</tr>
					<tr>
						<th class="col-sm-1"><label>답변</label></th>
						<td class="col-sm-11"><textarea name="commentMemo" placeholder="코멘트를 입력해주세요."></textarea></td>
					</tr>
				</table>
				<input type="hidden" name="helpNo" value="<%=helpNo %>">
			</form>
			<div class="d-flex justify-content-between">
				<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp" class="btn btn-dark btn-sm">뒤로가기</a>
				<button type="submit" class="btn btn-outline-success btn-sm" form="form">답변작성</button>
			</div>
		</div>
	</div>	
	</body>
</html>