package ERP.service.order;

import enums.ServiceResult;
import vo.order.DeliveryOrderVO;
import vo.order.EstimateVO;
import vo.order.OrderVO;
import vo.order.ShipmentVO;

/**
 * 진행상태 수정
 *
 */
public interface IProgService {
	
	public ServiceResult modifyEstimateProg(EstimateVO estimate);
	
	public ServiceResult modifyOrderProg(OrderVO order);
	
	public ServiceResult modifyDeliveryProg(DeliveryOrderVO delivery);
	
	public ServiceResult modifyShipmentProg(ShipmentVO shipment);
	
}
