package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.BoardVO;

public interface BoardMapper {
	//목록
	public List<BoardVO> getList();
	//등록
	public void insertSelectKey(BoardVO board);
	//상세보기
	public BoardVO read(Long bno);
	//수정
	public int update(BoardVO board);
	//삭제
	public int delete(Long bno);
}
