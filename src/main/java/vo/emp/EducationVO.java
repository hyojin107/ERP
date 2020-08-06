package vo.emp;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.NotNull;

import lombok.Data;

@Data
public class EducationVO implements Serializable {

	@NotNull
	private String emp_no;
	private String edu_name;
	private String major;
	private String graduate;
	
	private List<EducationVO> list;
}
