package vo.product;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author PC-12
 * �깮�궛遺꾨쪟 肄붾뱶
 */
@Data
@EqualsAndHashCode(of = {"lstore_no"})
public class LWareHouseVO {
	private String lstore_no;
	private String lstore_name;

}
