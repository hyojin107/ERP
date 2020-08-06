package ERP.service.order;
/**
 * 주문서
 */

import java.util.List;

import enums.ServiceResult;
import vo.PagingVO;
import vo.order.OrderListVO;
import vo.order.OrderVO;

public interface IOrderService {
	public ServiceResult createOrder(OrderVO order);
	public OrderVO readOrder(Integer or_no);
	public int readOrderCount(PagingVO<OrderVO> pagingVO);
	public List<OrderVO> readOrderList(PagingVO<OrderVO> pagingVO);
	public ServiceResult modityOrder(OrderVO order);
	public ServiceResult modityOrderList(OrderListVO orderList);
	public ServiceResult removeOrder(int or_no);
}
