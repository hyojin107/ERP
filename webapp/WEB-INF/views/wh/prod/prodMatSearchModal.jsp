<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!-- 원자재 검색하는 모달 창  -->


<table>
	<thead>
		<tr>
			<th>
				<label for="mat">
					<spring:message code="mat.mat_name"/>
				</label>
			</th>
			<td>
				<input type="text" id="mat" name="mat_name" placeholder="검색어를 입력하세요" >
			</td>
			<td>
				<button type="button" id="searchBtn">검색</button>
			</td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>
				<div>
					<div id="log" style="overflow:auto;"></div>
				</div>
			</td>
		</tr>
	</tbody>
</table>

<script type="text/javascript" >
		function log(message){
			$("<div>").text(message).prependTo("#log");
			$("#log").scrollTop(0);
		}
		
		var text = ["사과나무","사과","ActionScript", "AppleScript",
		      "Asp", "BASIC", "C",
		      "C++","Clojure","COBOL",
		      "ColdFusion","Erlang",
		      "Fortran","Groovy","Haskell",
		      "Java", "JavaScript",
		      "Lisp","Perl","PHP",
		      "Python", "Ruby",
		      "Scala","Scheme"];
		
		$("#mat").autocomplete({
			source:text,
			autoFocus:true,
			position : {my:"center",at:"center", collision:"flip"}
		});
</script>