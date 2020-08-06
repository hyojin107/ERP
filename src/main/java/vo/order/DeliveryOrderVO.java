package vo.order;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import lombok.Data;
import lombok.NoArgsConstructor;
import validate.groups.UpdateGroup;
import vo.wareHouse.ProdVO;

/**
 * 출하지시서
 */

@Data
@NoArgsConstructor
public class DeliveryOrderVO implements Serializable {
//	@NotNull(groups = UpdateGroup.class)
	private Integer deliv_no; 	//출하지시서번호
	@NotNull
	private Integer or_no;		//주문서번호
	@NotBlank
	private String emp_no;		//사원번호
//	@NotBlank
	private String deliv_date;	//작성일자
//	@NotBlank
	private String deliv_prog;	//진행상태 (OR01: 진행, OR99: 취소, OR02: 완료 수진)
//	@NotBlank
	private String deliv_schd;	//출고요청일
	
	private String status; //진행상태(탭버튼 : 전체, 진행, 완료, 취소)
	
//	private OrderVO orderList;
//	@NotBlank
//	private List<OrderListVO> orderList;
	
	private List<OrderVO> order;//주문서정보를 담은 리스트
	
//	@NotBlank
	private String emp_name;	//사원이름
	
	//----------------------0722추가 
	
	private OrderVO orderVO;  // 주문서 vo 
	
	//------------ DEPARTMENT
	private String dep_no2; //상위부서코드
	private String dep_call; //내선번호

	//------------- 공통 
	private Integer rnum; 
	private Integer board_no; // 문서번호
	private String dep_name; //부서명
	private String write_date; // 작성일자
	private String out_date; // 출고요청일자 
	private String dep_no; //부서코드
	
	//---- 검색용변수 
	private String startDay;
	private String endDay;
	private String code;
	
	// --- sql 문 변수
	private String prod_no; // 상품코드
	private Integer orp_qty; // 주문 수량
	private String prod_name; // 상품명
	private Integer prod_stock; // 상품 현 재고량
	private String prod_stock_size; // 상품 수량 단위 
	private String sector_no; // 상품 창고 코드
	private Integer prod_cnt; // 상품 창고 저장 수량
	
	private Integer prod_out_no; // pk
	private String prod_sector; //창고코드 
	private String prod_out_date; // 출고일자 sysdate 
	private String prod_out_qty; // = orp_qty; 상품 출고 수량
	
	private List<ProdVO> prodList;
	
}
