package ERP.dao.emp;

import java.util.List;

import org.springframework.stereotype.Repository;

import vo.PagingVO;
import vo.emp.Emp_CareerVO;

@Repository
public interface IEmp_CareerDAO {

	public int insertEmpCareer(Emp_CareerVO vo);
	public int updateEmpCareer(Emp_CareerVO vo);
	public List<Emp_CareerVO> selectEmpCareerList(PagingVO<Emp_CareerVO> paigingVO);
	public int deleteEmpCareer(Emp_CareerVO vo);
	public Emp_CareerVO selectEmpCareer(String emp_id);
	
	
}
