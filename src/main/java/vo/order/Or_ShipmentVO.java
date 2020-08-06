package vo.order;

import lombok.Data;

@Data
public class Or_ShipmentVO {
	
	private Integer ship_no; //출하등록번호
	private Integer deliv_no; //출하지시서번호
	private String emp_no; //사원번호
	private String ship_date; //작성일자
	private String ship_p_date; //출하일
	private String ship_prog; //진행상태
	
	
	private Or_DeliveryVO deliveryVO;	//출하지시서
	private OrderVO orderpVO;	//주문서
	
	private String ship_dateEnd;	//기간 검색용
	private String emp_name;	//작성자 검색용
	private String dep_name;	//부서명 -리스트 상세보기 용도
	private String status;		//발주상태 - 탭
	
}
