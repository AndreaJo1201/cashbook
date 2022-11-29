<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>

<%
	Member loginMember = (Member)session.getAttribute("loginMember");
%>

<div class="row mt-2 p-2">
	<div class="dropdown text-start col-sm-6">
		<span><label><%=loginMember.getMemberName() %>님 반갑습니다.</label></span>
		<button type="button" class="btn btn-dark btn-sm dropdown-toggle" data-bs-toggle="dropdown">내 정보</button>
		<ul class="dropdown-menu">
			<li><a href="<%=request.getContextPath()%>/cash/cashList.jsp" class="dropdown-item">cashBook</a></li>
			<li><hr class="dropdown-divider"></hr></li>
			<%
				if(loginMember.getMemberLevel() < 1) {
			%>
					<li><a href="<%=request.getContextPath()%>/help/helpList.jsp" class="dropdown-item">문의내역</a></li>
			<%
				} else {
			%>
					<li><a href="<%=request.getContextPath()%>/admin/adminMain.jsp" class="dropdown-item">관리자 페이지</a></li>
			<%
				}
			%>
			<li><hr class="dropdown-divider"></hr></li>
			<li><a href="<%=request.getContextPath()%>/member/updateMemberForm.jsp" class="dropdown-item">회원정보 수정</a><li>
			<li><a href="<%=request.getContextPath()%>/member/updateMemberPwForm.jsp" class="dropdown-item">비밀번호 수정</a></li>
			<li><hr class="dropdown-divider"></hr></li>
			<li><a href="<%=request.getContextPath()%>/member/deleteMemberForm.jsp" class="dropdown-item">회원 탈퇴</a></li>
		</ul>
	</div>
	<div class="text-end col-sm-6">
		<a href="<%=request.getContextPath()%>/logout.jsp" class="btn-dark btn btn-sm">로그아웃</a>
	</div>
</div>