package vo.wareHouse;

import java.util.List;

import lombok.Data;
import vo.product.StuffVO;

@Data
public class EnterStuffVO {

	private String stuff_key;
	private String stuff_date;
	private String pos_name;
	private String emp_name;
	private List<StuffVO> stufflist;
	
}
