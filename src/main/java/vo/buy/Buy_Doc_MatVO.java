package vo.buy;

import lombok.Data;
import vo.wareHouse.MaterialVO;

@Data
public class Buy_Doc_MatVO {
	private Integer buy_no; //구매요청번호
	private String mat_no; //원자재코드
	private Integer qty; //수량
	private String doc_status;	//발주상태
	
	private MaterialVO matVO;
}
