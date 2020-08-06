package vo.account;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;

import lombok.Data;
import validate.groups.UpdateGroup;

@Data
public class SellChitVO implements Serializable{
	@NotBlank(groups = UpdateGroup.class)
	private Integer sell_chit_no; //매출전표번호
	private Integer ship_no; //출하등록번호
	private String summary; //적요
	private String emp_no; //사원번호
	private String chit_date; //전표일자
	private String sign_status; //전표상태
}
