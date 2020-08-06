package vo.emp;

import java.io.Serializable;

import lombok.Data;

@Data
public class Salary_TransVO implements Serializable {

	private Integer rnum;
	private String emp_no;
	private String sal_date;		// 지급날짜 
	private Integer my_basicsalary; // 기본급여
	private Integer extension_pay;   // 연장수당
	private Integer deduction; 		// 공제액
	private Integer actual_payment; // 실지급액
	
	
	private DepartmentVO depVO; // 부서
	private PositionVO posVO;  // 급여 
	
	
	
	
}
