package ERP.controller.buy;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import ERP.service.buy.IBuy_ReturnService;
import enums.ServiceResult;
import vo.buy.Buy_ReturnVO;

@Controller
@RequestMapping("/buy/ret")
public class Buy_ReturnModify {
	
	@Inject
	IBuy_ReturnService service;
	
	
	@DeleteMapping(produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String delete(@RequestBody Buy_ReturnVO retVO) {
		String str = "";
		ServiceResult result = service.deleteReturn(retVO);
		if(ServiceResult.OK.equals(result)) {
			str = "해당 반품서가 반품 취소되었습니다.";
		}else {
			str = "삭제실패. 잠시후 다시 시도해주세요.";
		}
		return str;
	}
	
}
