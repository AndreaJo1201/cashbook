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
	
	if(request.getParameter("memberId") == null) { // 삭제하려는 멤버의 id가 없을 시 list 페이지로 이동
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
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<link href="<%=request.getContextPath() %>/css/css/style.css" rel="stylesheet">
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
		<div class="container-fluid">
			<jsp:include page="/inc/header.jsp"></jsp:include>
			<div class="mt-4 p-5 bg-danger text-white">
				<h1>회원 강제 탈퇴</h1>
			</div>
			<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
			
			<div class="table-responsive container-fluid">
				<div class="mt-2 p-2">
					<div class="card">
						<div class="card-body">
							<form action="<%=request.getContextPath()%>/admin/member/deleteMemberByAdminAction.jsp" method="post" id="form">
								<table class="table table-bordered table-hover">
									<thead class="thead-light">
										<tr>
											<th colspan="2">회원 내역</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td class="text-center"><span><strong>회원번호</strong></span></td>
											<td><input type="text" name="memberNo" value="<%=member.getMemberNo() %>" readonly="readonly"></td>
										</tr>
									
										<tr>
											<td class="text-center"><span><strong>회원ID</strong></span></td>
											<td><input type="text" name="memberId" value="<%=member.getMemberId() %>" readonly="readonly"></td>
										</tr>
										<tr>
											<td class="text-center"><span><strong>회원닉네임</strong></span></td>
											<td><input type="text" name="memberName" value="<%=member.getMemberName() %>" readonly="readonly"></td>
										</tr>
										<tr>
											<td class="text-center"><span><strong>회원 레벨</strong></span></td>
											<td>
												<input type="text" name="memberLevel" value="<%=member.getMemberLevel() %>" readonly="readonly">
											</td>
										</tr>
									</tbody>
								</table>
							</form>
						</div>
					</div>
					<div class="d-flex justify-content-between">
						<a href="<%=request.getContextPath() %>/admin/memberList.jsp" class="btn btn-dark btn-sm">뒤로가기</a>
						<button type="submit" class="btn btn-sm btn-outline-danger" form="form">회원추방</button>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</body>
	
</html>