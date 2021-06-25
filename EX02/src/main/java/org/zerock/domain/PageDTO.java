package org.zerock.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PageDTO {
	
	private int startPage;
	private int endPage;
	private boolean prev, next;
	
	private int total;
	private Criteria cri;
	
	public PageDTO(Criteria cri, int total) {
		this.cri = cri;
		this.total = total;
		
		this.endPage = (int) (Math.ceil(cri.getPageNum()/ 10.0)) * 10;
		
		this.startPage = this.endPage - 9;
		
		// 실제 끝 페이지. 전체 글 수를 amount로 나누어서 나머지가 있으면 ceil을 이용하여 올림 한다.
		int realEnd = (int) (Math.ceil((total * 1.0) / cri.getAmount()));
		
		// 실제 끝 페이지가 계산으로 구한 endPage보다 작으면 endPage를 실제 끝 페이지로 변경
		if(realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		
		this.prev = this.startPage > 1; // 1페이지 보다 커야 prev 존재
		
		this.next = this.endPage < realEnd; // 실제 끝 페이지가 endPage보다 커야 next 존재
	}
	
}
