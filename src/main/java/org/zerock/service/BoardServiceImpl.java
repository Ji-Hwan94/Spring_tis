package org.zerock.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardAttachMapper;
import org.zerock.mapper.BoardMapper;
import org.zerock.persistence.BoardDAO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class BoardServiceImpl implements BoardService {	
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper; //주입.Injection
	
	@Setter(onMethod_ = @Autowired)
	private BoardAttachMapper attachMapper; //주입.Injection
	
	@Inject
	private BoardDAO dao; //주입.Injection
	
	@Transactional
	@Override
	public void register(BoardVO board) {
		//mapper호출
		mapper.insertSelectKey(board);

		if (board.getAttachList() == null || board.getAttachList().size() <= 0) {
			return;
		}

		board.getAttachList().forEach(attach -> {

			attach.setBno(board.getBno());
			attachMapper.insert(attach);
		});
	}

	@Override
	public BoardVO get(Long bno) {		
		return mapper.read(bno);
	}

	@Transactional
	@Override
	public boolean modify(BoardVO board) {

		log.info("modify......" + board);

		attachMapper.deleteAll(board.getBno());

		boolean modifyResult = mapper.update(board) == 1;
		
		if (modifyResult && board.getAttachList()!=null && board.getAttachList().size() > 0) {

			board.getAttachList().forEach(attach -> {

				attach.setBno(board.getBno());
				attachMapper.insert(attach);
			});
		}

		return modifyResult;
	}
	@Transactional
	@Override
	public boolean remove(Long bno) {	
		attachMapper.deleteAll(bno);
		return mapper.delete(bno)==1;
	}

	@Override
	public List<BoardVO> getList(Criteria cri) {		
		//return mapper.getListWithPaging(cri);
		return dao.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<BoardAttachVO> getAttachList(Long bno) {		
		return attachMapper.findByBno(bno);
	}

//	@Override
//	public List<BoardVO> getList(){
//		//mapper에 정의된 메서드 호출
//		return mapper.getList(); // List<BoardVO>리턴	
//		
//	}
	
	
}
