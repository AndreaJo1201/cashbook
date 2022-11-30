<%@page import="java.net.URLEncoder"%>
<%@page import="dao.CommentDao"%>
<%@page import="vo.Comment"%>
<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>

<%
	if(session.getAttribute("loginMember") == null) { // 로그인 세션 정보가 없을 시 로그인 페이지로 이동
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember.getMemberLevel() < 1) { // 관리자 레벨이 아닐 시 가계부 페이지로 이동
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
	
	if(request.getParameter("commentNo") == null ||
		request.getParameter("commentNo").equals("")) { // 삭제하려는 코멘트를 알 수 없으므로 list 페이지로 이동
			response.sendRedirect(request.getContextPath()+"/admin/helpListAll.jsp");
			return;
	}
	
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	
	Comment comment = new Comment();
	comment.setCommentNo(commentNo);
	
	CommentDao commentDao = new CommentDao();
	
	int row = commentDao.deleteComment(comment);
	
	if(row == 0) { // 동작 실패시 문의사항 list 페이지로 이동
		String msg = "삭제 실패";
		response.sendRedirect(request.getContextPath()+"/admin/helpListAll.jsp"+URLEncoder.encode(msg,"UTF-8"));
		return;
	}
	
	response.sendRedirect(request.getContextPath()+"/admin/helpListAll.jsp");
%>
