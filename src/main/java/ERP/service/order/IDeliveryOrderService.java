package ERP.service.order;

import java.util.List;

import enums.ServiceResult;
import vo.PagingVO;
import vo.order.DeliveryOrderVO;
import vo.order.OrderVO;


/**
 * 출하지시서
 */
public interface IDeliveryOrderService {
	
	//주문서----------------------------------
//	public List<OrderVO> readAllOrderList();
//	
//	public OrderVO readOrder(int or_no);
	
	
	/**
	 * 출하지시서 신규등록
	 * @param delivery
	 * @return 존재하지 않는다면 DataNotFoundException, INVALIDPASSWORD, OK, FAIL
	 */
	public ServiceResult createDelivery(DeliveryOrderVO delivery);
	/**
	 * 출하지시서 상세조회
	 * @param deliv_no
	 * @return 존재하지 않는다면, DataNotFoundException 발생
	 */
	public DeliveryOrderVO readDelivery(int deliv_no);
	/**
	 * 검색조건에 맞는 출하지시서 수 조회
	 * @param delivery
	 * @return 
	 */
	public int readDeliveryCount(PagingVO<DeliveryOrderVO> pagingVO);
	/**
	 * 검색 조건에 맞는 출하지시서 목록 조회
	 * @param delivery
	 * @return
	 */
	public List<DeliveryOrderVO> readDeliveryList(PagingVO<DeliveryOrderVO> pagingVO);
	/**
	 * 출하지시서 수정
	 * @param delivery
	 * @return 존재하지 않는다면, DataNotFoundException, INVALIDPASSWORD, OK, FAIL 
	 */
	public ServiceResult modifyDelivery(DeliveryOrderVO delivery);
	/**
	 * 출하지시서 삭제 
	 * @param delivery
	 * @return 존재하지 않는다면 DataNotFoundException, INVALIDPASSWORD, OK, FAIL
	 */
	public ServiceResult removeDelivery(int deliv_no);
}
