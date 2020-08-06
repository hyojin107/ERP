package vo.wareHouse;

import lombok.Data;

@Data
public class Prod_InVO {
// 상품 입고
	private Integer pduct_no; //생산물품번호
	private Integer prod_in_no; //상품입고코드
	private String prod_no; //상품코드
	private Integer prod_in_qty; //입고수량
	private Integer prod_sector; //상품창고코드
	private String prod_in_date; //입고일자
}
