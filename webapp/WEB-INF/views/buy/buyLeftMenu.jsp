<%--
* [[개정이력(Modification Information)]]
* 	수정일                	 수정자      		수정내용
* ----------  ---------  -----------------
* 2020. 7. 3         송효진 	         최초작성
* Copyright (c) 2020 by DDIT All right reserved
 --%>
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
         <a href="#" class="d-block">구매부서 송효진</a>
       </div>
     </div>
     <!-- Sidebar Menu -->
     <nav class="mt-2">
       <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
         <li class="nav-item has-treeview" data-url="/buy/document">
           <a href="#" class="nav-link">
             <i class="nav-icon fas fa-chart-pie"></i>
             <p>
               	구매요청관리
               <i class="right fas fa-angle-left"></i>
             </p>
           </a>
           <ul class="nav nav-treeview">
             <li class="nav-item">
               <a href="${cPath}/buy/document/form" class="nav-link">
                 <i class="far fa-circle nav-icon"></i>
                 <p>구매요청등록</p>
               </a>
             </li>
             <li class="nav-item">
               <a href="${cPath}/buy/document" class="nav-link">
                 <i class="far fa-circle nav-icon"></i>
                 <p>구매요청현황</p>
               </a>
             </li>
           </ul>
         </li>
         
          <li class="nav-item has-treeview" data-url="/buy/order">
           <a href="#" class="nav-link">
             <i class="nav-icon fas fa-chart-pie"></i>
             <p>
               	발주관리
               <i class="right fas fa-angle-left"></i>
             </p>
           </a>
           <ul class="nav nav-treeview">
             <li class="nav-item">
               <a href="${cPath}/buy/order/form" class="nav-link">
                 <i class="far fa-circle nav-icon"></i>
                 <p>발주등록</p>
               </a>
             </li>
             <li class="nav-item">
               <a href="${cPath}/buy/order" class="nav-link">
                 <i class="far fa-circle nav-icon"></i>
                 <p>발주현황</p>
               </a>
             </li>
           </ul>
         </li>
         
          <li class="nav-item has-treeview" data-url="/buy/purchase">
           <a href="#" class="nav-link">
             <i class="nav-icon fas fa-chart-pie"></i>
             <p>
               	매입관리
               <i class="right fas fa-angle-left"></i>
             </p>
           </a>
           <ul class="nav nav-treeview">
             <li class="nav-item">
               <a href="${cPath}/buy/purchase/form" class="nav-link">
                 <i class="far fa-circle nav-icon"></i>
                 <p>매입등록</p>
               </a>
             </li>
             <li class="nav-item">
               <a href="${cPath}/buy/purchase" class="nav-link">
                 <i class="far fa-circle nav-icon"></i>
                 <p>매입현황</p>
               </a>
             </li>
           </ul>
         </li>
         
          <li class="nav-item has-treeview" data-url="/buy/ret">
           <a href="#" class="nav-link">
             <i class="nav-icon fas fa-chart-pie"></i>
             <p>
               	반품관리
               <i class="right fas fa-angle-left"></i>
             </p>
           </a>
           <ul class="nav nav-treeview">
             <li class="nav-item">
               <a href="${cPath}/buy/ret/form" class="nav-link">
                 <i class="far fa-circle nav-icon"></i>
                 <p>반품신청</p>
               </a>
             </li>
             <li class="nav-item">
               <a href="${cPath}/buy/ret" class="nav-link">
                 <i class="far fa-circle nav-icon"></i>
                 <p>반품현황</p>
               </a>
             </li>
           </ul>
         </li>
         
          <li class="nav-item has-treeview" data-url="/buy/incost">
           <a href="#" class="nav-link">
             <i class="nav-icon fas fa-chart-pie"></i>
             <p>
               	단가관리
               <i class="right fas fa-angle-left"></i>
             </p>
           </a>
           <ul class="nav nav-treeview">
             <li class="nav-item">
               <a href="${cPath }/buy/incost" class="nav-link">
                 <i class="far fa-circle nav-icon"></i>
                 <p>단가등록</p>
               </a>
             </li>
           </ul>
         </li>
         
          <li class="nav-item has-treeview" data-url="/buyer">
           <a href="#" class="nav-link">
             <i class="nav-icon fas fa-chart-pie"></i>
             <p>
               	거래처관리
               <i class="right fas fa-angle-left"></i>
             </p>
           </a>
           <ul class="nav nav-treeview">
             <li class="nav-item">
               <a href="${cPath }/buyer/form" class="nav-link">
                 <i class="far fa-circle nav-icon"></i>
                 <p>거래처등록</p>
               </a>
             </li>
           </ul>
           <ul class="nav nav-treeview">
             <li class="nav-item">
               <a href="${cPath }/buyer/buyerList " class="nav-link">
                 <i class="far fa-circle nav-icon"></i>
                 <p>거래처조회</p>
               </a>
             </li>
           </ul>
         </li>
         
         <li class="nav-item has-treeview" data-url="/buy/chart">
           <a href="#" class="nav-link">
             <i class="nav-icon fas fa-chart-pie"></i>
             <p>
               	매입통계
               <i class="right fas fa-angle-left"></i>
             </p>
           </a>
           <ul class="nav nav-treeview">
             <li class="nav-item">
               <a href="${cPath }/buy/chart " class="nav-link">
                 <i class="far fa-circle nav-icon"></i>
                 <p>매입통계</p>
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
 