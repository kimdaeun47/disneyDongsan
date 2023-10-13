package com.disney.common.vo;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {
	private int startPage;	// 화면에서 보여지는 페이지의 시작 번호
	private int endPage;	// 화면에서 보여지는 페이지의 끝번호
	private boolean prev, next;	// 이전[이전페이지 10을 의미]과 다음[다음페이지 10을 의미]으로 이동한 링크의 표시 여부
	
	private int total;	// 전체 레코드 수
	private CommonVO cvo;	// 페이지 번호(기본값: 1)와 한페이지에 보여줄 레코드 수(기본값: 10)
	
	public PageDTO(CommonVO cvo, int total) {	// CommonVO cvo = new BoardVO() 주솟값 대입
		this.cvo = cvo;
		this.total = total;
		
		/* 페이징의 끝번호(endPage) 구하기
		 * this.endPage = (int) (Math.ceil(페이지번호 / 10.0)) * 10;*/
		this.endPage = (int) (Math.ceil(cvo.getPageNum() / 10.0)) * 10;
		/* Math.ceil() 메서드는 소수점을 올림으로 처리하기 때문에 다음과 같은 상황이 가능하다.
		 * 1페이지의 경우 : Math.ceil(0.1) * 10 = 10
		 * 2페이지의 경우 : Math.ceil(0.2) * 10 = 10
		 * 10페이지의 경우 : Math.ceil(1) * 10 = 10
		 * 11페이지의 경우 : Math.ceil(1.1) * 10 = 20 */
		
		/* 페이징의 시작번호(startPage) 구하기 - 시작번호(startPage)는 무조건 끝번호(endPage)에서 9를 빼주면 된다. */
		this.startPage = this.endPage - 9;
		
		/* 끝 페이지 구하기 */
		int realEnd = (int)(Math.ceil((total * 1.0) / cvo.getAmount()));
		
		if(realEnd <= this.endPage) {
			this.endPage = realEnd;
		}
		
		/* 이전(prev) 구하기[이전10개] - 이전의 경우는 시작번호가 1보다 큰 경우라면 존재하게 된다 */
		this.prev = this.startPage > 1;
		
		/* 다음(next) 구하기[다음10개] - 다음의 경우는 realEnd가 끝번호(endPage)보다 큰 경우라면 존재하게 된다 */
		this.next = this.endPage < realEnd;
	}
}
