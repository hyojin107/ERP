package vo.buy;

import lombok.Data;
import vo.wareHouse.MaterialVO;

@Data
public class Buy_Ret_MatVO {	
	private Integer ret_no; //반품서번호
	private Integer retmat_no; //반품원자재번호
	private Integer ormat_code; //발주서원자재번호
	private String retmat_date; //반품일자
	private Integer retmat_qty; //반품수량
	
	private MaterialVO matVO;
	
	private String mat_no; //원자재코드
	private String mat_name;	//품목명
	private String lprod_name;	//분류명
	private String mat_stand_size;	//규격
	private Integer cost; //단가	
	
}
