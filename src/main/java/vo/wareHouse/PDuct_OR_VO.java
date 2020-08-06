package vo.wareHouse;

import java.util.List;

import javax.validation.constraints.NotNull;

import lombok.Data;

@Data
public class PDuct_OR_VO {
// 생산의뢰서
	private String porder_confirm; // 확인여부 
	private int rnum;

	@NotNull
	private int porder_no; //생산의뢰번호 // selectkey 생성 
	
	private String porder_date;  //작성일자
	private String emp_no; //사원번호
	
	private List<PDuct_List_VO> pductList; // wh_outer , collection 에서 사용
//	private PDuct_List_VO pductList;
	
	// 검색용 변수 
	private String emp_name; // 사원이름 
	private String startDay;
	private String endDay;
	
}
