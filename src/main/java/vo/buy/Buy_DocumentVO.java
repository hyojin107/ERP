package vo.buy;

import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class Buy_DocumentVO {	// 구매 의뢰서
	private Integer rnum;
	
	private Integer buy_no; //구매요청번호
	@NotBlank
	private String emp_no; //사원번호
	private String doc_date; //요청일자
	private String doc_inDate; //입고요청일자
	
	@NotNull	
	private List<Buy_Doc_MatVO> matList;
	private Integer matCnt;		//구매요청된 원자재 수(matList 사이즈) 
	
	private String doc_dateEnd;	//기간 검색용
	private String emp_name;	//작성자 검색용
	private String dep_name;	//부서명 -리스트 상세보기 용도
	
	private String status;		//구매상태 - 탭
	private List<Integer> buy_noList;	//delete용
}
