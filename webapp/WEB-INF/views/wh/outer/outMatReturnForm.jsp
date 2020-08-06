<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>출고관리 : 반품의뢰서 작성 폼 </title>
</head>
<body>
<h1>출고관리 : 원자재 반품의뢰서 작성 폼 , 반품시킬 원자재의 정보를 입력하고 등록한다.매입서 정보가져오기 </h1>
<form:form>
	<table class="table table-striped">
		<tr>
			<td>문서번호</td>
			<td>
				<input type="text" name="">
				<form:errors path="" element="span" cssClass="error"/>
			</td>
		</tr>
		<tr>
			<td>작성자</td>
			<td>
				<input type="text" name=""/>
				<form:errors path="" element="span" cssClass="error"/>
			</td>
		</tr>
		<tr>
			<td>작성일자</td>
			<td>
				<input type="date" name=""/>
			</td>
		</tr>
		<tr>
			<td>입고일자</td>
			<td>
				<input type="date" name=""/> 
			</td>
		</tr>
		<tr>
			<td>원자재 코드</td>
			<td>
				<input type="text" name=""/> 
				<form:errors path="" element="span" cssClass="error"/>
			</td>
		</tr>
		<tr>
			<td>원자재 명</td>
			<td> 
				<input type="text" name="" />
				<form:errors path="" element="span" cssClass="error"/>
			</td>
		</tr>
		<tr>
			<td>수량</td>
			<td> 
				<input type="number" name="" />
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="저장"/>
				<input type="reset" value="다시쓰기"/>
				<input type="button" value="뒤로가기" onclick="history.back();"/>
				<input type="button" value="목록으로 " onclick="location.href='${cPath}/outer/matreturn/list';"/>
			</td>
		</tr>
	</table>
</form:form>

</body>
</html>