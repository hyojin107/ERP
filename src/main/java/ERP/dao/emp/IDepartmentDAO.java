package ERP.dao.emp;

import java.util.List;

import org.springframework.stereotype.Repository;

import vo.PagingVO;
import vo.emp.DepartmentVO;

@Repository
public interface IDepartmentDAO { // 부서
	
	public int insertDepartment(DepartmentVO vo);
	public List<DepartmentVO> selectDepartmentList(PagingVO<DepartmentVO> pagingVO);
	public int deleteDepartment(DepartmentVO vo);
	public int updateDepartment(DepartmentVO vo);
	public DepartmentVO selectDepartment(String emp_id);
	
	
}
