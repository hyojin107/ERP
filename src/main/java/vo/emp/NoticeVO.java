package vo.emp;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString
@NoArgsConstructor
public class NoticeVO implements Serializable{

	private Integer rnum; 
	@NotNull
	private Integer notice_no; // 게시글 번호
	private String emp_no;    // 사원번호
	@NotBlank
	private String notice_title; // 게시글 제목
	private String notice_date;  // 게시글 작성일
	private String notice_content;  // 게시글 내용
	private Integer notice_view;  // 게시글 조회수
	@NotBlank
	private String emp_name; // 게시글 작성자
	
	private List<AttatchVO> attatchList;  // 첨부파일 리스트 
	
	private MultipartFile[] notice_file; // 파일 첨부
	
	public void setNotice_file(MultipartFile[] notice_file) {
		this.notice_file = notice_file;
		if(notice_file == null || notice_file.length == 0) return;
		attatchList = new ArrayList<>();
		for(MultipartFile noFile : notice_file) {
			if(StringUtils.isBlank(noFile.getOriginalFilename())) continue;
			attatchList.add(new AttatchVO(noFile));
		}
	}
	
	private int startAttNo;
	
	private int[] deleteAttatches;
	
}
