package ERP.controller.account;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import ERP.service.account.IChitService;
import vo.PagingVO;
import vo.account.ChitVO;

@Controller
@RequestMapping("/account/chit")
public class ChitReadController {
	@Inject
	IChitService service;
	@GetMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<ChitVO> ajaxForlist(
		ChitVO vo, Model model
		){
		return service.readChitList(vo);
	}
	@GetMapping
	public String list(){
		return "account/chit/chitList";
	}
	@GetMapping("{chit_no}")
	public String view(@PathVariable(required = true) String chit_no, Model model ) {
		ChitVO chit = service.readChit(chit_no);
		model.addAttribute("chit", chit);
		return "/account/chit/chitView";
	}
	
	@GetMapping("print")
	public String printView() {
		return "account/chit/print";
	}
}
