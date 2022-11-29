<%@page import="java.net.URLEncoder"%>
<%@page import="dao.CommentDao"%>
<%@page import="vo.Comment"%>
<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>

<%
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
	
	if(request.getParameter("commentNo") == null ||
		request.getParameter("commentNo").equals("")) {
			response.sendRedirect(request.getContextPath()+"/admin/helpListAll.jsp");
			return;
	}
	
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	
	Comment comment = new Comment();
	comment.setCommentNo(commentNo);
	
	CommentDao commentDao = new CommentDao();
	
	int row = commentDao.deleteComment(comment);
	
	if(row == 0) {
		String msg = "삭제 실패";
		response.sendRedirect(request.getContextPath()+"/admin/helpList.jsp"+URLEncoder.encode(msg,"UTF-8"));
		return;
	}
	
	response.sendRedirect(request.getContextPath()+"/admin/helpListAll.jsp");
%>
