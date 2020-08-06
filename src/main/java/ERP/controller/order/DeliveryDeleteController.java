package ERP.controller.order;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import ERP.service.order.IDeliveryOrderService;
import enums.ServiceResult;

@Controller
@RequestMapping("/order/delivery/delete")
public class DeliveryDeleteController {
	@Inject
	IDeliveryOrderService service;
	
	@PostMapping(produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String delete(int deliv_no) {
		
		System.err.println("   출하지시서 삭제컨트롤러");
		System.err.println("   deliv_no : " + deliv_no );
		
		String str = "";
		ServiceResult result = service.removeDelivery(deliv_no);
		if(ServiceResult.OK.equals(result)) {
			str = "해당 출하지시서가 삭제되었습니다.";
		}else {
			str = "삭제실패. 잠시후 다시 시도해주세요.";
		}
		return str;
	}
	
}
