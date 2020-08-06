package ERP.service.emp;

import java.util.List;

import enums.ServiceResult;
import vo.PagingVO;
import vo.emp.EmployeeVO;
import vo.emp.Salary_CalVO;
import vo.emp.Salary_TransVO;

public interface ISalary_SpecificationService { // 급여관리
	// 근로소득관리
	public ServiceResult createSalary(Salary_TransVO vo);
	public int readSaralyCount(PagingVO<EmployeeVO> pagingVO);
	public ServiceResult removeSalary(Salary_TransVO vo);
//	public ServiceResult modifySalaryn(Salary_TransVO vo);  // 급여 수정하는거 없음 
	public List<EmployeeVO> readSalaryList(PagingVO<EmployeeVO> pagingVO);
	public EmployeeVO raeadSalaryn(EmployeeVO vo);
//	public Salary_TransVO readMoney(EmployeeVO vo);
	
	// 급여 기본정보 관리 하는곳
	public List<Salary_CalVO> readSalaryCal(); // 값을 많이 받으니깐 리스트로 나와야 한다.  xml에서 parameter는 없음 
	public ServiceResult modifySalaryCal(Salary_CalVO vo);
	
	// 급여메일 전송 
	public List<EmployeeVO> readMailList(PagingVO<EmployeeVO> pagingVO);
	public EmployeeVO readEmp(EmployeeVO vo);
	public Salary_TransVO readEmail(EmployeeVO vo);
	
}
