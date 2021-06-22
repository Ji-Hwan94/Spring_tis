package org.zerock.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {
	private int startPage;//끝페이지
	private int endPage;  //시작페이지 
	private boolean prev, next; //이전, 다음 존재 여부
	
	private int total; //전체글수
	private Criteria cri;
	
	public PageDTO(Criteria cri, int total) {
		this.cri=cri;
		this.total=total;
		this.endPage=(int)(Math.ceil(cri.getPageNum()/10.0))*10;
		this.startPage=this.endPage-9;
		//실제끝페이지. 전체글수를 amount로 나눠서 나머지가 있으면 ceil을 이용해서 하나 올려줌.
		int realEnd=(int)(Math.ceil((total*1.0)/cri.getAmount()));
		//실제끝페이지가 계산으로 구한 endPage보다 작으면 endPage를 실제끝페이지로 변경
		if(realEnd<this.endPage) {
			this.endPage=realEnd;
		}
		this.prev=this.startPage>1; //1페이지보다 커야 prev 존재
		this.next=this.endPage<realEnd; //실제끝페이지가 endPage보다 커야 next 존재
	}
}
