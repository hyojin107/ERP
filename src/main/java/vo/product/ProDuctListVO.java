package vo.product;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = {"pduct_no"})
public class ProDuctListVO {
	private Integer pduct_no;
	private String prod_no;
	private Integer porder_no;
	private Integer pduct_cnt;
	private Integer pduct_discnt;
}
