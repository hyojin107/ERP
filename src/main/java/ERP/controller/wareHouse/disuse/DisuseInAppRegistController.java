package ERP.controller.wareHouse.disuse;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import ERP.service.wareHouse.IDisuseService;
import vo.product.DisStuffVO;


// 폐기 신청 리스트
@Controller
@RequestMapping("disuse/app")
public class DisuseInAppRegistController {
	
@Inject	
IDisuseService service;
	
// 폐기 신청 리스트 나오게	
@GetMapping
public String GetdisuseInApp() {
	
	
	
	return "wh/disuse/disRequestListView";
}


// 상품폐기 등록버튼 눌렀을 때
@GetMapping("regist")
public String RegistForm() {
	
	return "wh/disuse/disInsertForm";
}



@PostMapping("regist")
@ResponseBody
public String PostdisuseInApp(DisStuffVO disVO) {
	
	String Lware_no = disVO.getLware_no().substring(0, 4);
	
	disVO.setLware_no(Lware_no);
    disVO.setEmp_no("2020070909");
	
	service.insertStuffDisUse(disVO);
	
	
	return "redirect:wh/disuse";
}
	
// 하나 상세보기, 폐기 등록버튼 나옴
@GetMapping({"what"})
public String ViewInApp() {
	
	return "wh/disuse/disFormModalView";
	
}
	
@GetMapping("view")
public String ViewApp() {
	
	return "/wh/disuse/WarehouseModal";
}

}
