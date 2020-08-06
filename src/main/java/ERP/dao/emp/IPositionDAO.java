package ERP.dao.emp;

import java.util.List;

import javax.swing.text.Position;

import org.springframework.stereotype.Repository;

import vo.PagingVO;
import vo.emp.PositionVO;

@Repository
public interface IPositionDAO { // 직급
	
	public int insertPosition(PositionVO vo);
	public int deletePosition(PositionVO vo);
	public List<PositionVO> selectPositionList(PagingVO<PositionVO> pagingVO);
	public int updatePosition(PositionVO vo);
	public PositionVO selectPosition(String emp_id);
	 

}
