package ERP.service.order;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import ERP.dao.order.IProgDAO;
import enums.ServiceResult;
import vo.order.DeliveryOrderVO;
import vo.order.EstimateVO;
import vo.order.OrderVO;
import vo.order.ShipmentVO;

/**
 * 진행상태 수정
 *
 */

@Service
public class ProgServiceImpl implements IProgService {
	@Inject
	IProgDAO progDAO;

	@Override
	public ServiceResult modifyEstimateProg(EstimateVO estimate) {
		int cnt = progDAO.updateEstimateProg(estimate);
		ServiceResult result = ServiceResult.FAIL;
		if(cnt>0) {
			result = ServiceResult.OK;
		}
		return result;
	}

	@Override
	public ServiceResult modifyOrderProg(OrderVO order) {
		int cnt = progDAO.updateOrderProg(order);
		ServiceResult result = ServiceResult.FAIL;
		if(cnt>0) {
			result = ServiceResult.OK;
		}
		return result;
	}

	@Override
	public ServiceResult modifyDeliveryProg(DeliveryOrderVO delivery) {
		int cnt = progDAO.updateDeliveryProg(delivery);
		ServiceResult result = ServiceResult.FAIL;
		if(cnt>0) {
			result = ServiceResult.OK;
		}
		return result;
	}

	@Override
	public ServiceResult modifyShipmentProg(ShipmentVO shipment) {
		int cnt = progDAO.updateShipmentProg(shipment);
		ServiceResult result = ServiceResult.FAIL;
		if(cnt>0) {
			result = ServiceResult.OK;
		}
		return result;
	}
 
	
}
