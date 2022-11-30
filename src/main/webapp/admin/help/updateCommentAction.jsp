<%@page import="java.net.URLEncoder"%>
<%@page import="dao.CommentDao"%>
<%@page import="vo.Comment"%>
<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>

<%
	if(session.getAttribute("loginMember") == null) { // 세션 정보가 없을 시 로그인 페이지로 이동
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember.getMemberLevel() < 1) { // 관리자 레벨이 아닐 시 가계부 페이지로 이동
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
	
	if(request.getParameter("commentNo") == null ||
		request.getParameter("commentNo").equals("") ||
		request.getParameter("commentMemo") == null ||
		request.getParameter("commentMemo").equals("")) { //수정하려는 코멘트 식별 번호와 내용이 없을 시 수정 페이지로 이동
			response.sendRedirect(request.getContextPath()+"/admin/help/updateCommentForm.jsp?commentNo="+request.getParameter("commentNo"));
			return;
	}
	
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	String commentMemo = request.getParameter("commentMemo");
	
	Comment comment = new Comment();
	comment.setCommentNo(commentNo);
	comment.setCommentMemo(commentMemo);
	
	CommentDao commentDao = new CommentDao();
	
	int row = commentDao.updateComment(comment);
	
	if(row == 0) {
		String msg = "답변달기 실패";
		response.sendRedirect(request.getContextPath()+"/admin/help/updateCommentForm.jsp?commentNo="+commentNo+URLEncoder.encode(msg,"UTF-8"));
		return;
	}
	
	response.sendRedirect(request.getContextPath()+"/admin/helpListAll.jsp");
%>
