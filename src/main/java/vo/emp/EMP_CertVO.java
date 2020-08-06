package vo.emp;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.NotBlank;

import lombok.Data;

@Data
public class EMP_CertVO implements Serializable {

	private Integer cert_no;	//자격증코드
	private String emp_no;		// 사원번호
	private String cert_date; // 자격증 취득일
	private String cert_text; // 자격증 이름
	private String cert_sector;	// 자격증 구분
	private String issue_agency; // 발급기관명
//	private List<EMP_CertVO> empCertlist;
}
