package vo.order;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;

import lombok.Data;
import lombok.NoArgsConstructor;
import validate.groups.UpdateGroup;

/**
 * 반품상품목록
 */

@Data
@NoArgsConstructor
public class BuyerReturnListVO implements Serializable {
	@NotBlank(groups = UpdateGroup.class)
	private Integer ret_list_no;
	@NotBlank
	private Integer or_retp_no;
	@NotBlank
	private String prod_no;
	@NotBlank
	private Integer ret_list_qty;
	@NotBlank
	private String ret_status;
}
