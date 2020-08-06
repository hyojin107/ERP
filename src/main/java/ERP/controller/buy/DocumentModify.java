package ERP.controller.buy;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import ERP.service.buy.IBuy_DocService;
import enums.ServiceResult;
import vo.buy.Buy_DocumentVO;

@Controller
@RequestMapping("/buy/document")
public class DocumentModify {
	
//	@Inject
//	IBuy_DocService service;
	
	@DeleteMapping(produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String delete(@RequestBody Buy_DocumentVO docVO) {
		String str = "";
//		ServiceResult result = service.deleteBuyDoc(docVO);
//		if(ServiceResult.OK.equals(result)) {
//			str = "해당 구매요청서가 삭제되었습니다.";
//		}else {
//			str = "삭제실패. 잠시후 다시 시도해주세요.";
//		}
		return str;
	}
	
}
