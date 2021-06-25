package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface BoardMapper {
	//목록
	public List<BoardVO> getList();	
	//목록 with Paging
	public List<BoardVO> getListWithPaging(Criteria cri);	
	//등록
	public void insertSelectKey(BoardVO board);
	//상세보기
	public BoardVO read(Long bno);
	//수정
	public int update(BoardVO board);
	//삭제
	public int delete(Long bno);
	//전체글수
	public int getTotalCount(Criteria cri);
	//댓글갯수
	public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);
}
