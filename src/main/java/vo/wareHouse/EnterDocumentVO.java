package vo.wareHouse;

import lombok.Data;

@Data
public class EnterDocumentVO {

	// 매입서, 반품의뢰서, 생산보고서 vo
	
	//----------- 생산보고서 (PROD_REPORT) 
	private Integer rep_no; //생산보고서번호
	private Integer porder_no; //생산의뢰번호
	private Integer pduct_discnt; //폐기수량
	private String rep_date; //작성일자
	
	// ------------ 매입서 (BUY_PURCHASE)
	private Integer pur_code; //매입번호
	private Integer or_code; //발주번호
	private String pur_date; //매입일자
	
	// ------------- 반품서 (OR_RETURN_P)
	private Integer or_retp_no; //상품반품번호
	private Integer ship_no; //출하등록번호
	private String or_retp_date; //반품요청일자
	
	
	// 공통 
	private String emp_no; //사원번호
	
	// 검색용 
	//---- 검색용변수 
	private String startDay;
	private String endDay;
	private String code;
}
