<%@page import="java.util.ArrayList"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import = "vo.*" %>

<%
	//Controller
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

	int currentPage = 1;
	if(request.getParameter("currentPage") != null ) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 10;
	
	MemberDao memberDao = new MemberDao();
	int memberCount = memberDao.selectMemberCount(); // -> lastPage 계산용
	int lastPage = (int)Math.ceil(((double)(memberCount)/rowPerPage));
	
	if(currentPage < 1) { // 없는 페이지로 이동시 자동 이동
		response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp?currentPage=1");
	} else if(currentPage > lastPage) {
		response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp?currentPage="+lastPage);
	}
	
	int beginRow = (currentPage - 1) * rowPerPage;
	
	//Model 호출
	
	ArrayList<Member> memberList = memberDao.selectMemberListByPage(beginRow, rowPerPage);
	
	
	
	
	//view
%>

<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1" charset="UTF-8">
		<!-- Latest compiled and minified CSS -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
		
		<!-- Latest compiled JavaScript -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
		<title>회원 관리</title>
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
			<div class="mt-4 p-5 bg-primary text-white">
				<h1><label>회원 관리</label></h1>
			</div>
			<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
			
			<div class="mt-2 p-2">
				<!-- memberList contents... -->
				<table class="table table-bordered table-hover">
					<tr>
						<th class="col-sm-1"><label>회원 번호</label></th>
						<th class="col-sm-2"><label>회원 ID</label></th>
						<th class="col-sm-1"><label>회원 레벨</label></th>
						<th class="col-sm-2"><label>회원 이름</label></th>
						<th class="col-sm-2"><label>최신 수정일</label></th>
						<th class="col-sm-2"><label>가입일자</label></th>
						<th class="col-sm-1"><label>레벨 수정</label></th>
						<th class="col-sm-1"><label>탈퇴</label></th>
					</tr>
					<%
						for(Member m : memberList) {
					%>
							<tr>
								<td class="col-sm-1"><label><%=m.getMemberNo() %></label></td>
								<td  class="col-sm-2"><label><%=m.getMemberId() %></label></td>
								<td class="col-sm-1"><label><%=m.getMemberLevel() %></label></td>
								<td  class="col-sm-2"><label><%=m.getMemberName() %></label></td>
								<td  class="col-sm-2"><label><%=m.getUpdatedate() %></label></td>
								<td  class="col-sm-2"><label><%=m.getCreatedate() %></label></td>
								<td class="col-sm-1"><a href="<%=request.getContextPath()%>/admin/member/updateMemberLevelForm.jsp?memberId=<%=m.getMemberId()%>" class="btn btn-primary btn-sm">수정</a></td>
								<td class="col-sm-1"><a href="<%=request.getContextPath()%>/admin/member/deleteMemberByAdminForm.jsp?memberId=<%=m.getMemberId()%>" class="btn btn-danger btn-sm">탈퇴</a></td>
							</tr>
					<%		
						}
					%>
				</table>
				<div class="text-center">
					<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=1" class="btn btn-light">처음</a>
					<%
						if(currentPage > 1) {
					%>
							<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage-1%>"  class="btn btn-light">이전</a>
					<%		
						}
					%>
					<span><label><%=currentPage %> / <%=lastPage %></label></span>
					<%
						if(currentPage < lastPage) {
					%>
							<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage+1%>"  class="btn btn-light">다음</a>
					<%		
						}
					%>
					<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=lastPage%>"  class="btn btn-light">마지막</a>
				</div>
			</div>
		</div>	
	</body>
</html>