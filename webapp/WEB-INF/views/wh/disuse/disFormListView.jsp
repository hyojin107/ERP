<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>폐기관리 : 폐기등록서 목록출력</title>
</head>
<body>
<h1> 폐기관리 : 작성했던 폐기등록서의 목록들이 출력된다. </h1>


<form class="form-inline md-form form-sm mt-0">
  <i class="fas fa-search" aria-hidden="true"></i>
  <p>상품분류</p>
<select class="mdb-select md-form colorful-select dropdown-primary" searchable="Search here..">
  <option value="1">원자재</option>
  <option value="2">상품</option>
  <option value="3">Option 3</option>
  <option value="4">Option 4</option>
  <option value="5">Option 5</option>
</select>
    
    
     <i class="fas fa-search" aria-hidden="true"></i>
  <p>문서번호</p>
  <input class="form-control mr-sm-2" type="text" placeholder="Search"
    aria-label="Search">
</form>



<table class="table table-bordered">
  <thead>
    <tr>
      <th scope="col">no.</th>
      <th scope="col">작성자</th>
      <th scope="col">상품분류</th>
      <th scope="col">작성일</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th scope="row">1</th>
      <td>Mark</td>
      <td>Otto</td>
      <td>@mdo</td>
    </tr>
    <tr>
      <th scope="row">2</th>
      <td>Jacob</td>
      <td>Thornton</td>
      <td>@fat</td>
    </tr>
    <tr>
      <th scope="row">3</th>
      <td colspan="2">Larry the Bird</td>
      <td>@twitter</td>
    </tr>
  </tbody>
</table>

</body>
</html>