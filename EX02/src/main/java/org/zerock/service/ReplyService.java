package org.zerock.service;

import java.util.List;

import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

public interface ReplyService {
	// 댓글목록
	public List<ReplyVO> getList(Criteria cri, Long bno);
}
