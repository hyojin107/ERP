package vo.wareHouse;

import lombok.Data;

@Data
public class Buy_Ret_MVO {

	//원자재 반품 출고
	private String mat_in_no; //원자재입고코드
	private Integer mout_qty; //반품수량
	private String mout_date; //출고일자
	private Integer mout_no; //원자재반품출고코드
	private Integer mret_no; //원자재반품번호
}
