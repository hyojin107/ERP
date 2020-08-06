<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<h1>손익계산서</h1><br>
<table>
	<tfoot>
		<tr>
			<td colspan="8">
				<div class="d-block d-md-flex align-items-center d-print-none">
				<div class="form-inline d-flex ml-md-auto d-print-none" id="searchUI">
					<text>기준</text>
					<select name="searchType" class="form-control mr-2">
						<option value>년도</option>
					</select>
					<text>비교</text>
					<select name="searchType" class="form-control mr-2">
						<option value>년도</option>
					</select>
					<input class="btn btn-success mr-2" type="button" value="<spring:message code='search'/>" id="searchBtn">
				</div>
				</div>
			</td>
		</tr>
	</tfoot>
</table>
<table class="table table-bordered table-hover text-left">
	<thead class="table-primary">
		<tr>
			<th>재무제표표시명</th>
			<th>기준</th>
			<th>기준</th>
			<th>비교</th>
			<th>비교</th>
		</tr>
	</thead>
	<tbody id="listBody">
		<tr>
			<th>
				매출
			</th>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<th>
				상품매출
			</th>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<th>
			매출원가
			</th>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<th>
			상품매출원가
			</th>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<th>
			매출총이익
			</th>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<th>
			판매비 및 일반관리비
			</th>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<th>
			퇴직급여
			</th>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<th>
			일반급여
			</th>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<th>
			영업손익
			</th>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<th>
			영업외비용
			</th>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<th>
			상품폐기비용
			</th>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<th>
			당기순이익
			</th>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
	</tbody>
</table>
<form id="searchForm" action="${cPath }/account/plusMinus">
	<input type="hidden" name="base_year" value="${param.base_year }"/>
	<input type="hidden" name="compare_year" value="${param.compare_year }"/>
</form>

