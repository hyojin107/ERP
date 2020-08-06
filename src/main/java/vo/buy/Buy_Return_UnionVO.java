package vo.buy;

import lombok.Data;

@Data
public class Buy_Return_UnionVO {
	private Integer retmat_no;	//반품원자재번호
	private Integer ormat_code;	//원자재코드(원자재만)
	private String mat_no;		//품목코드
	private Integer qty;		//반품수량
	private String mat_name;	//품목명
	private String lprod_name;	//분류명
	private String stand_size;	//규격
	private Integer cost;		//단가
}
