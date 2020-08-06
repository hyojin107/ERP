 <!-- Main Sidebar Container -->
 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <aside class="main-sidebar sidebar-dark-primary elevation-4" style="height:100vh">
    <!-- Brand Logo -->
    <a href="#" class="brand-link" style="background-color: #f44336;">
      <img src="${pageContext.request.contextPath }/resources/img/logo.png" alt="ERP" class="brand-image img-circle elevation-3"
           style="opacity: .8">
      <span class="brand-text font-weight-light">HnJ ERP</span>
    </a>
    <!-- Sidebar -->
    <div class="sidebar">
      <!-- Sidebar user panel (optional) -->
      <div class="user-panel mt-3 pb-3 mb-3 d-flex">
        <div class="image">
        <a href="${cPath}/mypage/myInfo">
          <img src="${pageContext.request.contextPath }/resources/img/man.png" class="img-circle elevation-2" alt="User Image" >
        </a>
        </div>
        <div class="info">
          <a href="#" class="d-block">${emp.emp_name}</a>
        </div>
      </div>
      <!-- Sidebar Menu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <li class="nav-item has-treeview" data-url="/emp/salary">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-chart-pie"></i>
              <p>
                	근로소득관리
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="${cPath}/emp/salary/salaryInfoList" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>급여내역</p>
                </a>
              </li>
               <li class="nav-item">
                <a href="${cPath}/emp/salary/salaryCal" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>급여정책</p>
                </a>
              </li> 
              <%-- <li class="nav-item">
                <a href="${cPath}/emp/salary/salaryEmailSend" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>급여명세서발송</p>
                </a>
              </li> --%>
            </ul>
          </li>
          
           <li class="nav-item has-treeview" data-url="/emp/work">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-chart-pie" ></i>
              <p>
                	근태관리
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="${cPath}/emp/work/dailyList" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>일일근태관리</p>
                </a>
              </li>
              <%-- <li class="nav-item">
                <a href="${cPath}/emp/work/dailyForm" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>일일근태관리</p>
                </a>
              </li> --%>
              <li class="nav-item">
                <a href="${cPath}/emp/work/monthList" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>월간근태관리</p>
                </a>
              </li>
            </ul>
          </li>
          
           <li class="nav-item has-treeview" data-url="/emp/retire">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-chart-pie"></i>
              <p>
                	퇴직소득관리
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="${cPath}/emp/retire/retireTrans" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>퇴직금정산</p>
                </a>
              </li>
              <%-- <li class="nav-item">
                <a href="${cPath}/emp/retire/retireReceipt" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>퇴직금영수증</p>
                </a>
              </li> --%>
              <%-- <li class="nav-item">
                <a href="${cPath}/emp/retire/retireAllList" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>퇴직금추계액산출</p>
                </a>
              </li> --%>
            </ul>
          </li>
          
           <li class="nav-item has-treeview" data-url="/emp/manage">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-chart-pie"></i>
                	인사관리
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="${cPath}/emp/manage/empList" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>사원관리</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${cPath}/emp/manage/ann/announcementList" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>인사발령</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${cPath}/emp/retire/empRetirmentList" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>퇴사관리</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${cPath}/emp/manage/departmentList" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>부서별인사현황</p>
                </a>
              </li>
            </ul>
          </li>
          
           <li class="nav-item has-treeview" data-url="/emp/register">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-chart-pie"></i>
              <p>
                	기초등록
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="${cPath}/emp/register/calendar/admin" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>일정관리</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${cPath}/notice" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>공지사항</p>
                </a>
              </li>
            </ul>
          </li>        
        </ul>
      </nav>
      <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
  </aside>
  <script>
  var currenturl = "${cPath}" + "${requestScope['javax.servlet.forward.servlet_path']}"; 
  console.log(currenturl);
     $("li").each(function(){
        
        let url = $(this).data("url")
        if(currenturl.indexOf(url)==4){
           $(this).addClass("menu-open").find("i").eq(0).addClass("text-info");
           $(this).find("a").each(function(){
             if($(this).attr("href")==currenturl)
                $(this).find("i").eq(0).addClass("text-info");
           });
        }
     });
  </script>