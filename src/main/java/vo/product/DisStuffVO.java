package vo.product;

import java.util.List;

import lombok.Data;
import lombok.ToString;

/**
 * @author PC-12
 *원자재 폐기
 */
@ToString
@Data
public class DisStuffVO {

	private Integer dis_mater;
	private String emp_no;
	private Integer ormat_code;
	private String dis_no;
	private String dis_date;
	private Integer dis_cnt;
	private String Lware_no;
	
	private StuffVO stuffVO;
	private List<StuffVO> dislist;
	
}
