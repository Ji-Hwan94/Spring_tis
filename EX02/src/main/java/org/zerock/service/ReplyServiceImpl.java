package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;
import org.zerock.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReplyServiceImpl implements ReplyService {
	
	// lombok을 사용할 때 사용하는 주입
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	@Override
	public List<ReplyVO> getList(Criteria cri, Long bno) {
		
		return mapper.getListWithPaging(cri, bno);
	}

}
