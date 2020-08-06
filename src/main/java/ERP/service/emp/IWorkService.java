package ERP.service.emp;

import java.util.List;

import enums.ServiceResult;
import vo.PagingVO;
import vo.emp.EmployeeVO;
import vo.emp.WorkVO;

public interface IWorkService { // 근태관리 등록 수정 삭제
	
	public ServiceResult createWork(WorkVO vo);
	public ServiceResult modifyWork(WorkVO vo);
//	public ServiceResult removeWork(WorkVO vo);
	public List<WorkVO> readWorkList(PagingVO<WorkVO> pagingVO); // 사원의 정보를 목록가져오느거 
	public WorkVO readWork(String vo); 
	public int readWorkCount(PagingVO<WorkVO> pagingVO);
//	public EmployeeVO readEmp(String vo);

	public List<WorkVO> readMonthList(PagingVO<WorkVO> pagingVO); // 사원의 월간 정보 리스트 
}
