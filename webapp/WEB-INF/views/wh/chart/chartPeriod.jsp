<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>현황관리 : 기간별 입고 출고 폐기 현황을 보여준다. </title>
</head>
<body>
<h1>현황관리 : 기간별 입고, 출고, 폐기 현황을 보여준다.</h1>
<form>
<table class="table">
	<thead>
		<tr>
			<th>기간</th>
			<th>저장창고</th>
			<th>상품 분류</th>
			<th>상태</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><input type="date"/>~<input type="date"></td>
			<td>
				<select>
					<option>A창고</option>
					<option>B창고</option>
				</select>
			</td>
			<td>
				<select>
					<option>원자재</option>
					<option>상품</option>
				</select>
			</td>
			<td>
				<select>
					<option>입고</option>
					<option>출고</option>
					<option>폐기</option>
				</select>
			</td>
		</tr>
	</tbody>
</table>
	<input type="submit" value="검색"/>
</form>

</body>
</html>