package vo.buy;

import lombok.Data;
import vo.wareHouse.MaterialVO;

@Data
public class Buy_Order_MatVO {
	private Integer buy_no; //구매요청번호
	
	private Integer ormat_code; //발주서원자재번호
	private String mat_no; //원자재코드
	private Integer or_code; //발주번호
	private Integer ormat_qty; //수량
	private Integer cost; //단가	
	
	private MaterialVO matVO;
	
	private String mat_name;
	private String lprod_name;
	private String mat_stand_size;	//규격
	
}
