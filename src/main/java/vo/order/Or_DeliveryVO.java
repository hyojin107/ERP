package vo.order;

import java.util.List;

import lombok.Data;

@Data
public class Or_DeliveryVO {
	private Integer deliv_no; //출하지시서번호
	private Integer or_no; //주문서번호
	private String emp_no; //사원번호
	private String deliv_date; //작성일자
	private String deliv_prog; //진행상태
	private String deliv_schd; //출고요청일
	
}
