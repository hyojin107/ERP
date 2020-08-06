package ERP.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import ERP.service.IQRCodeService;
import enums.ServiceResult;
import vo.emp.EmployeeVO;

@Controller
@RequestMapping("/qrCode")
public class QR_CodeController {
	
//	@Inject
//	IQRCodeService service;
	
	@GetMapping
	public String loginQR() {	//로그인페이지
		return "/qrCode";
	}
	
	@PostMapping
	public String workTime(EmployeeVO empVO, Model model) {	//출퇴근시간 등록
		System.out.println("데이터 도착? : " + empVO);
		String str = "";
//		String res = "";
//		ServiceResult result = service.createWork(empVO);
//		if(ServiceResult.OK.equals(result)) {
//			str = "/qrResult";  // 성공
//			res = "출근 등록!";
//		}else if(ServiceResult.WORKEND.equals(result)) {	//퇴근성공
//			str = "/endQRCode"; 
//			res = "퇴근 등록!";
//		}else {
//			res = "등록실패! 잠시후 다시 시도해주세요.";
//		}
//		model.addAttribute("result", res);
		return str;
	}
	
}
