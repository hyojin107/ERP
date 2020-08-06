package ERP.controller.buy;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import ERP.service.buy.IBuy_OrderService;
import enums.ServiceResult;
import vo.buy.Buy_OrderVO;

@Controller
@RequestMapping("/buy/order")
public class Buy_OrderModify {
	
	@Inject
	IBuy_OrderService service;
	
	@DeleteMapping(produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String delete(@RequestBody Buy_OrderVO orVO) {
		String str = "";
		ServiceResult result = service.deleteBuyOrder(orVO);
		if(ServiceResult.OK.equals(result)) {
			str = "해당 발주서가 삭제되었습니다.";
		}else {
			str = "삭제실패. 잠시후 다시 시도해주세요.";
		}
		return str;
	}
	
}
