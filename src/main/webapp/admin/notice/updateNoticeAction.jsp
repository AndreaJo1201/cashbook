<%@page import="vo.Member"%>
<%@page import="vo.Notice"%>
<%@page import="dao.NoticeDao"%>
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

	if(request.getParameter("noticeNo") == null ||
		request.getParameter("noticeNo").equals("") ||
		request.getParameter("noticeMemo") == null ||
		request.getParameter("noticeMemo").equals("")) { // 수정하려는 공지사항 식별번호와 내용이 없으면 list 페이지로 이동
			response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp");
		return;
	}

	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	
	Notice notice = new Notice();
	notice.setNoticeNo(noticeNo);
	notice.setNoticeMemo(request.getParameter("noticeMemo"));
	
	NoticeDao noticeDao = new NoticeDao();
	int row = noticeDao.updateNotice(notice);
	
	if(row == 0){ // 기능 동작 실패시 수정 폼으로 이동
		response.sendRedirect(request.getContextPath()+"/admin/notice/updateNoticeForm.jsp");
		return;
	}
	
	response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp");

%>