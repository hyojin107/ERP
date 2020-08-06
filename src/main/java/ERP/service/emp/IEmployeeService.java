package ERP.service.emp;

import java.util.List;

import enums.ServiceResult;
import vo.PagingVO;
import vo.emp.EmployeeVO;

public interface IEmployeeService { // 사원등록폼 

	public ServiceResult createEmployee(EmployeeVO vo);
	public ServiceResult modifyEmployee(EmployeeVO vo); // 사원  모달에서 수정 
//	public ServiceResult removeEmployee(EmployeeVO vo); // 사원  모달에서  삭제 
	public EmployeeVO readEmployee(String emp_no);
	public List<EmployeeVO> readEmployeeList(PagingVO<EmployeeVO> pagingVO);
	public int readEmpListCount(PagingVO<EmployeeVO> paingVO);
	
//	public EmployeeVO readModalEmp(EmployeeVO vo); // 사원 한명 모달창으로 나오는거
	
//	public ServiceResult removeModalEmp(EmployeeVO vo); // 사원자격증 삭제
	public ServiceResult creatModalCert(EmployeeVO vo); // 사원 자격증 선택
	public ServiceResult modifyPW(EmployeeVO vo); // 비밀번호 업뎃
}
