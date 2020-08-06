<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<h4>반품 목록 선택</h4>
<table class="table table-hover">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">매입번호</th>
      <th scope="col">품목코드</th>
      <th scope="col">품목명</th>
      <th scope="col">분류명</th>
      <th scope="col">규격</th>
      <th scope="col">수량</th>
      <th scope="col">단가</th>
      <th scope="col">공급가액</th>
    </tr>
  </thead>
  <tbody id="listBody" data-toggle="modal" data-target="#exampleModal">
	  <tr>
	  <td>${purVO.pur_code }</td>
	  
	  </tr>
  </tbody>
</table>
<!-- <input type="button" id="backPage" value="이전"/> -->
<input type="button" id="nextPage" value="다음"/>





