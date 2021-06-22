package org.zerock.persistence;

import java.util.List;

import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface BoardDAO {
	//목록 with Paging
	public List<BoardVO> getListWithPaging(Criteria cri);	
}
