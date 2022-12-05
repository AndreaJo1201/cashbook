<%@page import="vo.Member"%>
<%@page import="dao.MemberDao"%>
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

	if(request.getParameter("memberId") == null) { // 수정하려는 멤버의 id값이 없을 시 list 페이지로 이동
		response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp");
	}

	String updateMemberId = request.getParameter("memberId");

	MemberDao memberDao = new MemberDao();
	Member member = memberDao.selectMemberByAdmin(updateMemberId);
	
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
		<title>회원 레벨 수정</title>
		
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
		<div class="container-fluid">
			<jsp:include page="/inc/header.jsp"></jsp:include>
			<div class="mt-4 p-5 bg-light text-white">
				<h1><label>회원 레벨 수정</label></h1>
			</div>
			<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
			
			<div class="table-reponsive container-fluid">
				<div class="mt-2 p-2">
					<div class="card">
						<div class="card-body">
							<form action="<%=request.getContextPath()%>/admin/member/updateMemberLevelAction.jsp" method="post" id="form">
								<table class="table table-boredered table-hover">
									<thead class="thead-light">
										<tr>
											<th colspan="2" class="col-sm-12"><label>회원 내역</label></th> 
										</tr>
									</thead>
									<tbody>
										<tr>
											<td class="text-center col-sm-4"><span><label><strong>회원ID</strong></label></span></td>
											<td class="col-sm-8"><input type="text" name="memberId" value="<%=member.getMemberId() %>" readonly="readonly"></td>
										</tr>
										<tr>
											<td class="text-center col-sm-4"><span><label><strong>회원닉네임</strong></label></span></td>
											<td class="col-sm-8"><input type="text" name="memberName" value="<%=member.getMemberName() %>" readonly="readonly"></td>
										</tr>
										<tr>
											<td class="text-center col-sm-4"><label><strong>회원 레벨</strong></label></td>
											<td class="col-sm-8">
												<%
													if(member.getMemberLevel() == 1) {
												%>
														<input type="radio" name ="memberLevel" value="0"><span class="p-2"><label><strong>일반회원</strong></label></span>
														<input type="radio" name ="memberLevel" value="1" checked="checked"><span class="p-2"><label><strong>관리자</strong></label></span>
												<%
													} else {
												%>
														<input type="radio" name ="memberLevel" value="0" checked="checked"><span class="p-2"><label><strong>일반회원</strong></label></span>
														<input type="radio" name ="memberLevel" value="1"><span class="p-2"><label><strong>관리자</strong></label></span>
												<%
													}
												%>
												
											</td>
										</tr>
									</tbody>		
								</table>
								<input type="hidden" name="memberNo" value="<%=member.getMemberNo()%>">
							</form>
						</div>
					</div>				
					<div class="d-flex justify-content-between">
						<a href="<%=request.getContextPath() %>/admin/memberList.jsp" class="btn btn-dark btn-sm">뒤로가기</a>
						<button type="submit" class="btn btn-sm btn-outline-secondary" form="form">수정</button>
					</div>
				</div>
			</div>
		</div>
	</body>
	
</html>