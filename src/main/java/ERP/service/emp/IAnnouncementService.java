package ERP.service.emp;

import java.util.List;

import enums.ServiceResult;
import vo.PagingVO;
import vo.emp.AnnouncementVO;
import vo.emp.EmployeeVO;


public interface IAnnouncementService { // 인사발령

	/**
	 * 발령 등록
	 * @param vo
	 * @return
	 */
	public ServiceResult createAnnouncement(AnnouncementVO vo);
	/**
	 * 발령 수정
	 * @param vo
	 * @return
	 */
	public  ServiceResult updateAnnouncement(AnnouncementVO vo);  // 발령상태 바뀌는거 
	/**
	 * 발령리스트 가져오는거 
	 * @param pagingVO
	 * @return
	 */
	public  List<EmployeeVO> readAnnouncementList(PagingVO<EmployeeVO>  pagingVO);
	
	public int readAnnListCount(PagingVO<EmployeeVO> pagingVO);
	
	// 하나 선택할때
	public EmployeeVO readAnnouncement(EmployeeVO emp);
	
	public ServiceResult statusUpdate(AnnouncementVO vo); // 발령상태 변경
	
}
