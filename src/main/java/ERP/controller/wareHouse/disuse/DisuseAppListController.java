package ERP.controller.wareHouse.disuse;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import ERP.service.wareHouse.IDisuseService;
import vo.product.DisStuffVO;
import vo.product.StuffVO;


// �룓湲고븳 由ъ뒪�듃�뱾�쓣 �솗�씤
@Controller
@RequestMapping("disuse/list")
public class DisuseAppListController {
	@Inject
	IDisuseService service;
	
	
	@GetMapping("mat")
	String AppList(StuffVO detailSearch, Model model, String what) {
	
		List<StuffVO> test = new ArrayList<>();
		
		
		if(what.equals("prod")) {
			test = service.readProdDisUseList(detailSearch);
		}else {
			test = service.readMatDisUseList(detailSearch);
		}
		
		
		
		model.addAttribute("mat",test);
		System.out.println(detailSearch);
		
		
		return "/wh/disuse/disMatList";
	}
	
	@GetMapping("prod")
	String AppView(StuffVO detailSearch, Model model ) {
		
		List<StuffVO> test = service.readProdDisUseList(detailSearch);
		
		
		model.addAttribute("mat",test);
		System.out.println(detailSearch);
		
		
		return "wh/disuse/disMatList";
	}
	
	
	
}
