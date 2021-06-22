package org.zerock.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

@Repository
public class BoardDAOImpl implements BoardDAO{
	@Inject
	private SqlSession session;
	
	private String namespace="org.zerock.mapper.BoardMapper";

	@Override
	public List<BoardVO> getListWithPaging(Criteria cri) {	
		//list를 리턴
		return session.selectList(namespace+".getListWithPaging",cri);
	}
}
