package vo.buy;

import lombok.Data;

@Data
public class Buy_ItemVO {
	private String item_no; //일반물품코드
	private Integer or_code; //발주번호
	private String item_name; //일반물품명
	private Integer item_qty; //수량
	private Integer item_cost; //단가
	private String item_lprod;	//분류명
	private String item_stand_size;	//규격단위
}
