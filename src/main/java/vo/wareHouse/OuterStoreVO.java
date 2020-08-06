package vo.wareHouse;

import lombok.Data;

@Data
public class OuterStoreVO {
	// 공통 
	private String sector_no; //창고구역번호
	private String store_no="0000"; //창고코드
	
	private Integer mat_stock;
	private Integer prod_stock;
	
	// store - 창고
	private String store_name; //창고명
	private String lstore_no; //창고분류코드
	private String store_def; //설명
	private String use_status; //사용여부
	
	// mat_sector - 원자재 창고 
	private String mat_no="00000"; //원자재코드
	private Integer mat_cnt; //원자재갯수
	private String mat_sector_no; //원자재창고구역번호
	
	// prod_sector - 상품 창고 
	private String prod_sector; //상품창고코드
	private String prod_no="00000"; //상품코드
	private Integer prod_cnt; //상품수량
}
