package vo.account;

import java.io.Serializable;

import javax.validation.constraints.NotNull;

import lombok.Data;
import validate.groups.UpdateGroup;

@Data
public class AccountVO implements Serializable{
	@NotNull(groups = UpdateGroup.class)
	private Integer account_no; //계정코드
	private String account_name; //계정명
	private String stand_no; //표준계정코드
	private String etc; //비고
	private String use_status; //사용여부
	
	private String stand_name; 
	
	private String division;
}
