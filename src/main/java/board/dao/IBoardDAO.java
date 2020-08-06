package board.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import vo.BoardVO;
import vo.PagingVO;

@Repository
public interface IBoardDAO {
	public int insertBoard(BoardVO vo);
	public int selectBoardCount(PagingVO<BoardVO> pagingVO);
	public List<BoardVO> selectBoardList(PagingVO<BoardVO> pagingVO);
	public BoardVO selectBoard(int bo_no);
	public void incrementHit(int bo_no);
	public int updateBoard(BoardVO vo);
	public int deleteBoard(BoardVO vo);
}
