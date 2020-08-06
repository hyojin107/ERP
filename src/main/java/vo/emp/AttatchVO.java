package vo.emp;

import java.io.Serializable;
import java.util.UUID;

import org.apache.commons.io.FileUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class AttatchVO implements Serializable{
	
	public AttatchVO(MultipartFile realFile) {
		super();
		this.realFile = realFile;
		att_filename = realFile.getOriginalFilename();
		att_savename = UUID.randomUUID().toString();
		att_mime = realFile.getContentType();
		att_filesize = realFile.getSize();
		att_fancysize = FileUtils.byteCountToDisplaySize(att_filesize);
	
	}
	
	private MultipartFile realFile;
	private Integer att_no;
	
	private String att_filename;
	private String att_savename;
	private String att_mime;
	private Integer att_downcount;
	
	private Long att_filesize;
	private String  att_fancysize;
	
	private Integer attatch_code;
	private Integer notice_no;
	private String attatch_name;
	
}
