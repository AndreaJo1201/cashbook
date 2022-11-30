<%@page import="vo.Member"%>
<%@page import="dao.HelpDao"%>
<%@page import="vo.Help"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>

<%
	if(session.getAttribute("loginMember") == null) { //비 로그인 페이지 접속 시 로그인 폼으로 안내
		String msg = "로그인이 필요합니다.";
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?&msg="+URLEncoder.encode(msg,"UTF-8"));
		return;
	}
	
	if(request.getParameter("helpNo") == null ||
		request.getParameter("helpNo").equals("") ||
		request.getParameter("helpMemo") == null ||
		request.getParameter("helpMemo").equals("")) {
			response.sendRedirect(request.getContextPath()+"/help/helpList.jsp");
			return;
	}
	
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	String helpMemo = request.getParameter("helpMemo");
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	Help help = new Help();
	help.setHelpNo(helpNo);
	help.setHelpMemo(helpMemo);
	help.setMemberId(loginMember.getMemberId());
	
	System.out.println(help.getHelpNo());
	System.out.println(help.getHelpMemo());
	System.out.println(help.getMemberId());
	
	HelpDao helpDao = new HelpDao();
	
	int row = helpDao.updateHelp(help);
	
	if(row==0) {
		String msg = "업데이트 실패";
		response.sendRedirect(request.getContextPath()+"/help/helpList.jsp?msg="+URLEncoder.encode(msg,"UTF-8"));
		return;
	}
	
	response.sendRedirect(request.getContextPath()+"/help/helpList.jsp");

%>