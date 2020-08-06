package ERP.controller.emp;

import java.io.InputStream;
import java.io.OutputStream;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.view.AbstractView;

import vo.emp.AttatchVO;


public class DownloadView extends AbstractView{

	@Inject
	WebApplicationContext context;
	@Value("#{appInfo.attatchPath}")
	String attatchPath;
	
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// 다운로드를 시켜주면 된다.
		AttatchVO attatch =  (AttatchVO) model.get("attatch");
		
		
		// 파일 다운로드 받은거 내보내는거 
		response.setHeader("Content-length", attatch.getAtt_filesize()+"");
		
		String filename = attatch.getAtt_filename();
		filename = new String(filename.getBytes(),"ISO-8859-1");
				
		//파일명과 관련된 헤더 설정 
		response.setHeader("Content-disposition", "atta");
		String savename = attatch.getAtt_savename();
		Resource resource =  context.getResource(attatchPath+"/"+savename);
		try( 
				OutputStream os = response.getOutputStream();
				InputStream is =  resource.getInputStream();
			){
			
			IOUtils.copy(is, os);
			
		}
		
	}
	

}
