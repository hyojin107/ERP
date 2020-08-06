package vo.product;
// 생산보고서 
import java.util.List;

import javax.validation.constraints.NotBlank;

import lombok.Data;
import lombok.ToString;
import vo.wareHouse.MaterialVO;


@ToString
@Data
public class PdReportVO {
	private String rep_no; 
	
	@NotBlank
	private String porder_no; 
	@NotBlank
	private String emp_no; 
	private String rep_date;
	private Integer pduct_discnt;
	private String emp_name;
	
	private List<MaterialVO> meterial;
	
}
