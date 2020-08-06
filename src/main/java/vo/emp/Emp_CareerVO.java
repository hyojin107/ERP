package vo.emp;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.NotNull;

import lombok.Data;

@Data
public class Emp_CareerVO implements Serializable{
	@NotNull
	private String emp_no; 
	private String company; // 회사
	private String career_task; // 경력업무
	private String work_year; // 근속년수
	private String final_position; // 최종직급
	
	private List<Emp_CareerVO> careerVO;

}
