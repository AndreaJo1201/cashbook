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
		request.getParameter("noticeNo").equals("")) { // 삭제하려는 공지사항 식별 번호가 없을 시 list 페이지로 이동
			response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp");
	}

	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	
	NoticeDao noticeDao = new NoticeDao();
	
	Notice notice = noticeDao.selectNoticeByNo(noticeNo);
	
	int deleteNoticeCheck = noticeDao.deleteNotice(notice);
	
	if(deleteNoticeCheck == 0) { // 기능 동작 여부 : console창 출력, 성공여부 상관없이 공지사항 list 페이지로 이동
		System.out.println("삭제 실패!!!!!!"); // msg alter 형식으로 변경하기.
	} else {
		System.out.println("삭제 성공했습니다."); // msg alter 형식으로 변경하기.
	}
	
	response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp");

%>
