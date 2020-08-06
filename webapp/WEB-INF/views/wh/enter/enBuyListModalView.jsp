<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<h1>입고관리 : 매입서 상세보기 , 매입된 원자재 바로 입고 하기  </h1>

	<table border="1" class="table">
			<tr>
				<th>문서번호</th>
				<td>(문서번호)</td>
				<th>작성자</th>
				<td>(작성자)</td>
			</tr>
			<tr>
				<th>요청일자</th>
				<td>(요청일자)</td>
				<th>마감일자</th>
				<td>(마감일자)</td>
			</tr>
	</table>
	<br/>
	<form:form>	
	<table border="1" class="table">
			<tr>
				<th>No.</th>
				<th>원자재코드</th>
				<th>원자재명</th>
				<th>구매수량</th>
				<th>분류</th>
				<th>창고</th>
			</tr>
			<tr>
				<td>(No)</td>
				<td>(원자재코드)</td>
				<td>(원자재명)</td>
				<td>(구매수량)</td>
				<td>(입고)</td>
				<td>
					<select>
						<option>원자재 저장창고</option>
					</select>
				</td>
			</tr>
			<tr>
				<td colspan="5"></td>
				<td>
					<input type="submit" value="입고"/>
					<input type="button" value="뒤로가기"/>
				</td>
			</tr>
	</table>
	</form:form>
