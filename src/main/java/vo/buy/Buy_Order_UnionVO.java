package vo.buy;

import lombok.Data;

@Data
public class Buy_Order_UnionVO {
	private String mat_no;		//품목코드
	private String mat_name;	//품목명
	private Integer ormat_code;	//원자재코드 (원자재)
	private Integer buy_no;		//구매요청서번호 (원자재)
	private Integer qty; 		//수량
	private Integer cost;		//단가
	private String lprod;	//분류명
	private String stand_size;	//규격
	
}
