package vo.wareHouse;

import lombok.Data;

@Data
public class Prod_DisUseVO {
// 상품 폐기등록서
	private String pdis_date; //폐기일자
	private Integer pdis_cnt; //폐기수량
	private String emp_no; //사원번호
	private String prod_no; //상품코드
	private Integer pdis_prod; //상품폐기번호
	private Integer ret_list_no; //반품상품목록번호
}
