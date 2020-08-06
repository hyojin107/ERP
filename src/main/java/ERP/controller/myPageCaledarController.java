package ERP.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("myCalendar")
public class myPageCaledarController {

	@GetMapping("my")
	public String myCalendar() {
		return "/mypage/calendar";
		
	}
	
	
	
	@GetMapping("official")
	public String official() {
		return "/emp/calendar";
		
	}
	
	

}
