package ERP.dao.emp;

import java.util.List;

import org.springframework.stereotype.Repository;

import vo.PagingVO;
import vo.emp.AnnouncementVO;
import vo.emp.EmployeeVO;

@Repository
public interface IAnnouncementDAO { //인사발령

	public int insertAnnouncement(AnnouncementVO vo); // 인사발령 등록 
	public int updateAnnouncement(AnnouncementVO vo); // 인사발령 수정 
	public List<EmployeeVO> selectAnnouncementList(PagingVO<EmployeeVO> pagingVO); // 인사발령 리스트 
	public EmployeeVO selectAnnouncement(EmployeeVO emp_no); // 사원 한명 클릭시 
	public int selectAnnCount(PagingVO<EmployeeVO> pagingVO); // 카운트 하는거 

	public int updateCheck(AnnouncementVO vo);
}
