package vo.product;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

/**
 * @author �엫�닔吏�
 * 李쎄퀬 援ъ뿭 VO
 */
@Data
@ToString
@EqualsAndHashCode(of = {"sector_no"})
public class WareSectorVO {

	private String sector_no;
	private String store_no;
	
}
