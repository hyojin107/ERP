package ERP.controller.order;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import ERP.service.order.IOrderService;
import enums.ServiceResult;

@Controller
@RequestMapping("/order/order/delete")
public class OrderDeleteController {
	
	@Inject
	IOrderService service;
	
	@PostMapping(produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String delete(int or_no) {
		
		System.err.println("   주문서 삭제컨트롤러");
		
		String str = "";
//		int or_num = Integer.parseInt(or_no);
//		int or_num = or_no;
//		System.err.println("   OR_NO : " + or_num);
		ServiceResult result = service.removeOrder(or_no);
		if(ServiceResult.OK.equals(result)) {
			str = "해당 주문서가 삭제되었습니다.";
		}else {
			str = "삭제실패. 잠시후 다시 시도해주세요.";
		}
		return str;
	}
	
}
