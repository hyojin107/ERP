package vo.account;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;

import lombok.Data;
import validate.groups.UpdateGroup;

@Data
public class BuyChitVO implements Serializable{
	@NotBlank(groups = UpdateGroup.class)
	private Integer pur_code; //매입번호
	private String summary; //적요
	@NotBlank
	private Integer buy_chit_no; //매입전표번호
	private String emp_no; //사원번호
	private String chit_date; //전표일자
	private String sign_status; //전표상태
}
