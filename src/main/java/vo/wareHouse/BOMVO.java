package vo.wareHouse;

import java.util.List;

import lombok.Data;

@Data
public class BOMVO {
	private String prod_no; //상품코드
	private String mat_no; //원자재코드
	private String mat_size; //원자재 단위
	private Integer mat_number; //원자재수량
	
	private MaterialVO matVO;	//원자재
	
	private List<MaterialVO> matList; // wh_outer , collection 에서 사용
}
