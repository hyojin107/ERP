package ERP.controller.emp;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class FileUploadController {

	
	@Inject
	WebApplicationContext context;
	ServletContext application;
	
	@Value("#{appInfo.imagePath}")
	String imagePath;
	
	@Value("#{appInfo.imagePath}") // 문자열을 파일객체에 적용 하려면 propertie가 동작?
	File saveFolder;
	
	@PostConstruct
	public void init() {
		application =  context.getServletContext();
		// 어딘가에 저장을 하려고하는데 실제 파일이 존재하는지 확인을 해야 한다. 
		if(!saveFolder.exists()) {
			saveFolder.mkdirs(); // 저정 위치를 잡는거 
		}
	}
	
	@PostMapping(value = "/emp/image" , produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody // 마쉘링
	public Map<String, Object> imageUpload(@RequestPart(required = true) MultipartFile upload) throws IllegalStateException, IOException{
		Map<String, Object> result = new HashMap<>();
		if(!upload.isEmpty()) {
			
			String savename =  UUID.randomUUID().toString();
			upload.transferTo(new File(saveFolder, savename ));
			String  fileName = upload.getOriginalFilename();
			int uploaded = 1;
			String  url= application.getContextPath()+imagePath+"/"+savename;
			result.put("fileName", fileName);
			result.put("uploaded", uploaded);
			result.put("url", url);
			
		}else {
			String message = "이미지가 없음";
			int number =  400;
			Map<String, Object>  error = new HashMap<>(); //  map 확장성이 좋음
			error.put("number", number);
			error.put("message", message);
			error.put("result", result);
			
		}
		return result;
	}
}
