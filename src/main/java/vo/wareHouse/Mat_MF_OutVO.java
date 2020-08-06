package vo.wareHouse;

import lombok.Data;

@Data
public class Mat_MF_OutVO {

	// 원자재 생산 출고 
	private Integer pduct_no; //생산물품번호
	private String mat_no; //원자재코드
	private String mf_date; //출고일자
	private Integer mf_no; //원자재 생산출고
	
	//update용
	private String store_no;	//창고코드
	private String sector_no;	//창고구역번호
	private Integer mat_cnt;	//원자재갯수	
	
	private Integer porder_no; //생산의뢰번호
}
