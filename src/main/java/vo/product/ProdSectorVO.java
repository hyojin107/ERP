package vo.product;

import java.io.Serializable;

import lombok.Data;

/**
 * @author PC-12
 * Sector�쓽 援щ텇�젏 
 * Sector�� 1:1 愿�怨�
 * Sector媛� ProdSector瑜� 臾댁“嫄� 1�븯�굹瑜� 媛�吏�怨� �엳�뼱�빞 �븳�떎.
 */
@Data
public class ProdSectorVO implements Serializable{

	private String prod_sector;
	private String prod_no;
	private String psecter_no;
	private String prod_name;
	private String prod_cnt;
	private String prod_stock_size;
	
	
}
