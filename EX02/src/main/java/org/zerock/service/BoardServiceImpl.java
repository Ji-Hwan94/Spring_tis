package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.BoardVO;
import org.zerock.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class BoardServiceImpl implements BoardService {

	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper; //주입.Injection
	
	@Override
	public void register(BoardVO board) {
		//mapper호출
		mapper.insertSelectKey(board);
		
	}

	@Override
	public BoardVO get(Long bno) {		
		return mapper.read(bno);
	}

	@Override
	public boolean modify(BoardVO board) {		
		return mapper.update(board)==1;
	}

	@Override
	public boolean remove(Long bno) {		
		return mapper.delete(bno)==1;
	}

	@Override
	public List<BoardVO> getList() {
		//mapper에 정의된 메서드 호출
		return mapper.getList(); // List<BoardVO>리턴
		
	}
	

}
