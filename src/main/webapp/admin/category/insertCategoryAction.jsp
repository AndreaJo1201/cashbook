<%@page import="dao.CategoryDao"%>
<%@page import="vo.Category"%>
<%@page import="vo.Member"%>
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

	if(request.getParameter("categoryKind") == null ||
		request.getParameter("categoryKind").equals("") ||
		request.getParameter("categoryName") == null ||
		request.getParameter("categoryName").equals("")) { // 추가하려는 카테고리 정보가 없음, 입력창으로 이동.
			response.sendRedirect(request.getContextPath()+"/admin/category/insertCategoryForm.jsp");
			return;
	}
	
	Category category = new Category();
	category.setCategoryKind(request.getParameter("categoryKind"));
	category.setCategoryName(request.getParameter("categoryName"));
	
	CategoryDao categoryDao = new CategoryDao();
	
	int row = categoryDao.insertCategory(category);
	
	if(row == 0) { // 기능 동작 여부 실패시 insertForm, 성공시 List 페이지로 이동
		System.out.println("추가 실패");
		response.sendRedirect(request.getContextPath()+"/admin/category/insertCategoryForm.jsp");
		return;
	} else {
		response.sendRedirect(request.getContextPath()+"/admin/categoryList.jsp");
	}

%>