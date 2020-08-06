package board.service;

import java.util.List;

import enums.ServiceResult;
import vo.PagingVO;
import vo.ReplyVO;

public interface IReplyService {
	public ServiceResult createReply(ReplyVO reply); 
	public int readReplyCount(PagingVO<ReplyVO> pagingVO); 
	public List<ReplyVO> readReplyList(PagingVO<ReplyVO> paingVO);
	public ServiceResult modifyReply(ReplyVO reply); 
	public ServiceResult removeReply(ReplyVO reply);	
}
