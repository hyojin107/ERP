package ERP.controller.order;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ERP.dao.order.IProgDAO;
import vo.order.DeliveryOrderVO;
import vo.order.EstimateVO;
import vo.order.OrderVO;
import vo.order.ShipmentVO;

@Controller
@RequestMapping("/order/prog")
public class ProgController {
	
	@Inject
	IProgDAO progDAO;
	
	@GetMapping("estimate")
	@ResponseBody
	public int estimateProg(
//			@PathVariable(name = "est_no", required = true) String est_no,
			EstimateVO estimateVO, RedirectAttributes redirectAttribute
	) {
		
		int result = progDAO.updateEstimateProg(estimateVO);
		return result;
	}
	
	@GetMapping("order")
	@ResponseBody
	public int orderProg(
//			@PathVariable(name = "est_no", required = true) String est_no,
			OrderVO orderVO, RedirectAttributes redirectAttribute
			) {
		int result = progDAO.updateOrderProg(orderVO);
		return result;
	}
	
	
	@GetMapping("delivery")
	@ResponseBody
	public int deliveryProg(
//			@PathVariable(name = "est_no", required = true) String est_no,
			DeliveryOrderVO deliveryVO, RedirectAttributes redirectAttribute
			) {
		int result = progDAO.updateDeliveryProg(deliveryVO);
		return result;
	}
	
	
	@GetMapping("shipment")
	@ResponseBody
	public int shipmentProg(
//			@PathVariable(name = "est_no", required = true) String est_no,
			ShipmentVO shipmentVO, RedirectAttributes redirectAttribute
			) {
		int result = progDAO.updateShipmentProg(shipmentVO);
		return result;
	}
	
	
}
