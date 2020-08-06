package vo.product;

import java.io.Serializable;
import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import vo.SearchVO;

/**
 * @author �엫�닔吏�
 *	李쎄퀬 VO
 */
@Data
@ToString
public class WareHouseVO implements Serializable{
	private String store_no;
	private String lstore_no;
	private String store_name;
	private String store_def;
	private String use_status;
	private List<MaterialSectorVO> matList;
	private List<ProdSectorVO> prodList;
	private SearchVO searchvo;
		

}
