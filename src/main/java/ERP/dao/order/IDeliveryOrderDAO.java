package ERP.dao.order;

import java.util.List;

import org.springframework.stereotype.Repository;

import vo.PagingVO;
import vo.order.DeliveryOrderVO;
import vo.order.OrderVO;


/**
 * 출하지시서 persistence layer
 *
 */

@Repository
public interface IDeliveryOrderDAO {
	
	
//	//주문서----------------------------------
//	/**
//	 * 모든 주문서 가져오기 
//	 */
//	public List<OrderVO> selectAllOrder();
//	
//	/**
//	 * 주문서 상세조회
//	 * @param or_no
//	 * @return 존재하지 않으면  null 반환
//	 */
//	public OrderVO selectOrder(int or_no);
//	
	
	/**
	 * 신규등록
	 * @param delivery
	 * @return 등록된 출하지시서수
	 */
	public int insertDelivery(DeliveryOrderVO delivery);
	
	public DeliveryOrderVO selectDelivery(int deiv_no);
	
	/**
	 * 검색조건에 맞는 출하지시서  수 조회
	 * @param pagingVO
	 * @return
	 */
	public int selectDeliveryCount(PagingVO<DeliveryOrderVO> pagingVO);
	
	/**
	 * 검색조건에 맞는 출하지시서 목록 조회
	 * @param pagingVO
	 * @return
	 */
	public List<DeliveryOrderVO> selectDeliveryList(PagingVO<DeliveryOrderVO> pagingVO);
	
	/**
	 * 출하지시서수정
	 * @param delivery
	 * @return
	 */
	public int updateDelivery(DeliveryOrderVO delivery);
	
	/**
	 * 출하지시서 삭제
	 * @param deiv_no
	 * @return
	 */
	public int deleteDelivery(int deiv_no);
	
	public int exist(int or_no);
	
}
