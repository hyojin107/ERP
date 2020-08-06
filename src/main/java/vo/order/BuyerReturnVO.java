package vo.order;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;

import lombok.Data;
import lombok.NoArgsConstructor;
import validate.groups.UpdateGroup;

/**
 * 상품반품
 */

@Data
@NoArgsConstructor
public class BuyerReturnVO implements Serializable {
	@NotBlank(groups = UpdateGroup.class)
	private Integer or_retp_no;
	@NotBlank
	private Integer ship_no;
	@NotBlank
	private String emp_no;
	@NotBlank
	private String or_retp_date;
}
