package vo.account;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.NotBlank;

import lombok.Data;
import validate.groups.UpdateGroup;

@Data
public class ChitVO implements Serializable{
	@NotBlank(groups = UpdateGroup.class)
	private String chit_no; //일반전표번호
	private String sign_status; //승인여부
	private String emp_no; //사원번호
	private String buyer_no; //거래처코드
	private String chit_date; //전표일자
	private String buy_sell; //매입매출여부
	private String dep_no; //부서코드
	
	private String buyer_name;
	
	private Integer pay;
	
	private List<ChitlistVO> chitList;
}
