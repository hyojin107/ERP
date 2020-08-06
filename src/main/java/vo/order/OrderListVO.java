package vo.order;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.NotBlank;

import lombok.Data;
import lombok.NoArgsConstructor;
import validate.groups.UpdateGroup;
import vo.wareHouse.ProdVO;

/**
 * 주문서상품목록
 *
 */

@Data
@NoArgsConstructor
public class OrderListVO implements Serializable {
	@NotBlank(groups = UpdateGroup.class)
	private Integer orp_no;
	@NotBlank
	private String prod_no;
	@NotBlank
	private Integer or_no;
	@NotBlank
	private Integer orp_qty;	//수량
	@NotBlank
	private Integer orp_price;	//단가
	
	private List<ProdVO> prodList;
	
	private ProdVO prodVO;  // 수진 추가 
	
	private String prod_name;	//상품명
	private String lprod_name;	//분류명
	private String prod_stand_size;	//규격단위
	
}
