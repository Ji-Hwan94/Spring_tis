package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyPageDTO;
import org.zerock.domain.ReplyVO;
import org.zerock.mapper.BoardMapper;
import org.zerock.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReplyServiceImpl implements ReplyService {
	
	// lombok을 사용할 때 사용하는 주입
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	// transactional을 사용하기 위해 setter를 가져온다.
	@Setter(onMethod_ = @Autowired)
	private BoardMapper boardMapper;
	
	@Override
	public List<ReplyVO> getList(Criteria cri, Long bno) {
		
		return mapper.getListWithPaging(cri, bno);
	}

	@Override
	public int modify(ReplyVO vo) {
		
		return mapper.update(vo);
	}
	
	@Override
	public ReplyVO get(Long rno) {
		
		return mapper.read(rno);
	}

	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long bno) {
		
		return new ReplyPageDTO(mapper.getCountByBno(bno), mapper.getListWithPaging(cri, bno));
	}

	@Transactional
	@Override
	public int register(ReplyVO vo) {
		
		boardMapper.updateReplyCnt(vo.getBno(), 1);
		
		// 댓글 갯수 증가
		return mapper.insert(vo);
	}
	
	@Transactional
	@Override
	public int remove(Long rno) {
		
		ReplyVO vo = mapper.read(rno); 
		
		// 댓글 갯수 감소
		boardMapper.updateReplyCnt(vo.getBno(), -1);
		return mapper.delete(rno);
	}
}