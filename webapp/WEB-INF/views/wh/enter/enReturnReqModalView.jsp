<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<h1> 입고관리 : 영업팀에서 보낸 반품 상품 목록 상세보기 후 상품 재입고 , 상품 재입고 날짜 컬럼 만들어야 할 듯</h1>
<form:form>
	<table  class="table">
		<thead>
			<tr>
				<th>작성자</th>
				<td>(작성자)</td>
			</tr>
			<tr>
				<th>문서번호</th>
				<td>(문서번호)</td>
			</tr>
		</thead>
		<tr>
			<th>
				<h3> 반품 목록 </h3>
			</th>
		</tr>
		<tbody>
			<tr>
				<th>No.</th>
				<th>상품코드</th>
				<th>상품명</th>
				<th>반품수량</th>
				<th>사유</th>
				<th>분류</th>
				<th>입고창고</th>
			</tr>
			<tr>
				<td>(No)</td>
				<td>(상품코드)</td>
				<td>(상품명)</td>
				<td>(반품수량)</td>
				<td>(단순변심)</td>
				<td>(입고)</td>
				<td>
					<select>
						<option>창고</option>
					</select>
				</td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="5"></td>
				<td>
					<input type="button" value="입고"/>
				</td>
				<td>
					<input type="button" value="뒤로가기" onclick="history.back();"/>
				</td>
			</tr>
		</tfoot>
	</table>
</form:form>