package vo.order;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import lombok.Data;
import lombok.NoArgsConstructor;
import validate.groups.UpdateGroup;
import vo.BuyerVO;

/**
 * 출하
 */

@Data
@NoArgsConstructor
public class ShipmentVO implements Serializable {
//	@NotBlank(groups = UpdateGroup.class)
	private Integer ship_no; 	//출하등록번호
	@NotNull
	private Integer deliv_no;	//출하지시서번호
	@NotBlank
	private String emp_no;		//담당자
	private String emp_name; 	//담당자이름
//	@NotBlank
	private String ship_date;	//출하 작성일자
//	@NotBlank
	private String ship_p_date;	//출하일
//	@NotBlank
	private String ship_prog;	//진행상태
	
	private String status; //진행상태 탭버튼(전체 진행중OR01 완료OR02 취소OR99)
	
	private List<DeliveryOrderVO> deliveryList; //출하지시서 정보를 담은 리스트
	
	private String buyer_no;
	
	private String buyer_name;
	
	private BuyerVO buyerVO;
}
