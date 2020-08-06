package ERP.service.order;

import java.util.List;

import enums.ServiceResult;
import vo.PagingVO;
import vo.order.DeliveryOrderVO;
import vo.order.ShipmentVO;

/**
 * 출하
 */
public interface IShipmentService {
	public ServiceResult createShipment(ShipmentVO shipment);
	public ShipmentVO readShipment(int ship_no);
	public int readShipmentCount(PagingVO<ShipmentVO> pagingVO);
//	public List<ShipmentVO> readShipmentList(PagingVO<ShipmentVO> pagingVO);
	public ServiceResult modifyShipment(ShipmentVO shipment);
	public ServiceResult deleteShipment(int ship_no);
	public List<DeliveryOrderVO> readNoShippedList();
}
