package ERP.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import vo.CalendarVO;
import vo.PagingVO;

@Repository
public interface ICalendarDAO {

	public int insertCalendar(CalendarVO vo);
	public int updateCalendar(CalendarVO vo);
	public List<CalendarVO> selectCalendarList(PagingVO<CalendarVO> pagingVO);
	public int deleteCalendar(CalendarVO vo);
	public CalendarVO selectCalendar(String emp_id);
	
	
}
