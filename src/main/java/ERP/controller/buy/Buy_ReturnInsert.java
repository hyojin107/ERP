package ERP.controller.buy;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import ERP.service.buy.IBuy_ReturnService;
import enums.ServiceResult;
import vo.buy.Buy_PurchaseVO;
import vo.buy.Buy_ReturnVO;

@Controller
@RequestMapping("/buy/ret")
public class Buy_ReturnInsert {
	
	@Inject
	PurchaseRead purController;
	@Inject
	IBuy_ReturnService service;
	
	@GetMapping("form")
	public String form(Model model) {
		int currentPage = 1;
		Buy_PurchaseVO detailSearch = new Buy_PurchaseVO();
		purController.list(currentPage, detailSearch, model);	//매입서 불러오기
		
		return "buy/ret/buyReturnForm";
	}
	
	
	@PostMapping(produces="text/html;charset=UTF-8")
	@ResponseBody
	public String insert(@RequestBody Buy_ReturnVO retVO) {
		System.out.println(retVO);
		String str = "";
		ServiceResult result = service.createReturn(retVO);
		if(ServiceResult.OK.equals(result)) {
			str = "<h4>반품 신청이 완료되었습니다.</h4>";
		}else {
			str = "<h4>반품 신청이 실패하였습니다. 다시 시도해주세요.</h4>";
		}
		return str;
	}
	
}

