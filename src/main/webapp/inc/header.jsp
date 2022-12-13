<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>

<%
	Member loginMember = (Member)session.getAttribute("loginMember");
%>
	<div class="nav-header">
		<div class="brand-logo">
			<a href="<%=request.getContextPath()%>/cash/cashList.jsp">
				<b class="logo-abbr"><img src="<%=request.getContextPath()%>/css/images/logo.png" alt=""> </b>
                    <span class="logo-compact"><img src="<%=request.getContextPath()%>/css/images/logo-compact.png" alt=""></span>
                    <span class="brand-title">
						<img src="images/logo-text.png" alt="">
				</span>
			</a>
		</div>
	</div>
	
	<div class="header">    
            <div class="header-content clearfix">
                <div class="nav-control">
                    <div class="hamburger">
                        <span class="toggle-icon"><i class="icon-menu"></i></span>
                    </div>
                </div>
                <div class="header-left">
                	<div class="input-group">
                		<div class="input-group-prepend">
        					<span class="h4">Hello! <%=loginMember.getMemberName() %></span>
        				</div>
        			</div>
                </div>
                <div class="header-right">
                   	<a href="<%=request.getContextPath()%>/logout.jsp" class="btn-dark btn" style="margin-top:20px;">Sign out</a>
                </div>
            </div>
        </div>
        <!--**********************************
            Header end ti-comment-alt
        ***********************************-->

        <!--**********************************
            Sidebar start
        ***********************************-->
        <div class="nk-sidebar">           
            <div class="nk-nav-scroll">
                <ul class="metismenu" id="menu">
                	<li>
                		<a href="<%=request.getContextPath()%>/cash/cashList.jsp" aria-expanded="false">
                            <i class="icon-notebook menu-icon"></i><span class="nav-text">CashBook</span>
                        </a>
                	</li>
      				<li>
                        <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                            <i class="icon-graph menu-icon"></i><span class="nav-text">통계</span>
                        </a>
                        <ul aria-expanded="false">
                            <li><a href="<%=request.getContextPath()%>/cash/cashIEListByYear.jsp">연도별 통계</a></li>
                            <li><a href="<%=request.getContextPath()%>/cash/cashIEListByMonth.jsp">월별 통계</a></li>
                        </ul>
					</li>
					<li>
						<%
							if(loginMember.getMemberLevel() < 1) {
						%>
		                        <a href="<%=request.getContextPath()%>/help/helpList.jsp" aria-expanded="false">
		                            <i class="icon-grid menu-icon"></i><span class="nav-text">문의내역</span>
		                        </a>
                        <%
							} else {
                        %>
                        		<a href="<%=request.getContextPath()%>/admin/adminMain.jsp" aria-expanded="false">
		                            <i class="icon-grid menu-icon"></i><span class="nav-text">ADMIN</span>
		                        </a>
                        <%
							}
                        %>
                    </li>
                    <li class="nav-label">My Page</li>
					<li>
                        <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                            <i class="icon-menu menu-icon"></i><span class="nav-text">Profile</span>
                        </a>
                        <ul aria-expanded="false">
                            <li><a href="<%=request.getContextPath()%>/member/updateMemberForm.jsp">Change Name</a></li>
                            <li><a href="<%=request.getContextPath()%>/member/updateMemberPwForm.jsp">Change Password</a></li>
                            <li><a href="<%=request.getContextPath()%>/member/deleteMemberForm.jsp">Unregister</a></li>
                        </ul>
					</li>
                </ul>
            </div>
        </div>
        <!--**********************************
            Sidebar end
        ***********************************-->