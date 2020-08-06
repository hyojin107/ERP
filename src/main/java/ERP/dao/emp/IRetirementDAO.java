package ERP.dao.emp;

import java.util.List;

import org.springframework.stereotype.Repository;

import vo.PagingVO;
import vo.emp.EmployeeVO;
import vo.emp.RetirementVO;

@Repository
public interface IRetirementDAO { // 퇴직금

	public int insertRetirement(RetirementVO vo); // 퇴직금 등록
//	public int deleteRetirement(RetirementVO vo); 
	public int updateRetirement(RetirementVO vo);  // 퇴직금 수정
	public List<EmployeeVO> selectRetirementList(PagingVO<EmployeeVO> pagingVO); // 퇴직금 리스트 
	public EmployeeVO selectRetirement(EmployeeVO emp); // 사원 한명 클릭했을때
	public int selectEmpCount(PagingVO<EmployeeVO> pagingVO);
	
	 
	
	
	
	
}
