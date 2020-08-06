package vo.account;

import java.io.File;
import java.io.IOException;
import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import validate.groups.UpdateGroup;
import validate.stereotype.MimeChecker;

@Data
public class FixAssetsVO implements Serializable{
	@NotNull(groups = UpdateGroup.class)
	private Integer fixassets_no; //고정자산코드
	private String amor_way; //상각방법
	private String getdate; //취득일자
	private Integer getcost; //취득가액
	@NotNull
	private Integer life_year; //내용연수
	private Integer account_no; //계정코드
	private String assets_name; //자산명
	private String use_status; //사용여부
	
	private List<FixMinusVO> fixMinusList; // 상각이력
	
	private String account_name;
	private String status;	// 자산상태
	private int now; // 당기상각액
	
	private int total; //상각누계액
	@MimeChecker(contentType = "image/*")
	private MultipartFile img;

	public void saveFile(File saveFolder) throws IllegalStateException, IOException {
		if (img == null)
			return;
		File saveFile = new File(saveFolder, fixassets_no+"");
		img.transferTo(saveFile);
	}
	
}
