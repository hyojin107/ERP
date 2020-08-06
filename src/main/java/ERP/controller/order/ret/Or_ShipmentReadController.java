package ERP.controller.order.ret;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import ERP.dao.order.IShipmentDAO;
import vo.order.Or_ShipmentVO;

@Controller
@RequestMapping("/order/shipment")
public class Or_ShipmentReadController {
	
	@Inject
	IShipmentDAO dao;
	
	@GetMapping
	public String list() {
		return "order/shipment/or_shipmentList";
	}
	
	@GetMapping(produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, List<Or_ShipmentVO>> ajaxtData(){
		Map<String, List<Or_ShipmentVO>> map = new HashMap<>();
		map.put("data", dao.selectShipmentList());
		return map;
	}
	
}
