package vo.product;

import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;
import vo.wareHouse.MaterialVO;

@Data
@EqualsAndHashCode(of = {"proder_no"})
public class PductListVO {
	
 private String proder_no;
 private String porder_date;
 private String emp_name;
 private String prod_name;
 private String pduct_cnt;


 private List<MaterialVO> materiallist;

 
}

