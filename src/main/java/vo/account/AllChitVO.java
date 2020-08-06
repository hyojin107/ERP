package vo.account;

import java.io.Serializable;

import lombok.Data;

@Data
public class AllChitVO implements Serializable{
	private String sign_status; //승인여부
	private String emp_no; //사원번호
	private String buyer_no; //거래처코드
	private String chit_date; //전표일자
	private Integer chit_no; //일반전표번호
	private String buy_sell; //매입매출여부
	private String dep_no; //부서코드
	
	private Integer pur_code; //매입번호
	private String summary; //적요
	private Integer buy_chit_no; //매입전표번호
	
	private Integer ship_no; //출하등록번호
	private Integer sell_chit_no; //매출전표번호
	
	private String buyer_name; //거래처명
}
