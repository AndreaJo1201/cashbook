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

	if(request.getParameter("categoryNo") == null ||
		request.getParameter("categoryNo").equals("") ||
		request.getParameter("categoryName") == null ||
		request.getParameter("categoryName").equals("")) { // 수정하려는 카테고리 정보를 받지 못하였으므로 list 페이지로 이동
			response.sendRedirect(request.getContextPath()+"/admin/categoryList.jsp");
			return;
	}
	
	Category category = new Category();
	category.setCategoryNo(Integer.parseInt(request.getParameter("categoryNo")));
	category.setCategoryName(request.getParameter("categoryName"));
	
	CategoryDao categoryDao = new CategoryDao();
	
	int row = categoryDao.updateCategory(category);
	
	if(row == 0) { // 기능 동작 여부, 실패시 카테고리 수정 페이지, 성공시 list 페이지
		System.out.println("수정실패");
		response.sendRedirect(request.getContextPath()+"/admin/category/updateCategoryForm.jsp?categoryNo="+category.getCategoryNo());
		return;
	} else {
		System.out.println("수정성공");
	}
	
	response.sendRedirect(request.getContextPath()+"/admin/categoryList.jsp");
%>
