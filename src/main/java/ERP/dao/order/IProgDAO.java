package ERP.dao.order;

import org.springframework.stereotype.Repository;

import vo.order.DeliveryOrderVO;
import vo.order.EstimateVO;
import vo.order.OrderVO;
import vo.order.ShipmentVO;

/**
 * 진행상태 수정
 *
 */

@Repository
public interface IProgDAO {
	
	/**
	 * 견적서 진행상태 수정 (진행중, 완료)
	 * @param estimate
	 * @return
	 */
	public int updateEstimateProg(EstimateVO estimate); 
	
	/**
	 * 주문서 진행상태 수정 (진행중, 완료)
	 * @param order
	 * @return
	 */
	public int updateOrderProg(OrderVO order);
	
	/**
	 * 출하지시서 진행상태 변경 (진행중, 취소)
	 * @param delivery 
	 * @return
	 */
	public int updateDeliveryProg(DeliveryOrderVO delivery);
	
	/**
	 * 출하진행상태변경
	 * @param shipment
	 * @return
	 */
	public int updateShipmentProg(ShipmentVO shipment);
	
}
