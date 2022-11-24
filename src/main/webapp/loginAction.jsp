<%@page import="java.net.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>

<%
	// 1) controller
	if(session.getAttribute("loginMember") != null) {
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
	
	if(request.getParameter("memberId") == null ||
		request.getParameter("memberId").equals("") ||
		request.getParameter("memberPw") == null ||
		request.getParameter("memberPw").equals("")) {
			String msg = "로그인 정보를 입력해주세요.";
			response.sendRedirect(request.getContextPath()+"/loginForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
			return;
	}
	
	Member paramMember = new Member(); // Model 호출시 매개값
	paramMember.setMemberId(request.getParameter("memberId"));
	paramMember.setMemberPw(request.getParameter("memberPw"));
	
	//2) Model 호출 : Model 1
	MemberDao memberDao = new MemberDao();
	Member loginMember = memberDao.login(paramMember);
	
	
	String redirectUrl = "/loginForm.jsp?&msg=";
	String msg = "로그인 실패";
	
	if(loginMember != null) {
		session.setAttribute("loginMember", loginMember); // session안에 로그인 ID, NAME 저장
		redirectUrl = "/cash/cashList.jsp?&msg=";
		msg="로그인 성공";
	}
	
	response.sendRedirect(request.getContextPath()+redirectUrl+URLEncoder.encode(msg,"UTF-8"));

%>