package vo.buy;

import java.util.List;

import lombok.Data;
import vo.BuyerVO;

@Data
public class Buy_OrderVO {
	private String or_date; //발주일자
	private Integer or_code; //발주번호
	private String emp_no; //사원번호
	private String buyer_no; //거래처코드
	private String req_date; //납기요청일자
	
	private Integer matCnt;		//발주된 물품 수(mat+item 사이즈) 
	List<Buy_Order_MatVO> matList;
	List<Buy_ItemVO> itemList;
	
	private BuyerVO buyerVO;
	
	private String or_dateEnd;	//기간 검색용
	private String emp_name;	//작성자 검색용
	private String dep_name;	//부서명 -리스트 상세보기 용도
	private String status;		//발주상태 - 탭
	private List<Integer> or_codeList;	//delete용
	
	private List<Buy_Order_UnionVO> unionList;
}
