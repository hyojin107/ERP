package vo.order;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import lombok.Data;
import lombok.NoArgsConstructor;
import validate.groups.UpdateGroup;
import vo.wareHouse.ProdVO;

/**
 * 견적서상품목록
 */

@Data
@NoArgsConstructor
public class EstimateListVO implements Serializable {
	@NotNull(groups = UpdateGroup.class)
	private String prod_no;
	@NotNull
	private Integer est_no;
	@NotNull
	private Integer est_qty;
	
	private List<ProdVO> prodList;
}
