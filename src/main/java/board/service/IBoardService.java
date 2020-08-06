package board.service;

import java.util.List;

import enums.ServiceResult;
import vo.BoardVO;
import vo.PagingVO;
import vo.emp.AttatchVO;

public interface IBoardService {
	public ServiceResult  createBoard(BoardVO board); 
	public int readBoardCount(PagingVO<BoardVO> pagingVO); 
	public List<BoardVO> readBoardList(PagingVO<BoardVO> pagingVO); 
	public BoardVO readBoard(int bo_no); 
	public ServiceResult modifyBoard(BoardVO board); 
	public ServiceResult removeBoard(BoardVO board); 
	public AttatchVO downloadAttatch(int att_no);
}
