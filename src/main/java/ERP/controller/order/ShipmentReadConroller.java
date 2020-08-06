package ERP.controller.order;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import ERP.service.order.IShipmentService;
import vo.PagingVO;
import vo.order.ShipmentVO;

@Controller
@RequestMapping("/order/shipment")
public class ShipmentReadConroller {
	
	@Inject
	IShipmentService shipmentService;
	
//	@GetMapping(produces = "application/json;charset=UTF-8")
//	@ResponseBody
//	public PagingVO<ShipmentVO> ajaxList(
//			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
//			ShipmentVO detailSearch, Model model
//	){
//		list(currentPage, detailSearch, model);
//		PagingVO<ShipmentVO> pagingVO = (PagingVO<ShipmentVO>) model.asMap().get("pagingVO");
//		return pagingVO;
//	}
	
//	@GetMapping
//	public String list(
//			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
//			ShipmentVO detailSearch, Model model
//	) {
//		
//		PagingVO<ShipmentVO> pagingVO = new PagingVO<>();
//		pagingVO.setDetailSearch(detailSearch);
//		pagingVO.setCurrentPage(currentPage);
//		
//		int totalRecord = shipmentService.readShipmentCount(pagingVO);
//		
//		System.err.println("출하 리스트 도착???");
//		
//		List<ShipmentVO> shipmentList = shipmentService.readShipmentList(pagingVO);
//		
//		System.err.println("	 	shipmentList : " + shipmentList);
//		
//		pagingVO.setTotalRecord(totalRecord);
//		pagingVO.setDataList(shipmentList);
//
//		//페이징 vo에 데이터가 다있으니까 보내주기!
//		model.addAttribute("pagingVO", pagingVO);
//				
//		//논리적인 view name
//		return "order/shipment/shipmentList";
//	}
//	
//	@GetMapping("{ship_no}")
//	public String view(
//			@PathVariable(name = "ship_no", required = true) String ship_no, Model model
//	) {
//		int ship_num = Integer.parseInt(ship_no);
//		ShipmentVO shipmentList = shipmentService.readShipment(ship_num);
//		model.addAttribute("shipment", shipmentList);
//		
//		return "/order/shipment/shipmentView";
//	}
}
