package vo.order;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import lombok.Data;
import lombok.NoArgsConstructor;
import validate.groups.UpdateGroup;
import vo.BuyerVO;
import vo.wareHouse.ProdVO;

/**
 * 거래명세서
 */

@Data
@NoArgsConstructor
public class TransDetailsVO implements Serializable {
//	@NotNull(groups = UpdateGroup.class)
	private Integer tran_no;	//거래명세서번호
	@NotNull
	private Integer ship_no;	//출하번호
	
	private String tran_date;	//거래명세서 작성일자
	
	private List<ShipmentVO> shipment;	//출하정보 담겨있는 리스트
	
	private List<ProdVO> prod;	//상품정보 담겨있는 리스트
	
	private List<OrderListVO> orderList;
	
	private List<OrderVO> order;
	
	private List<BuyerVO> buyerList;
}
