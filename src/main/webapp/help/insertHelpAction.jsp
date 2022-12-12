<%@page import="dao.HelpDao"%>
<%@page import="vo.Help"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>

<%
	if(session.getAttribute("loginMember") == null) {
		String msg = "로그인이 필요합니다.";
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
		return;
	}
	
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	
	if(request.getParameter("helpMemo") == null ||
		request.getParameter("helpMemo").equals("")) {
			response.sendRedirect(request.getContextPath()+"/help/insertHelpForm.jsp");
			return;
	}
	
	Help help = new Help();
	help.setHelpMemo(request.getParameter("helpMemo"));
	help.setMemberId(memberId);
	
	HelpDao helpDao = new HelpDao();
	
	int row = helpDao.insertHelp(help);
	
	if(row == 0) {
		response.sendRedirect(request.getContextPath()+"/help/insertHelpForm.jsp");
		return;
	}
	response.sendRedirect(request.getContextPath()+"/help/helpList.jsp");
%>
