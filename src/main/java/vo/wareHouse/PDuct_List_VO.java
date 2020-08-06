package vo.wareHouse;

import java.util.List;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

import lombok.Data;

@Data
public class PDuct_List_VO {
//생산의뢰서 물품 목록
	private Integer porder_no; //생산의뢰번호
	
	@NotNull
	private Integer pduct_no; //생산물품번호
	private String prod_no; //상품코드
	
	@Min(1)
	private Integer pduct_cnt; //수량
	
	// insert into 용 
	private List<Mat_MF_OutVO> matOutList;

	//------------------------
	private ProdVO prodvo; // wh_outer , association 에서 사용
	
	
}
