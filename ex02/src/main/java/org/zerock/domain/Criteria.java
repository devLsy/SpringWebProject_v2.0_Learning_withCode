package org.zerock.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {

	private int pageNum;		// 페이지 번호
	private int amount;			// 한페이지에 보여줄 게시글 수
	
	private String type;
	private String keyWord;
	
	
	public Criteria() {
		this(1, 10);
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
		System.out.println("한페이지에 보여줄 게시글 수: " + amount);
	}
	
	public String[] getTypeArr() {
		System.out.println("cri.type: " + type);
	    return type == null? new String[] {}: type.split("");
	  }
}	
