package vo.buy;

import java.util.List;

import lombok.Data;

@Data
public class Buy_Ret_ItemVO {
	private Integer ret_no; //반품서번호
	private Integer retitem_no; //반품일반번호
	private String item_no; //일반물품코드
	private String retitem_date; //반품일자
	private Integer retitem_qty; //반품수량
	
	List<Buy_ItemVO> itemList;
	
	private String item_name; //일반물품명
	private Integer item_cost; //단가
	private String item_lprod;	//분류명
	private String item_stand_size;	//규격단위
}
