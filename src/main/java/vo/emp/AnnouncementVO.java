package vo.emp;

import java.io.Serializable;
import java.util.List;

import lombok.Data;

/**
 * @author 연지은
 * @since 2020. 6. 30
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                   수정자               수정내용
 * --------     --------    ----------------------
 * 2020. 6. 30        작성자명               최초작성
 * Copyright (c) 2020 by DDIT All right reserved
 * 
 * 인사발령
 * 
 */
@Data
public class AnnouncementVO implements Serializable{
	
	private Integer ann_no; // 발령코드
	private String pos_no; // 발령직급
	private String dep_no; // 발령 부서
	private String emp_no; // 발령 사원
	private String ann_date; // 발령 날짜
	private String remark;  // 비고
	private String ann_status; // 발령상태
	
	
	
	private String emp_name; // 사원이름
	
	
	private String code;
	private String name;
	private String today_ann; // 작성날짜 

	private List<AnnouncementVO> annList; // 발령상태 리스트 
	
	private String st_before;
}
