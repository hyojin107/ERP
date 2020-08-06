package ERP.service;

import java.util.List;

import enums.ServiceResult;
import vo.CalendarVO;
import vo.PagingVO;

/**
 * @author 연지은
 * @since 2020. 6. 29
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                   수정자               수정내용
 * --------     --------    ----------------------
 * 2020. 6. 29        작성자명               최초작성
 * Copyright (c) 2020 by DDIT All right reserved
 * 
 */
public interface ICalendarService { // 일정등록 수정 삭제

	public ServiceResult createCalendar(CalendarVO vo);
	public ServiceResult modifyCalendar(CalendarVO vo);
	public List<CalendarVO> readCalendarList(PagingVO<CalendarVO> pagingVO);
	public ServiceResult remobeCalendar(CalendarVO vo);
	public CalendarVO readCalendar(String calendar_no);
	
}
