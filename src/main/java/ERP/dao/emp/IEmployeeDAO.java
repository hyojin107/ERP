package ERP.dao.emp;

import java.util.List;

import org.springframework.stereotype.Repository;

import vo.PagingVO;
import vo.emp.EmployeeVO;



@Repository
public interface IEmployeeDAO { 

	public int insertEmployee(EmployeeVO vo); // select Key
	public int updateEmployee(EmployeeVO vo); // 사원 수정 
	public int deleteEmployee(String emp_no);  // 사원 삭제
	public EmployeeVO selectEmployee(String emp_no);
	public List<EmployeeVO> selectEmployeeList(PagingVO<EmployeeVO> pagingVO);
	public int selectCerNO();
	public int selectEmpCount(PagingVO<EmployeeVO> pagingVO);
	
	public String departName(EmployeeVO depName); // 소속명
	public String deparNo(EmployeeVO depNo); // 부서명 
	
	public int deleteCer(EmployeeVO vo); // 자격증 삭제
	public int insertCer(EmployeeVO vo); // 자격증 등록 
	
	public int update_pw(EmployeeVO vo);//  비밀번호 찾기

	
} 
