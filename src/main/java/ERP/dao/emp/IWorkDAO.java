package ERP.dao.emp;

import java.util.List;

import org.springframework.stereotype.Repository;

import vo.PagingVO;
import vo.emp.EmployeeVO;
import vo.emp.WorkVO;

@Repository
public interface IWorkDAO { // 근태현황

	public int insertWork(WorkVO vo); // 일일근태등록
//	public int deleteWork(WorkVO vo); // 일일 근태 삭제
	public int updateWork(WorkVO vo); // 일일 근태 수정
	public List<WorkVO> selectWorkList(PagingVO<WorkVO> paging);  // 리스트로 일일근태 불러올때?
	public WorkVO selectWork(String vo); // 일일근태 하나 선택 했을 경우 
//	public EmployeeVO selEmployeeVO(String vo); // 사원의 정보 가져오는거 
	public int  selectWorkCount(PagingVO<WorkVO> pagingVO);  // 페이지네이션 
	

	public List<WorkVO> selectMonthList(PagingVO<WorkVO> paging); //월간 근태 리스트 
	

}
