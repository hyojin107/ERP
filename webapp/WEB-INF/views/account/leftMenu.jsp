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
          <a href="#" class="d-block">자재부서 임수진</a>
        </div>
      </div>
      <!-- Sidebar Menu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <li class="nav-item has-treeview" data-url="/account/chit">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-circle "></i>
              <p>
                	전표관리
                <i class="fas fa-angle-left right"></i>
                </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="${cPath }/account/chit" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>전표승인</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${cPath }/account/chit/form" class="nav-link">
                  <i class="nav-icon far fa-circle "></i>
                  <p>전표입력</p>
              
                </a>
              </li>
              <li class="nav-item">
                <a href="${cPath }/account/chit/print" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>전표인쇄</p>
                </a>
              </li>
            </ul>
          </li>
          
          <li class="nav-item has-treeview" data-url="/account/basic">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-circle "></i>
              <p>
                	기초정보관리
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="${cPath }/account/basic/buyer" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>거래처조회</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${cPath }/account/basic/buyer/form" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>거래처등록</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${cPath }/account/basic/account" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>계정관리</p>
                </a>
              </li>
            </ul>
          </li>
          
          <li class="nav-item has-treeview" data-url="/account/fixAssets">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-circle "></i>
              <p>
                	고정자산관리
                <i class="fas fa-angle-left right"></i>
                </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="${cPath }/account/fixAssets" class="nav-link">
                  <i class="nav-icon far fa-circle "></i>
                  <p>고정자산등록</p>
              
                </a>
              </li>
              <li class="nav-item">
                <a href="${cPath }/account/fixAssets/ratio" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>감가상각률표</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${cPath }/account/fixAssets/fixMinus" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>감가상각비현황</p>
                </a>
              </li>
            </ul>
          </li>
          
          <li class="nav-item has-treeview" data-url="/account/table">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-circle "></i>
              <p>
                	재무제표
                <i class="fas fa-angle-left right"></i>
                </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="${cPath }/account/table/plusMinus" class="nav-link">
                  <i class="nav-icon far fa-circle "></i>
                  <p>재무상태표</p>
              
                </a>
              </li>
              <li class="nav-item">
                <a href="${cPath }/account/table/buySell" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>손익계산서</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${cPath }/account/table/productCost" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>원가명세서</p>
                </a>
              </li>
            </ul>
          </li>
          
          <li class="nav-item has-treeview" data-url="/account/pm">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-circle "></i>
              <p>
                	손익현황
                <i class="fas fa-angle-left right"></i>
                </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="${cPath }/account/pm/monthly" class="nav-link">
                  <i class="nav-icon far fa-circle "></i>
                  <p>월별손익현황</p>
              
                </a>
              </li>
              <li class="nav-item">
                <a href="${cPath }/account/pm/productly" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>상품별매출현황</p>
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