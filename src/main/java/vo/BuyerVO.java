package vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.NotBlank;

import lombok.Data;

@Data
public class BuyerVO implements Serializable{
	private Integer rnum;
	
	private String buyer_no; //거래처코드
	@NotBlank
	private String buyer_name; //거래처명
	private String buyer_sector; //업종
	private String buyer_rep; //대표자명
	private String buyer_tel; //회사전화번호
	private String buyer_bank; //은행명
	private String buyer_bankno; //계좌번호
	private String buyer_bankname; //예금주
	private String buyer_zip; //우편번호
	private String buyer_addr; //거래처주소
	private String buyer_addr2; //거래처상세주소
	private String charger_name; //담당자명
	private String charger_phone; //담당자연락처
	private String charger_email; //담당자 이메일
	private String etc; //비고
	private String use_status; //거래여부
}
