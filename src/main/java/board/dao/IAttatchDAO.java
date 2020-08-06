package board.dao;

import org.springframework.stereotype.Repository;

import vo.BoardVO;
import vo.emp.AttatchVO;

@Repository
public interface IAttatchDAO {
	public int insertAttatchs(BoardVO vo);
	public AttatchVO selectAttatch(int att_no);
	public int deleteAttatchs(BoardVO board);
	public int incrementDownCount(int att_no);
}
