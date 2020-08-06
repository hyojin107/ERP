package vo;

import java.io.Serializable;

import lombok.Data;

@Data
public class CalendarVO implements Serializable {
	
	private Integer calendar_no;
	private String emp_no;
	private String calendar_title;
	private String calendar_content;
	private String calendar_date;
	private String calendar_start;
	private String calendar_end;

}
