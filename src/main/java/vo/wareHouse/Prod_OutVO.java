package vo.wareHouse;

import lombok.Data;

@Data
public class Prod_OutVO {
// 상품 출고
	private Integer prod_out_no; //상품출고코드
	private String prod_out_date; //출고일자
	private Integer prod_in_no; //상품입고코드
	private Integer deliv_no; //출하지시서번호
	private Integer prod_out_qty; //출고수량
}
