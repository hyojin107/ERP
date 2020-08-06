package board.controller;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/board/image")
public class BoardImageUploadController {
	@Inject
	WebApplicationContext context;
	ServletContext application;
	@Value("#{appInfo.imagePath}")
	String imagePath;
	
	@Value("#{appInfo.imagePath}")
	File saveFolder;
	
	@PostConstruct
	public void init() {
		if(!saveFolder.exists()) {
			saveFolder.mkdirs();
		}
		application = context.getServletContext();
		System.err.println(saveFolder.getAbsolutePath());
	}
	
	@PostMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> imageUpload(@RequestPart(required = true) MultipartFile upload) throws IllegalStateException, IOException {
		Map<String, Object> result = new HashMap<>();
		if(!upload.isEmpty()) {
			String savename = UUID.randomUUID().toString();
			upload.transferTo(new File(saveFolder, savename));
			String fileName = upload.getOriginalFilename();
			int uploaded = 1;
			String url = application.getContextPath() + imagePath + "/" + savename;
			result.put("fileName", fileName);
			result.put("uploaded", uploaded);
			result.put("url", url);
		}else {
			String message = "이미지가 없음.";
			int number = 400;
			Map<String, Object> error = new HashMap<>();
			error.put("message", message);
			error.put("number", number);
			result.put("error", error);
		}
		return result;
	}
	
}
