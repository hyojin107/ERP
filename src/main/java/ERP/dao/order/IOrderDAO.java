package ERP.dao.order;

import java.util.List;

import org.springframework.stereotype.Repository;

import vo.PagingVO;
import vo.order.OrderListVO;
import vo.order.OrderVO;

/**
 * 주문서를 위한 persistencelayer
 *
 */
@Repository
public interface IOrderDAO {
	
	/**
	 * 기존에 존재하는 orp no 를 조회하는 
	 * @return
	 */
	public int selectOrpNo();
	
	/**
	 * 새 주문서 등록
	 * @param order
	 * @return 등록된 주문서 수
	 */
	public int insertOrder(OrderVO order);
	
	/**
	 * 주문서 상세조회
	 * @param or_no
	 * @return 존재하지 않으면 null 반환
	 */
	public OrderVO selectOrder(Integer or_no);
	
	/**
	 * 검색조건에 맞는 주문서 수 조회
	 * @param pagingVO
	 * @return
	 */
	public int selectOrderCount(PagingVO<OrderVO> pagingVO);
	
	/**
	 * 검색조건에 맞는 주문서 목록 조회
	 * @param pagingVO
	 * @return
	 */
	public List<OrderVO> selectOrderList(PagingVO<OrderVO> pagingVO);

//정보수정-----------------------------------------------------------------------
	/**
	 * 주문서 수정
	 * @param order
	 * @return
	 */
	public int updateOrder(OrderVO order);
	
	public int updateOrList(OrderListVO orderList);
	
//정보수정-----------------------------------------------------------------------	

	/**
	 * 주문서 삭제
	 * @param or_no
	 * @return
	 */
	public int deleteOrder(int or_no);
	
}
