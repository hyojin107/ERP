package ERP.dao.emp;

import java.util.List;

import org.springframework.stereotype.Repository;

import vo.PagingVO;
import vo.emp.EducationVO;

@Repository
public interface IEducationDAO {

	public int insertEducation(EducationVO vo);
	public int updateEducation(EducationVO vo);
	public List<EducationVO> selectEducationList(PagingVO<EducationVO> pagingVO);
	public int deleteEducation(EducationVO vo);
	public EducationVO selectEducation(String emp_id);
	
	
}
