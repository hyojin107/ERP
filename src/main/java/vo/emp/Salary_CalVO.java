package vo.emp;

import lombok.Data;

@Data
public class Salary_CalVO { // 급여 정책

	private String dep_no;
	private String pos_name;
	private Integer salary; // 급여 
	private String pos_no;
}
