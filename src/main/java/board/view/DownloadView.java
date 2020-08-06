package board.view;

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
		AttatchVO attatch = (AttatchVO) model.get("attatch");
		
//		response.setHeader("Content-Length", attatch.getAtt_filesize()+"");
		// 파일명과 관련된 헤더 설정
		String filename = attatch.getAtt_filename();
//		filename = URLEncoder.encode(filename, "UTF-8");
		filename = new String(filename.getBytes(), "ISO-8859-1");

		response.setHeader("Content-Disposition", "attatchment;filename=\""+filename+"\"");
		String savename = attatch.getAtt_savename();
		Resource resource = context.getResource(attatchPath + "/" + savename);
		try(
			OutputStream os = response.getOutputStream();
			InputStream is = resource.getInputStream();
		){
			IOUtils.copy(is, os);
		}
		
	}
	
}
