<%@page import="java.net.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<%
	if(session.getAttribute("loginMember") != null) { // 로그인 상태로는 접속 불가, 로그인 상태일시 가계부 페이지로 이동
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}

	if(request.getParameter("memberId") == null ||
		request.getParameter("memberId").equals("") ||
		request.getParameter("memberPw") == null ||
		request.getParameter("memberPw").equals("") ||
		request.getParameter("memberName") == null ||
		request.getParameter("memberName").equals("")) {
			String msg = "빈칸을 입력해주세요.";
			response.sendRedirect(request.getContextPath()+"/member/insertMemberForm.jsp?msg="+URLEncoder.encode(msg,"UTF-8"));
			return;
	}
	
	Member paramMember = new Member();
	paramMember.setMemberId(request.getParameter("memberId"));
	paramMember.setMemberPw(request.getParameter("memberPw"));
	paramMember.setMemberName(request.getParameter("memberName"));
	
	MemberDao memberDao = new MemberDao();
	
	int duplicateID = memberDao.selectDuplicateInsertMember(paramMember);
	if(duplicateID != 0) {
		System.out.println("memberID Duplicated");
		String msg = "ID 중복, 다른 ID 사용";
		response.sendRedirect(request.getContextPath()+"/member/insertMemberForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
		return;
	}
	
	int row = memberDao.insertMember(paramMember);
	String msg = null;
	
	if(row == 0) {
		System.out.println("INSERT FALSE");
		msg = "회원가입 실패";
	} else {
		System.out.println("INSERT COMPLETE");
		msg = "회원가입 성공";
	}
	
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
	
	/*
	31번라인부터 대체
	if(memberDao.selectMemberIdCheck(paramMember.setMemberId(request.getParameter("memberId")))) {
		System.out.println("아이디중복");
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp");
		return;
	}
	int row = memberDao.insertMember(member);
	System.out.println("row --> " + row);
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
	
	
	*/
%>