<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<h1>출고관리 : 생산의뢰서 상세보기(자재팀이 작성한 문서를 상세히 볼 수 있다.)</h1>
<table class="table">
	<thead>
		<tr>
			<th><!-- 생산의뢰번호 -->
				<spring:message code="pductor.poroder_no"/> 
			</th>
			<td>${pductOrVO.porder_no }</td>
		</tr>
		<tr>
			<th><!-- 사원이름 -->
				<spring:message code="pductor.emp_name"/>
			</th>
			<td>${pductOrVO.emp_name }</td>
		</tr>
		<tr>
			<th><!-- 작성일자 -->
				<spring:message code="pductor.porder_date"/>
			</th>
			<td>${pductOrVO.porder_date }</td>
		</tr>
		<c:choose>
			<c:when test="${not empty pductOrVO.pductList}">
				<c:forEach items="${pductOrVO.pductList }" var="pductlist">
					<tr>
						<th>
							<spring:message code="pductlist.prod_no"/>
						</th>
						<td>${pductlist.prod_no }</td>
					</tr>
					<tr>
						<th>
							<spring:message code="prod.prod_name"/>
						</th>
						<td>${pductlist.prodvo.prod_name }</td>
					</tr>
					<tr>
						<th>
							<spring:message code="pductlist.pduct_cnt"/>
						</th>
						<td>${pductlist.pduct_cnt }</td>
					</tr>
					<tfoot>
					<tr>
						<th>BOM</th>
					</tr>
					<tr>
						<th>
							<spring:message code="bom.mat_no"/>
						</th>
						<th>
							<spring:message code="mat.mat_name"/>
						</th>
						<th>
							<spring:message code="bom.mat_number"/>
						</th>
						<th>
							<spring:message code="bom.mat_size"/>
						</th>
					</tr>
						<c:choose>
							<c:when test="${not empty pductOrVO.pductList}">
								<c:forEach items="${pductOrVO.pductList }" var="pductlist">
									<c:forEach items="${pductlist.prodvo.bomlist }" var="bom">
										<c:forEach items="${bom.matList }" var="mat">
											<tr>
												<td>${bom.mat_no}</td>
												<td>${mat.mat_name }</td>
												<td>${bom.mat_number }</td>
												<td>${bom.mat_size }</td>
											</tr>
										</c:forEach>
									</c:forEach>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<th></th>
									<th colspan="3">BOM 정보 없음</th>
								</tr>
							</c:otherwise>
						</c:choose>
					</tfoot>
				</c:forEach>
			</c:when>
		</c:choose>
	</thead>
</table>