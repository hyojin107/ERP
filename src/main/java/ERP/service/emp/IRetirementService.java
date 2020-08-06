package ERP.service.emp;

import java.util.List;

import enums.ServiceResult;
import vo.PagingVO;
import vo.emp.EmployeeVO;
import vo.emp.RetirementVO;

public interface IRetirementService { // 퇴직처리

	public ServiceResult createRetirement(RetirementVO vo);
//	public ServiceResult removeRetirement(RetirementVO vo);
	public ServiceResult modifyRetirement(RetirementVO vo);
	public List<EmployeeVO> readRetirementList(PagingVO<EmployeeVO> pagingVO);
	public EmployeeVO readRetirement(EmployeeVO emp);
	public int readEmpListCount(PagingVO<EmployeeVO> pagingVO);
	
	
}
