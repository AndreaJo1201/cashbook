<%@page import="vo.Member"%>
<%@page import="dao.MemberDao"%>
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
	
	if(request.getParameter("memberId") == null) {
		response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp");
	}
	
	String deleteMemberId = request.getParameter("memberId");

	MemberDao memberDao = new MemberDao();
	Member member = memberDao.selectMemberByAdmin(deleteMemberId);
%>

<!DOCTYPE html>
<html>
	
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1" charset="UTF-8">
		<!-- Latest compiled and minified CSS -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
		
		<!-- Latest compiled JavaScript -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
		<title>회원 강제 탈퇴</title>
		
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
	<div class="container">
		<jsp:include page="/inc/header.jsp"></jsp:include>
		<div class="mt-4 p-5 bg-danger text-white">
			<h1><label>회원 강제 탈퇴</label></h1>
		</div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
		
		<div class="mt-2 p-2">
			<form action="<%=request.getContextPath()%>/admin/member/deleteMemberByAdminAction.jsp" method="post" id="form">
				<table class="table table-bordered table-hover">
					<tr>
						<th colspan="2" class="table-dark"><label>회원 내역</label></th>
					</tr>
					<tr>
						<th><span><label>회원번호</label></span></th>
						<td><input type="text" name="memberNo" value="<%=member.getMemberNo() %>" readonly="readonly"></td>
					</tr>
				
					<tr>
						<th><span><label>회원ID</label></span></th>
						<td><input type="text" name="memberId" value="<%=member.getMemberId() %>" readonly="readonly"></td>
					</tr>
					<tr>
						<th><span><label>회원닉네임</label></span></th>
						<td><input type="text" name="memberName" value="<%=member.getMemberName() %>" readonly="readonly"></td>
					</tr>
					<tr>
						<th><span><label>회원 레벨</label></span></th>
						<td>
							<input type="text" name="memberLevel" value="<%=member.getMemberLevel() %>" readonly="readonly">
						</td>
					</tr>
				</table>
			</form>
			<div class="d-flex justify-content-between">
				<a href="<%=request.getContextPath() %>/admin/memberList.jsp" class="btn btn-dark btn-sm">뒤로가기</a>
				<button type="submit" class="btn btn-sm btn-outline-danger" form="form">회원추방</button>
			</div>
		</div>
	</div>
	</body>
	
</html>