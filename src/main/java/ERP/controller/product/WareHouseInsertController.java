package ERP.controller.product;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.WebApplicationContext;

import ERP.service.product.wareHouseServiceImpl;
import ERP.service.wareHouse.IDisuseService;
import vo.product.WareHouseVO;
import vo.product.WareSectorVO;

@Controller
@RequestMapping("ware/manger")
public class WareHouseInsertController {
	

	@Inject
	wareHouseServiceImpl service;
	
	@Value("#{appInfo.WareJsonPath}") 
	String WareJsonPath;
	String folderPath;
	
	//서버사이드 주소를 가져와서  json파일이 있는지에 대한 여부를 체크 한 후에 리턴시켜주는 방법
	@Inject
	WebApplicationContext container;
	ServletContext application;
	@PostConstruct 
	public void init() {
		application = container.getServletContext();
		 folderPath = application.getRealPath(WareJsonPath);
		File saveFolder = new File(folderPath); // folder의 위치에 파일 저장
		if(!saveFolder.exists()) saveFolder.mkdirs(); // 만약 없다면 생성
	}
	
	
	
	
	
	@GetMapping
	String insertWareForm(@RequestParam(name = "store_no", required = true)String store_no, Model model) {
		
		model.addAttribute("store_no",store_no);
		
		
		return "product/WareForm";
	}
	@GetMapping("insert")
	String insertWareView() {
		
		return "/product/WareInsert";
	}
	
	@PostMapping()
	String insertWareHouse(String store_json,WareHouseVO wareVo, int count) {

		
		service.CreateWareHouse(wareVo);
		List<WareSectorVO> sectorlist = new ArrayList<>();
		String store_no = wareVo.getStore_no().substring(3); // 01
		
		for(int i =1; i <= count; i++) {
			String sector_no = setLPad(i+"", 3, "0");
			WareSectorVO sectorvo = new WareSectorVO();
			sectorvo.setStore_no(wareVo.getStore_no());
			sectorvo.setSector_no(store_no + sector_no );
			sectorlist.add(sectorvo);
		}
		service.CreateSector(sectorlist);

		 try {
			    OutputStream output = new FileOutputStream(folderPath + "/" + wareVo.getStore_no() + ".json");
			    byte[] by= store_json.getBytes();
			    output.write(by);
			} catch (Exception e) {
		            e.getStackTrace();
			}
		
		return "redirect: warehouse";
	}
	
	
	

	// lpad 메소드
	 public String setLPad( String strContext, int iLen, String strChar )
	 { String strResult = ""; 
	 StringBuilder sbAddChar = new StringBuilder();
	 for( int i = strContext.length(); i < iLen; i++ ) 
	 { sbAddChar.append( strChar );
	 }
	 strResult = sbAddChar + strContext; 
	 return strResult; }
	
}
