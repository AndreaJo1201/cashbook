<%@page import="vo.Member"%>
<%@page import="dao.NoticeDao"%>
<%@page import="vo.Notice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>

<%
	if(session.getAttribute("loginMember") == null) { // 세션 정보가 없을 시 로그인 페이지로 이동
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} else {
		Member loginMember = (Member)session.getAttribute("loginMember");
		if(loginMember.getMemberLevel() < 1) { // 관리자 레벨이 아닐시 가계부 페이지로 이동
			response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
			return;
		}
	}
	
	if(request.getParameter("noticeMemo") == null ||
		request.getParameter("noticeMemo").equals("")) { // 추가하려는 공지사항 내용이 없을시 입력 폼으로 이동
			response.sendRedirect(request.getContextPath()+"/admin/notice/insertNoticeForm.jsp");
			return;
	}

	Notice notice = new Notice();
	notice.setNoticeMemo(request.getParameter("noticeMemo"));
	
	NoticeDao noticeDao = new NoticeDao();
	int row = noticeDao.insertNotice(notice);
	
	if(row == 0) { // 기능 동작 여부 실패시 입력 폼, 성공시 공지사항 list 페이지
		response.sendRedirect(request.getContextPath()+"/admin/notice/insertNoticeForm.jsp");
	} else {
		response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp");
	}
	
%>