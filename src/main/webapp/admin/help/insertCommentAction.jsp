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

	if(request.getParameter("helpNo") == null ||
		request.getParameter("helpNo").equals("") ||
		request.getParameter("commentMemo") == null ||
		request.getParameter("commentMemo").equals("")) {
			response.sendRedirect(request.getContextPath()+"/admin/help/insertCommentForm.jsp?helpNo="+request.getParameter("helpNo"));
			return;
	}
	
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	String commentMemo = request.getParameter("commentMemo");
	
	
	Comment comment = new Comment();
	comment.setHelpNo(helpNo);
	comment.setCommentMemo(commentMemo);
	comment.setMemberId(loginMember.getMemberId());

	CommentDao commentDao = new CommentDao();
	
	int row = commentDao.insertComment(comment);
	
	if(row == 0) {
		String msg = "답변달기 실패";
		response.sendRedirect(request.getContextPath()+"/admin/help/insertCommentForm.jsp?helpNo="+helpNo+URLEncoder.encode(msg,"UTF-8"));
		return;
	}
	
	response.sendRedirect(request.getContextPath()+"/admin/helpListAll.jsp");
	
%>