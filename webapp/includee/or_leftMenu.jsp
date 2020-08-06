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
          <a href="#" class="d-block">영업부서 이제경</a>
        </div>
      </div>
      <!-- Sidebar Menu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">          
          <li class="nav-item has-treeview" data-url="/order/estimate/estimate">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-circle text-info"></i>
              <p>
                 	견적서관리
                <i class="fas fa-angle-left right"></i>
                </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="${pageContext.request.contextPath }/order/estimate/form" class="nav-link">
                  <i class="nav-icon far fa-circle text-info"></i>
                  <p>견적서입력</p>
              
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath }/order/estimate" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>견적서조회/현황</p>
                </a>
              </li>
            </ul>
          </li>
          
          <li class="nav-item has-treeview"  data-url="/order/order">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-circle text-info"></i>
              <p>
                 	주문서관리
                <i class="fas fa-angle-left right"></i>
                </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="${pageContext.request.contextPath }/order/order/form" class="nav-link">
                  <i class="nav-icon far fa-circle text-info"></i>
                  <p>주문서입력</p>
              
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath }/order/order" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>주문서조회/현황</p>
                </a>
              </li>
            </ul>
          </li>
          
          <li class="nav-item has-treeview"  data-url="/order/delivery">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-circle text-info"></i>
              <p>
                 	출하지시서관리
                <i class="fas fa-angle-left right"></i>
                </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="${pageContext.request.contextPath }/order/delivery/form" class="nav-link">
                  <i class="nav-icon far fa-circle text-info"></i>
                  <p>출하지시서입력</p>
              
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath }/order/delivery" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>출하지시서조회/현황</p>
                </a>
              </li>
            </ul>
          </li>
          
          <li class="nav-item has-treeview"  data-url="/order/shipment">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-circle text-info"></i>
              <p>
                 	출하관리
                <i class="fas fa-angle-left right"></i>
                </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="${pageContext.request.contextPath }/order/shipment/form" class="nav-link">
                  <i class="nav-icon far fa-circle text-info"></i>
                  <p>출하입력</p>
              
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath }/order/shipment" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>출하조회/현황</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath }/order/shipment/noshipped" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>미출하현황</p>
                </a>
              </li>
            </ul>
          </li>
          
          <li class="nav-item has-treeview"  data-url="/order/transDetails">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-circle text-info"></i>
              <p>
                 	거래명세서관리
                <i class="fas fa-angle-left right"></i>
                </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="${pageContext.request.contextPath }/order/transDetails/form" class="nav-link">
                  <i class="nav-icon far fa-circle text-info"></i>
                  <p>거래명세서입력</p>
              
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath }/order/transDetails" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>거래명세서조회</p>
                </a>
              </li>

            </ul>
          </li>
          
          <li class="nav-item has-treeview"  data-url="/order/buyer">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-circle text-info"></i>
              <p>
                 	거래처관리
                <i class="fas fa-angle-left right"></i>
                </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="${pageContext.request.contextPath }/order/buyer/form" class="nav-link">
                  <i class="nav-icon far fa-circle text-info"></i>
                  <p>거래처입력</p>
              
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath }/order/buyer/buyerList" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>거래처조회</p>
                </a>
              </li>

            </ul>
          </li>
          
          
          <li class="nav-item has-treeview"  data-url="${cPath}/order/return">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-circle text-info"></i>
              <p>
                 	매출반품관리
                <i class="fas fa-angle-left right"></i>
                </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="${cPath}/order/return/form" class="nav-link">
                  <i class="nav-icon far fa-circle text-info"></i>
                  <p>매출반품등록</p>
              
                </a>
              </li>
              <li class="nav-item">
                <a href="${cPath}/order/return" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>매출반품의뢰현황</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${pageContext.request.contextPath }/order/statistics" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>매출반품실적집계표</p>
                </a>
              </li>

            </ul>
          </li>
          
          
          <li class="nav-item has-treeview"  data-url="/order/prodSearch/list">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-circle text-info"></i>
              <p>
                 	상품조회
                <i class="fas fa-angle-left right"></i>
                </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="${pageContext.request.contextPath }/order/prodSearch/list" class="nav-link">
                  <i class="nav-icon far fa-circle text-info"></i>
                  <p>상품조회</p>
              
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