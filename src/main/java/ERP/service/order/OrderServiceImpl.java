package ERP.service.order;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ERP.dao.order.IOrderDAO;
import enums.ServiceResult;
import exception.DataNotFoundException;
import vo.PagingVO;
import vo.order.OrderListVO;
import vo.order.OrderVO;

/**
 * 주문서 
 *
 */
@Service
public class OrderServiceImpl implements IOrderService {
	
	@Inject
	IOrderDAO orderDAO;
	
	@Transactional
	@Override
	public ServiceResult createOrder(OrderVO order) {
		int rowcnt = orderDAO.insertOrder(order);
		ServiceResult result = null;
		if(rowcnt>0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}

	@Override
	public OrderVO readOrder(Integer or_no) {
		OrderVO orderVO = orderDAO.selectOrder(or_no);
		if(orderVO==null) throw new DataNotFoundException("해당하는 주문서가 없음");
		return orderVO;
	}

	@Override
	public int readOrderCount(PagingVO<OrderVO> pagingVO) {
		return orderDAO.selectOrderCount(pagingVO);
	}

	@Override
	public List<OrderVO> readOrderList(PagingVO<OrderVO> pagingVO) {
		return orderDAO.selectOrderList(pagingVO);
	}
	
	@Transactional
	@Override
	public ServiceResult modityOrder(OrderVO order) {
		readOrder(order.getOr_no());
		int cnt = orderDAO.updateOrder(order);
		ServiceResult result = ServiceResult.FAIL;
		if(cnt>0) {
			result = ServiceResult.OK;
		}
		return result;
	}
	
	@Transactional
	@Override
	public ServiceResult modityOrderList(OrderListVO orderList) {
		int cnt = orderDAO.updateOrList(orderList);
		ServiceResult result = ServiceResult.FAIL;
		if(cnt>0) {
			result = ServiceResult.OK;
		}
		return result;
		
	}

	@Override
	public ServiceResult removeOrder(int or_no) {
		int cnt = orderDAO.deleteOrder(or_no);
		ServiceResult result = ServiceResult.FAIL;
		if(cnt>0) {
			result = ServiceResult.OK;
		}
		return result;
	}

}
