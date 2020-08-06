package vo.buy;

import java.util.List;

import lombok.Data;
import vo.BuyerVO;

@Data
public class Buy_ReturnVO {
	private Integer ret_no; //반품서번호
	private Integer pur_code; //매입번호
	private String ret_date; //반품일자
	private String emp_no; //사원번호
	
	private List<Buy_Ret_MatVO> matList;
	private List<Buy_Ret_ItemVO> itemList;
	private Integer matCnt;	//반품된 물품 수
	
	private BuyerVO buyerVO;
	private List<Buy_Return_UnionVO> unionList;
	
	private String pur_date;	//매입일자 -조회용
	private String ret_dateEnd;	//기간 검색용
	private String emp_name;
	private String dep_name;
	private String buyer_no; //거래처코드
	
	private String status;		//발주상태 - 탭
	private List<Integer> ret_noList;	//delete용	
	
}
