package vo.wareHouse;

import lombok.Data;

@Data
public class Prod_Ret_InVO {
//상품 반품 입고
	private Integer ret_in_no; //반품상품입고코드
	private String ret_in_date; //입고일자
	private Integer ret_list_no; //반품상품목록번호
	private Integer prod_sector; //상품창고코드
}
