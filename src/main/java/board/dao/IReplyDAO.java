package board.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import vo.PagingVO;
import vo.ReplyVO;

@Repository
public interface IReplyDAO {
	public int insertReply(ReplyVO vo);
	public int selectReplyCount(PagingVO<ReplyVO> pagingVO);
	public List<ReplyVO> selectReplyList(int bo_no);
	public int updateReply(ReplyVO vo);
	public int deleteReply(int rep_no);
}
