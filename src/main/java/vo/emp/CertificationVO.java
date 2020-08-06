package vo.emp;

import java.io.Serializable;
import java.util.List;

import lombok.Data;

@Data
public class CertificationVO  implements Serializable {

	private Integer cert_no;
	private String cert_title;
	private String issue_agency; // 발행일
	
	private List<CertificationVO> cerList;
}
