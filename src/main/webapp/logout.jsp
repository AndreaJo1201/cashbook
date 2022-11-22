<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>

<%
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	String msg = "로그아웃";
	session.invalidate(); // session 값 초기화
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+URLEncoder.encode(msg,"UTF-8")); 
%>