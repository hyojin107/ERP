package vo.emp;

import java.io.Serializable;

import lombok.Data;

@Data
public class PositionVO implements Serializable {

	private String pos_no;
	private String pos_no2;
	private String pos_name;
	private Integer basicsalary;
}
