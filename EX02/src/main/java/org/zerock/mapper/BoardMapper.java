package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.BoardVO;

public interface BoardMapper {
	// 목록
	public List<BoardVO> getList();
	
	// 등록 class의 이름과 BoardMapper.xml의 insert id와 일치해야 한다. (register의 값들을 넣어준다.)
	public void insertSelectKey(BoardVO board);
}
