package vo.order;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import lombok.Data;
import lombok.NoArgsConstructor;
import validate.groups.UpdateGroup;
import vo.BuyerVO;
import vo.emp.EmployeeVO;
import vo.wareHouse.LprodVO;

/**
 * 주문서
 */

@Data
@NoArgsConstructor
public class OrderVO implements Serializable {
//	@NotNull(groups = UpdateGroup.class)
	private Integer or_no;		//주문서번호
	@NotBlank
	private String buyer_no;	//거래처코드
	@NotBlank
	private String emp_no;		//사원번호
	
	private Integer est_no;		//견적서번호
//	@NotBlank
	private String or_date;		//주문서작성일자
//	@NotBlank
	private String or_req_date;	//납기요청일자
//	@NotBlank
	private String or_status;	//진행상태
	
	private String status; //진행상태(탭버튼)
	
	
	private List<OrderListVO> orderList; //주문상품목록
	
	private BuyerVO buyerVO;
	
	private EmployeeVO employeeVO;
	
	private LprodVO lprodVO;
	
	private String buyer_name;
	
	private String emp_name;
	
	
}
