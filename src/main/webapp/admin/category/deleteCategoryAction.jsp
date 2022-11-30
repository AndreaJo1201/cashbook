<%@page import="dao.CategoryDao"%>
<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>

<%
	if(session.getAttribute("loginMember") == null) { //로그인 세션이 없으면 로그인 페이지로 이동
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} else {
		Member loginMember = (Member)session.getAttribute("loginMember");
		if(loginMember.getMemberLevel() < 1) { // 관리자 레벨이 아니면 가계부 페이지로 강제 이동
			response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
			return;
		}
	}

	if(request.getParameter("categoryNo") == null ||
		request.getParameter("categoryNo").equals("")) { // 수정하려는 카테고리 넘버가 넘어오지않을시 카테고리 리스트로 이동
			response.sendRedirect(request.getContextPath()+"/admin/categroyList.jsp");
			return;
	}
	
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	
	CategoryDao categoryDao = new CategoryDao();
	
	int row = categoryDao.deleteCategory(categoryNo);
	
	if(row == 0) { // 기능 동작 여부
		System.out.println("삭제실패");
	} else {
		System.out.println("삭제성공");
	}
	
	response.sendRedirect(request.getContextPath()+"/admin/categoryList.jsp");
%>
