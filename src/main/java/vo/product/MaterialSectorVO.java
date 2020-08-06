package vo.product;

import lombok.Data;

/**
 * @author PC-12
 * WareHouseSector�쓽 援щ텇�젏 materialSectorVO
 * Sector - �썝�옄�옱 or �젣�뭹
 *
 */
@Data
public class MaterialSectorVO {
	
	private String mat_sector_no;
	private String mat_no;
	private String msector_no;
	private Integer mat_cnt;
	private String mat_stock_size;
	private String mat_name;
	
	// SQL용 
	private Integer porder_no;
}
