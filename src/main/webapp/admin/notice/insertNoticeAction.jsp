<%@page import="dao.NoticeDao"%>
<%@page import="vo.Notice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>

<%
	if(request.getParameter("noticeMemo") == null ||
		request.getParameter("noticeMemo").equals("")) {
			response.sendRedirect(request.getContextPath()+"/admin/notice/insertNoticeForm.jsp");
			return;
	}

	Notice notice = new Notice();
	notice.setNoticeMemo(request.getParameter("noticeMemo"));
	
	NoticeDao noticeDao = new NoticeDao();
	int row = noticeDao.insertNotice(notice);
	
	if(row == 0) {
		response.sendRedirect(request.getContextPath()+"/admin/notice/insertNoticeForm.jsp");
	} else {
		response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp");
	}
	
%>