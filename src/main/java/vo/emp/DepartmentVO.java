package vo.emp;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import validate.groups.InsertGroup;

@Data
@NoArgsConstructor
public class DepartmentVO implements Serializable {

	@NotNull(groups = InsertGroup.class)
	private String dep_no; // 팀명
	@NotBlank
	private String dep_no2;  // 부서코드

	private String dep_name; // 부서명

	private String dep_call; // 부서번호
	
	private List<DepartmentVO> teamList;
	private List<Map<String, Object>> departmentList;
}
