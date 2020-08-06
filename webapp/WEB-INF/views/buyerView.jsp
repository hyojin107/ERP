<%--
* [[개정이력(Modification Information)]]
* 	수정일                 수정자      		수정내용
* ----------  ---------  -----------------
* 2020. 7. 2        송효진      		최초작성
* Copyright (c) 2020 by DDIT All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<table class="table table-bordered">
	<tr>
		<th>거래처코드</th>
		<td>${buyer.buyer_no }</td>
	</tr>
	<tr>
		<th>거래처명</th>
		<td>${buyer.buyer_name }</td>
	</tr>
	<tr>
		<th>대표자명</th>
		<td>${buyer.buyer_rep }</td>
	</tr>
	<tr>
		<th>회사전화번호</th>
		<td>${buyer.buyer_tel }</td>
	</tr>
	<tr>
		<th>우편번호</th>
		<td>${buyer.buyer_zip }</td>
	</tr>
	<tr>
		<th>주소</th>
		<td>${buyer.buyer_addr }</td>
	</tr>
	<tr>
		<th>상세주소</th>
		<td>${buyer.buyer_addr2 }</td>
	</tr>
	<tr>
		<th>담당자명</th>
		<td>${buyer.charger_name }</td>
	</tr>
	<tr>
		<th>담당자 이메일</th>
		<td>${buyer.charger_email }</td>
	</tr>
	<tr>
		<th>담당자 연락처</th>
		<td>${buyer.charger_phone }</td>
	</tr>
	<tr>
		<th>업종</th>
		<td>${buyer.buyer_sector }</td>
	</tr>
	<tr>
		<th>은행명</th>
		<td>${buyer.buyer_bank }</td>
	</tr>
	<tr>
		<th>예금주</th>
		<td>${buyer.buyer_bankname }</td>
	</tr>
	<tr>
		<th>계좌번호</th>
		<td>${buyer.buyer_bankno }</td>
	</tr>
	<tr>
		<th>거래여부</th>
		<td>${buyer.use_status }</td>
	</tr>
	<tr>
		<th>비고</th>
		<td>${buyer.etc }</td>
	</tr>
</table>