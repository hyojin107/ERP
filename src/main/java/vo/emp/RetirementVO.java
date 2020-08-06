package vo.emp;

import java.io.Serializable;

import lombok.Data;
@Data
public class RetirementVO implements Serializable{

	private Integer rnum; 
	private String emp_no; 			// 사원번호 
	private String payment_day;		// 지급일
	private String retire_date;		// 퇴직 날짜
	private Integer retire_salary; 	// 퇴직금
	private Integer deduction;		// 공제액
	private String retire_reason;   // 퇴직사유 
	
	private String dep_no; // 소속이름
	private String pos_no; // 직급명
	private String emp_name; // 사원이름
	
	private String code; // 
	private String name; 
	
	
}
