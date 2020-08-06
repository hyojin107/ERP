package ERP.service.order;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import ERP.dao.order.IDeliveryOrderDAO;
import enums.ServiceResult;
import exception.DataNotFoundException;
import vo.PagingVO;
import vo.order.DeliveryOrderVO;
import vo.order.OrderListVO;
import vo.order.OrderVO;

@Service
public class DeliveryServiceImpl implements IDeliveryOrderService {
	
	@Inject
	IDeliveryOrderDAO deliveryDAO;
	
	
//	@Override
//	public List<OrderVO> readAllOrderList() {
//		return deliveryDAO.selectAllOrder();
//	}
//
//	@Override
//	public OrderVO readOrder(int or_no) {
//		OrderVO orderVO = deliveryDAO.selectOrder(or_no);
//		if(orderVO==null) throw new DataNotFoundException(orderVO.getOr_no()+"상품이 없음");
//		return null;
//	}

	@Override
	public ServiceResult createDelivery(DeliveryOrderVO delivery) {
		int exist = deliveryDAO.exist(delivery.getOr_no());
		if(exist > 0) return ServiceResult.FAIL;
		int rowcnt = deliveryDAO.insertDelivery(delivery);
		ServiceResult result = null;
		if(rowcnt>0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}

	@Override
	public DeliveryOrderVO readDelivery(int deliv_no) {
		DeliveryOrderVO deliveryVO = deliveryDAO.selectDelivery(deliv_no);
		if(deliveryVO==null) throw new DataNotFoundException();
		return deliveryVO;
	}

	@Override
	public int readDeliveryCount(PagingVO<DeliveryOrderVO> pagingVO) {
		return deliveryDAO.selectDeliveryCount(pagingVO);
	}

	@Override
	public List<DeliveryOrderVO> readDeliveryList(PagingVO<DeliveryOrderVO> pagingVO) {
		return deliveryDAO.selectDeliveryList(pagingVO);
	}

	@Override
	public ServiceResult modifyDelivery(DeliveryOrderVO delivery) {
		int cnt = deliveryDAO.updateDelivery(delivery);
		ServiceResult result = ServiceResult.FAIL;
		if(cnt>0) {
			result = ServiceResult.OK;
		}
		return result;
	}

	@Override
	public ServiceResult removeDelivery(int deliv_no) {
		int cnt = deliveryDAO.deleteDelivery(deliv_no);
		ServiceResult result = ServiceResult.FAIL;
		if(cnt>0) {
			result = ServiceResult.OK;
		}
		return result;
	}

}
