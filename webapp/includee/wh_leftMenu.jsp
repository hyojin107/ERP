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
          <!-- 원자재관리 -->
          <li class="nav-item has-treeview" data-url="/ware/mat">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-circle "></i>
              <p>
                 	원자재 관리
                <i class="fas fa-angle-left right"></i>
                </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="${cPath}/ware/mat/list" class="nav-link">
                  <i class="nav-icon far fa-circle "></i>
                  <p>원자재 목록</p>
              
                </a>
              </li>
              <li class="nav-item">
                <a href="${cPath }/ware/mat/insert" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>원자재 등록</p>
                </a>
              </li>
            </ul>
          </li>
          
          <!-- 상품관리 -->
          <li class="nav-item has-treeview" data-url="/ware/prod">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-circle "></i>
              <p>
                 	상품관리
                <i class="fas fa-angle-left right"></i>
                </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="${cPath}/ware/prod/list" class="nav-link">
                  <i class="nav-icon far fa-circle "></i>
                  <p>상품 목록</p>
              
                </a>
              </li>
              <li class="nav-item">
                <a href="${cPath}/ware/prod/insert" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>상품 등록</p>
                </a>
              </li>
            </ul>
          </li>
          
          <!-- 입고 관리 -->
          <li class="nav-item has-treeview" data-url="/enter">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-circle "></i>
              <p>
                 	입고관리
                <i class="fas fa-angle-left right"></i>
                </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="${cPath}/enter/mat/matlist" class="nav-link">
                  <i class="nav-icon far fa-circle "></i>
                  <p>원자재 목록</p>
              
                </a>
              </li>
              <li class="nav-item">
                <a href="${cPath}/enter/mat/buyorder/buyrequestlist" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>원자재 구매요청 목록</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${cPath}/enter/mat/requestlist" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>입고 신청 목록</p>
                </a>
              </li>
            </ul>
          </li>
          
           <!-- 출고 관리 -->
          <li class="nav-item has-treeview" data-url="/outer">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-circle "></i>
              <p>
                 	출고 관리
                <i class="fas fa-angle-left right"></i>
                </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="${cPath}/outer/matreturn/list" class="nav-link">
                  <i class="nav-icon far fa-circle "></i>
                  <p>원자재 반품의뢰서 목록</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${cPath}/outer/prod/prodlist" class="nav-link">
                  <i class="nav-icon far fa-circle "></i>
                  <p>상품 목록</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${cPath}/outer/prod/pduct/list" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>생산의뢰서 목록</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${cPath}/outer/doc/list" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>출하지시서 목록</p>
                </a>
              </li>
            </ul>
          </li>
          
          <!-- 폐기 관리 -->
          <li class="nav-item has-treeview" data-url="/disuse">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-circle "></i>
              <p>
                    폐기 관리
                <i class="fas fa-angle-left right"></i>
                </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="${cPath}/disuse/app/regist" class="nav-link">
                  <i class="nav-icon far fa-circle "></i>
                  <p>폐기 등록</p>
                </a>
              </li>
            </ul>
          </li>
          
          <!-- 창고관리 -->
          <li class="nav-item has-treeview" data-url="/warehouse">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-circle "></i>
              <p>
                    창고 관리
                <i class="fas fa-angle-left right"></i>
                </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="${cPath}/warehouse" class="nav-link">
                  <i class="nav-icon far fa-circle "></i>
                  <p>창고 조회</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="${cPath}/ware/manger/insert" class="nav-link">
                  <i class="nav-icon far fa-circle "></i>
                  <p>창고 등록</p>
                </a>
              </li>
              
            </ul>
          </li>
          
           <!-- 현황 조회 -->
          <li class="nav-item has-treeview">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-circle "></i>
              <p>
                 	현황조회
                <i class="fas fa-angle-left right"></i>
                </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="#" class="nav-link">
                  <i class="nav-icon far fa-circle "></i>
                  <p>상품 현황</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="#" class="nav-link">
                  <i class="nav-icon far fa-circle "></i>
                  <p>원자재 현황</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="#" class="nav-link">
                  <i class="nav-icon far fa-circle "></i>
                  <p>기간별 현황</p>
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