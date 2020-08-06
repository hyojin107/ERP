<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>입고관리 : 입고신청 목록 </title>
<link href="https://unpkg.com/bootstrap-table@1.17.1/dist/bootstrap-table.min.css" rel="stylesheet">
<script src="https://unpkg.com/bootstrap-table@1.17.1/dist/bootstrap-table.min.js"></script>
</head>
<body>
<h1>입고관리 : 입고신청 목록 보여주기 (매입서, 반품의뢰서, 생산보고서 리스트 불러오기 )</h1>

<ul class="nav nav-tabs">
  <li class="nav-item">
    <a class="nav-link active" data-toggle="tab" data-lstore = "WH01" href="#asd" data-code = "T002">매입서</a>
  </li>
  <li class="nav-item">
    <a class="nav-link " data-toggle="tab" href="#qwe" data-lstore = "WH02" data-code = "T001" >생산보고서</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" data-toggle="tab"  href="#zxc" data-lstore = "WH01" data-code = "T003">반품의뢰서</a>
  </li>
</ul>
<div class="tab-content">
  <div class="tab-pane fade show active" id="qwe">
  </div>
  <div class="tab-pane fade" id="asd">
  </div>
  <div class="tab-pane fade" id="zxc">
  </div>
  
  <table
  id="table"
  data-toggle="table"
  data-height="460"
  data-detail-view="true"
  data-detail-formatter="detailFormatter"
   data-ajax="ajaxRequest"
   >
  <thead>
    <tr>
      <th data-field="stuff_date">물품 신청날짜</th>
      <th data-field="pos_name">사원 직급</th>
      <th data-field="emp_name">사원 이름</th>
      <th data-field="operate" data-formatter="operateFormatter" data-events="operateEvents">입고 작성</th>
    </tr>
  </thead>
</table>
</div>

</body>


<script>

 
  var sendval;
function operateFormatter(value, row, index) {
    return [
      '<a class="like" href="javascript:void(0)" title="Like">',
      '<i class="fa fa-edit"></i>',
      '</a>  ',
     
    ].join('')
  }
  


function setRow(){
	return sendval;
}

  
  window.operateEvents = {
    'click .like': function (e, value, row, index) {
     sendval = row
     console.log(row)
     let openWin = window.open("${cPath}/enter/buyorder/"+ code + "/" + lstore +"/insert", "네이버새창", "width=800, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes" )
      
    }
    
  }


  function detailFormatter(index, row) {
    var html = []
    
     html.push('<table><thread><tr><th>품목</th><th>갯수</th></tr></thread><tbody>')
    $.each(row, function (key, value) {
      if(key == "stufflist"){
    	  $.each(value, function(key,value){
    		  
      html.push('<tr>')		  
      html.push("<td>" + value.stuff_name + "</td>")
      html.push('<td>' + value.stuff_cnt + value.stuff_size + '</td>')
      html.push('</tr>')		  
    	  })
      }
      
    })
      html.push('</tbody></table>')
    return html.join('')
  }
  

var url = '${cPath}/enter/buyorder/json'
var code = 'T001'
var lstore = 'WH01'

  function ajaxRequest(params) {
	    $.get(url + "?code=" + code).then(function (res) {
	      params.success(res)
	    })
	    console.log(params)
	  }
  
 
  $(".nav-tabs").on("click",".nav-link",function(){
	  code = $(this).data("code")	  
	  lstore = $(this).data("lstore")
      $('#table').bootstrapTable('refresh', {})
  })
</script>




</html>