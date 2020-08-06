package vo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.ToString;
import validate.groups.UpdateGroup;
import vo.emp.AttatchVO;

@Data
@ToString
public class BoardVO implements Serializable{
	private Integer rnum;
	@NotNull(groups = UpdateGroup.class)
	private Integer bo_no;
	@NotBlank
	private String bo_title;
	@NotBlank
	private String bo_writer;
	private String bo_date;
	private String bo_content;
	@NotBlank
	private String bo_pass;
	@NotBlank
	private String bo_ip;
	private Integer bo_hit;
	private Integer bo_parent;
	
	private MultipartFile[] bo_files;
	
	public void setBo_files(MultipartFile[] bo_files) {
		this.bo_files = bo_files;
		if(bo_files==null || bo_files.length==0) return;
		attatchList = new ArrayList<>();
		for(MultipartFile boFile : bo_files) {
			if(StringUtils.isBlank(boFile.getOriginalFilename())) continue;
			attatchList.add(new AttatchVO(boFile));
		}
	}
	
	private List<ReplyVO> replyList;
	
	private List<AttatchVO> attatchList;
	
	private int startAttNo;
	
	private int[] deleteAttatches;
}




