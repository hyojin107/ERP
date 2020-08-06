package vo.emp;

import java.io.Serializable;
import java.util.List;

import lombok.Data;

@Data
public class WorkVO implements Serializable{
	
	private String emp_no;
	private String work_date; //근태일자
	private String work_time;
	private String offwork_time;

	private String lateTime; // 지각
	private Integer extendsTime; // 연장시간
	private List<EmployeeVO>  empList;
	private List<DepartmentVO> depList;
	private List<PositionVO> posList;
	
	private String today;
	private String dep_no2;
	private String dep_no;
	private String pos_no;
	private String emp_name;
	private int rnum;

	private DepartmentVO depVO;
	
}
