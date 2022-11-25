<%@page import="vo.Member"%>
<%@page import="vo.Notice"%>
<%@page import="dao.NoticeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>

<%
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} else {
		Member loginMember = (Member)session.getAttribute("loginMember");
		if(loginMember.getMemberLevel() < 1) {
			response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
			return;
		}
	}

	if(request.getParameter("noticeNo") == null ||
		request.getParameter("noticeNo").equals("")) {
			response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp");
	}

	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	
	NoticeDao noticeDao = new NoticeDao();
	
	Notice notice = noticeDao.selectNoticeByNo(noticeNo);
	
	int deleteNoticeCheck = noticeDao.deleteNotice(notice);
	
	if(deleteNoticeCheck == 0) {
		System.out.println("삭제 실패!!!!!!"); // msg alter 형식으로 변경하기.
	} else {
		System.out.println("삭제 성공했습니다."); // msg alter 형식으로 변경하기.
	}
	
	response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp");

%>
