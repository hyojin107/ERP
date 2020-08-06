<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>  
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %> 
  <!-- DataTables -->
  <link rel="stylesheet" href="${cPath }/resources/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
  <link rel="stylesheet" href="${cPath }/resources/plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
  <link rel="stylesheet" href="https://cdn.datatables.net/buttons/1.6.2/css/buttons.dataTables.min.css    ">

<section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>상세 근태 현황</h1>
          </div>
        </div>
      </div><!-- /.container-fluid -->
</section>
<section class="content">
   <div class="container-fluid">
      <div class="row">
         <div class="col-12">
            <!-- 없애면안됨 -->
            <div class="col-12">
               <div class="card">
                  <div class="card-header">
                     <input type="date" id="selectedDate1" name="selectedDate1">
                     <input type="date" id="selectedDate2" name="selectedDate2">
                     <button class="btn btn-primary btn-sm" href="#" id="searchBtn1">
                     조회
                           </button>
                     <button class="btn btn-info btn-sm" href="#" id="restBtn">
                     초기화
                           </button>
                      <button class="btn btn-info btn-sm" href="#">
                     <i class="fas fa-pencil-alt"></i> 근태입력
                     </button>
                  </div>
                  <!-- /.card-header -->
                  <div class="card-body">
                     <div id="myTable_wrapper"
                        class="dataTables_wrapper dt-bootstrap4">
                        <div class="col-12">
                           <table id="myTable" class="table table-hover"   cellspacing="0" width="100%">
                              <thead>
                                 <tr>
                                    <th>근무일자</th>
                                    <th>부서</th>
                                    <th>사원번호</th>
                                    <th>성명</th>
                                    <th>직급</th>
                                    <th>근태구분</th>
                                    <th>출근시각</th>
                                    <th>퇴근시각</th>
                                 </tr>
                              </thead>
                           </table>
                        </div>
                     </div>
                  </div>
                  <!-- /.card-body -->
               </div>
            </div>
         </div>
         <!-- /.col -->
      </div>
      <!-- /.row -->
   </div>
   <!-- /.container-fluid -->
</section>
<!-- Modal -->
<div class="modal fade" id="modal" tabindex="-1" role="dialog"
   aria-labelledby="exampleModalLabel" aria-hidden="true">
   <div class="modal-dialog modal-dialog-scrollable modal-xl">
      <div class="modal-content">
         <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">근태입력</h5>
            <button type="button" class="close" data-dismiss="modal"
               aria-label="Close">
               <span aria-hidden="true">&times;</span>
            </button>
         </div>
         <div class="modal-body">
            <table class="table table-bordered" id="modal">
               <tr>
                  <th>근무일자</th>
                  <td id="cws_code"></td>
               </tr>
               <tr>
                  <th>부서</th>
                  <td id="dept_name"></td>
               </tr>
               <tr>
                  <th>사원번호</th>
                  <td id="emp_code"></td>
               </tr>
               <tr>
                  <th>사원명</th>
                  <td id="emp_kor"></td>
               </tr>
               <tr>
                  <th>직급</th>
                  <td id="position_name"></td>
               </tr>
               <tr>
                  <th>근태구분</th>
                  <td id="ta_catag_name">
                  <select class="catagOpt" id="ta_catag_code">
                  <c:if test="${not empty catagCodes}">
                     <c:forEach items="${catagCodes}" var="catags">
                        <option value="${catags.ta_catag_code}">${catags.ta_catag_name}</option>
                     </c:forEach>
                  </c:if>   
                  </select>
                  </td>
               </tr>
               <tr>
                  <th>출근시간</th>
                  <td id="start"></td>
               </tr>
               <tr>
                  <th>퇴근시간</th>
                  <td id="end"></td>
               </tr>
            </table>
         </div>
         <div class="modal-footer">
            <button type="button" id="updateBtn" class="btn btn-primary mr-2">수정</button>
            <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
         </div>
      </div>
   </div>
</div>
<!-- DataTables -->
<script src="${cPath }/resources/plugins/datatables/jquery.dataTables.min.js"></script>
<script src="${cPath }/resources/plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
<script src="${cPath }/resources/plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
<script src="${cPath }/resources/plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>

<script src="https://cdn.datatables.net/buttons/1.6.2/js/dataTables.buttons.min.js   "></script>
<script src="https://cdn.datatables.net/buttons/1.6.2/js/buttons.flash.min.js        "></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js         "></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js    "></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js      "></script>
<script src="https://cdn.datatables.net/buttons/1.6.2/js/buttons.html5.min.js        "></script>
<script src="https://cdn.datatables.net/buttons/1.6.2/js/buttons.print.min.js        "></script>
<!-- dynamicSelect -->
<script type="text/javascript" src="${cPath }/resources/js/dynamicSelect.js?time=${System.currentTimeMillis()}"></script>
<script type="text/javascript">
$.fn.dataTable.ext.search.push(
       function( settings, data, dataIndex, dataObject ) {
          let selected = deptSelect.val();
          if(!selected){
             return true;
          }else{
          return  selected == dataObject.dept_code;
          }
       }
   );
//datatable세팅
   var myDataTable= $("#myTable").DataTable({
	   searching: true,
	   "destroy":true,
	    "responsive": true,
	    "autoWidth": false,
	    stateSave: true,
	    dom: 'Bfrtip',
	    buttons: [
	        'copy', 'csv', 'excel', 'print'
	    ],
	    ajax:{
	       "type":"POST"
	       ,"url": "${cPath}/hr/att/detailList"
	       ,"dataType":"json"
	       ,"data": {"selectedDate1":$("#selectedDate1").val(),"selectedDate2":$("#selectedDate2").val()}
	    },
	    columns:[
	          {data:"cws_code"}
	          ,{data:"dept_name"}
	          ,{data:"emp_code"}
	          ,{data:"emp_kor"}
	          ,{data:"position_name"}
	          ,{data:"ta_catag_name"}
	          ,{data:"start"}
	          ,{data:"end"}
	       ]
	    , "columnDefs": {
	            className: "dt-head-center"
	        }
  });
//부서 드롭박스 동적생성 
var optionPtrn = "<option value='%V'>%T</option>";
var deptSelect = $('<select id="deptOpt" class="dynamicElement form-control" name="dept_code"/>').on("change",function(){
   myDataTable.draw();
});
   $('label').prepend(deptSelect);
   $('#deptOpt').attr("data-url","<c:url value='/hr/att/ip/getDeptName.do'/>");
   $('#deptOpt').attr("style","width:240px");
            var dept_nameTag = $("select[name='dept_code']").data(
                  "success",
                  function(resp) {
                     var html = optionPtrn.replace("%V", '').replace("%T", '전체 부서');
                     $.each(resp, function(idx, dept) {
                        html += optionPtrn.replace("%V", dept.dept_code).replace(
                              "%T", dept.dept_name);
                     });
                     dept_nameTag.html(html);
                  });      
   $(".dynamicElement").dynamicSelect();
//datatable변경할 ajax 
var ajaxList = function(selectedDate1,selectedDate1){
   $.ajax({
             "type":"POST"
                  ,"url": "${cPath}/hr/att/detailList"
                  ,"dataType":"json"
                  ,"data": {"selectedDate1":$("#selectedDate1").val(),"selectedDate2":$("#selectedDate2").val()}
                  ,success: function(resp){
                     console.log($(".active").children().eq(0).text());
                   var page = $(".active").find("a").text();
                   myDataTable.clear();
                   myDataTable.rows.add(resp.data);
                   myDataTable.draw();
                   $($("#myTable_paginate").find("a")).each(function(idx, item){
                      if($(item).text()==page) $(item).click();
                   })
//                    $("#myTable_paginate").find("a").eq(page).click();
//                    console.log($("#myTable_paginate").find("a"));
//                    $("#myTable_paginate").find("a").eq(page).parent().click();
                  }
               });
}
//조회기간반영위한 정규화 
var searchBtn1 = $("#searchBtn1").on("click",function(){
   var selectedDate1 = $("#selectedDate1").val().replace("-","").replace("-","");
   var selectedDate2 = $("#selectedDate2").val().replace("-","").replace("-","");
   if(selectedDate1 && selectedDate2){ //둘다 값이 있을 때 
      if(selectedDate1<=selectedDate2){
         ajaxList(selectedDate1,selectedDate2);
      }if(selectedDate1>selectedDate2){
         $("#selectedDate2").val("");
         alert("조회기간을 확인해주세요");
      }
   }if(!selectedDate1 || !selectedDate2){ //둘중에 하나라도 값이 없을 때 
      alert("조회기간을 둘 다 선택해주세요");
   }
});
//기간리셋버튼
$("#restBtn").on("click",function(){
   $("#selectedDate1").val("");
   $("#selectedDate2").val("");
   ajaxList();
});
//테이블 클릭하면 모달 
$('#myTable tbody').on('click', 'tr', function () {
      var data = myDataTable.row( this ).data();
      $("#cws_code").text(data.cws_code);
      $("#dept_name").text(data.dept_name);
      $("#emp_code").text(data.emp_code);
      $("#emp_kor").text(data.emp_kor);
      $("#position_name").text(data.position_name);
      let text = data.ta_catag_name;
      $(".catagOpt").find("option").each(function(index){
        if($(this).text()==text){
           $(".catagOpt").val($(this).val());
        }
      });
      $(".catagOpt").prop("disabled",true);
      $("#start").text(data.start);
      $("#end").text(data.end);
      $('#modal').modal();
});
//모달
$("#updateBtn").on('click',function(){
   if($(this).text()=='수정'){
    $(".catagOpt").prop("disabled",false);
    $("#updateBtn").text('수정완료');
   }else{ //수정완료
      if(confirm("정말 수정하시겠습니까?")){
         let emp_code = $("#emp_code").text();
         let cws_code = $("#cws_code").text();
         let ta_catag_code = $("#ta_catag_code").val();
         console.log(emp_code,ta_catag_code);
         $.ajax({
                "type":"POST"
                     ,"url": "${cPath}/hr/att/detailList/update"
                     ,"dataType":"text"
                     ,"data": {"emp_code":emp_code, "cws_code":cws_code, "ta_catag_code":ta_catag_code}
                     ,success: function(resp){
                        console.log(resp);
                  if(resp == 'OK')
                     ajaxList(selectedDate1,selectedDate2);
                     }
                  });
      }
      $(".catagOpt").prop("disabled",true);
      $(this).html('수정');
   }
});
</script>