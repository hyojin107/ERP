package ERP.dao.order;

import java.util.List;

import org.springframework.stereotype.Repository;

import vo.PagingVO;
import vo.order.DeliveryOrderVO;
import vo.order.Or_ShipmentVO;
import vo.order.ShipmentVO;

/**
 * 출하 persistence layer
 *
 */
@Repository
public interface IShipmentDAO {
	
	/**
	 * 출하등록
	 * @param shipment
	 * @return 출하등록된 수 
	 */
	public int insertShipment(ShipmentVO shipment);
	
	/**
	 * 출하 상세조회
	 * @param ship_no
	 * @return 
	 */
	public ShipmentVO selectShipment(int ship_no);
	
	/**
	 * 검색조건에 맞는 출하 수
	 * @param shipment
	 * @return
	 */
	public int selectShipmentCount(PagingVO<ShipmentVO> pagingVO);
	
	/**
	 * 검색조건에 맞는 출하 목록 조회
	 * @param shipment
	 * @return
	 */
	public List<Or_ShipmentVO> selectShipmentList();
	
	/**
	 * 출하 수정
	 * @param shipment
	 * @return
	 */
	public int updateShipment(ShipmentVO shipment);
	
	/**
	 * 출하삭제
	 * @param ship_no
	 * @return
	 */
	public int deleteShipment(int ship_no);
	
	/**
	 * 미출하현황조회
	 * @param deiv_no
	 * @return 없으면 null 반환
	 */
	public DeliveryOrderVO selectNoShipped();
	
	public int exist(int deiv_no);
	
}
