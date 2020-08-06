package vo.product;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "porder_no")
public class PductorderVO {

	private Integer porder_no;
	private String emp_name;
	private String prod_name;
	private String porder_date;
	private Integer pduct_cnt;
	private String prod_no;
	
}
