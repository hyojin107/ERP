<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<h1>입고관리 : 구매요청서 상세보기 모달창</h1>

<table class="table">
	<tr>
		<th>문서번호</th>
		<th>작성자</th>
		<th>요청일자</th>
		<th>마감일자</th>
		<th>원자재 코드</th>
		<th>원자재명</th>
		<th>요청수량</th>
	</tr>
	<tr>
		<td>(문서번호)</td>
		<td>(작성자)</td>
		<td>(요청일자)</td>
		<td>(마감일자)</td>
		<td>(원자재 코드)</td>
		<td>(원자재명)</td>
		<td>(요청수량)</td>
	</tr>
	<tfoot>
		<tr>
		<td colspan="6"></td>
			<td>
				<input type="button" value="뒤로가기" onclick="history.back();"/>
			</td>
		</tr>
	</tfoot>
</table>
