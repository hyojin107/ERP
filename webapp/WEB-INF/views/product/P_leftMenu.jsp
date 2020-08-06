 <!-- Main Sidebar Container -->
 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <aside class="main-sidebar sidebar-dark-primary elevation-4" style="height:100vh">
    <!-- Brand Logo -->
    <a href="#" class="brand-link">
      <img src="${pageContext.request.contextPath }/resources/img/logo.png" alt="ERP" class="brand-image img-circle elevation-3"
           style="opacity: .8">
      <span class="brand-text font-weight-light">HnJ ERP</span>
    </a>
    <!-- Sidebar -->
    <div class="sidebar">
      <!-- Sidebar user panel (optional) -->
      <div class="user-panel mt-3 pb-3 mb-3 d-flex">
        <div class="image">
          <img src="${pageContext.request.contextPath }/resources/img/man.png" class="img-circle elevation-2" alt="User Image">
        </div>
        <div class="info">
          <a href="#" class="d-block">생산부서</a>
        </div>
      </div>
      <!-- Sidebar Menu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <li class="nav-item has-treeview" data-url="/product">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-circle "></i>
              <p>생산의뢰서관리
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="${cPath }/product" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>생산의뢰서 확인</p>
                </a>
              </li>
<!--               <li class="nav-item"> -->
<%--                 <a href="${cPath }/account/basic/account" class="nav-link"> --%>
<!--                   <i class="far fa-circle nav-icon"></i> -->
<!--                   <p> </p> -->
<!--                 </a> -->
<!--               </li> -->
            </ul>
          </li>
          
          <li class="nav-item has-treeview" data-url="/report">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-circle "></i>
              <p>
                	생산보고서관리
                <i class="fas fa-angle-left right"></i>
                </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="${cPath }/report" class="nav-link">
                  <i class="nav-icon far fa-circle "></i>
                  <p>생산보고서 작성</p>
              
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