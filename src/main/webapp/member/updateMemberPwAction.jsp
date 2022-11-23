<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import ="java.net.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>

<%
	if(session.getAttribute("loginMember") == null) { //비 로그인 페이지 접속 시 로그인 폼으로 안내
		String msg = "로그인이 필요합니다.";
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
		return;
	}

	if(request.getParameter("memberPw") == null ||
	request.getParameter("memberPw").equals("") ||
	request.getParameter("changePw") == null ||
	request.getParameter("changePw").equals("") ||
	request.getParameter("changePw2") == null ||
	request.getParameter("changePw2").equals("")) {
		String msg = "빈칸을 입력해주세요.";
		response.sendRedirect(request.getContextPath()+"/member/updateMemberPwForm.jsp?msg="+URLEncoder.encode(msg,"UTF-8"));
		return;
	} else if(!request.getParameter("changePw").equals(request.getParameter("changePw2"))) {
		String msg = "변경할 비밀번호가 일치하지않습니다.";
		response.sendRedirect(request.getContextPath()+"/member/updateMemberPwForm.jsp?msg="+URLEncoder.encode(msg,"UTF-8"));
		return;
	}
	
	String msg = null; // 성공여부 전달할 msg
	
	String memberPw = request.getParameter("memberPw");
	String changePw = request.getParameter("changePw");
	String changePw2 = request.getParameter("changePw2");
	
	Member paramMember = (Member)session.getAttribute("loginMember");
	paramMember.setMemberPw(memberPw);
	
	MemberDao memberDao = new MemberDao();
	
	int updateMemberPwCheck = memberDao.updateMemberPw(paramMember, changePw);
	if(updateMemberPwCheck == 0) {
		System.out.println("업데이트 실패");
		msg = "업데이트 실패(사유:현재 비밀번호 불일치)";
		response.sendRedirect(request.getContextPath()+"/member/updateMemberPwForm.jsp?msg="+URLEncoder.encode(msg,"UTF-8"));
		return;
	} else {
		System.out.println("업데이트 성공");
		msg = "업데이트 성공, 다시 로그인 하십시오.";
	}
	
	session.invalidate();
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
	
%>

