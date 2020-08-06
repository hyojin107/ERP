package vo.wareHouse;

import lombok.Data;
import vo.order.OrderVO;

@Data
public class OuterDocumentVO {

	// 출하지시서 vo

	//----------- 출하지시서 (OR_DELIVERY)
	private Integer or_no; //주문서번호
	private Integer deliv_no; //출하지시서번호
	private String deliv_prog; //진행상태
	private String deliv_date; //작성일자
	private String deliv_schd; //출고요청일
	
	//------------ DEPARTMENT
	private String dep_no2; //상위부서코드
	private String dep_call; //내선번호

	//------------- 공통 
	private Integer rnum; 
	private Integer board_no; // 문서번호
	private String dep_name; //부서명
	private String emp_name; //사원명
	private String write_date; // 작성일자
	private String out_date; // 출고요청일자 
	private String emp_no; //사원번호
	private String dep_no; //부서코드
	
	//---- 검색용변수 
	private String startDay;
	private String endDay;
	private String code;
	private String status;
	
	// --- sql 문 변수
	private String prod_no; // 상품코드
	private Integer orp_qty; // 주문 수량
	private String prod_name; // 상품명
	private Integer prod_stock; // 상품 현 재고량
	private String prod_stock_size; // 상품 수량 단위 
	private String sector_no; // 상품 창고 코드
	private Integer prod_cnt; // 상품 창고 저장 수량
	
	
	private OrderVO orderVO;  // 주문서 vo 
	
}
