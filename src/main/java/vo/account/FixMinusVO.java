package vo.account;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;

import lombok.Data;
import lombok.Getter;

@Data
@Getter
public class FixMinusVO implements Serializable{
	@NotBlank
	private Integer fixassets_no; //고정자산코드
	@NotBlank
	private String amor_date; //감가상각일자
	private Integer amor_cost; //상각액
	private Integer startyear;
	private Integer startmonth;
	private Integer endyear;
	private Integer endmonth;
	private Integer account_no;
}
