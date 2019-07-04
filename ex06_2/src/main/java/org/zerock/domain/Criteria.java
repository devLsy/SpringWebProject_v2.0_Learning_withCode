package org.zerock.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.extern.log4j.Log4j;

@Getter
@Setter
@ToString
@Log4j
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
		log.info("한페이지에 보여줄 게시글 수: " + amount);
	}
	
	public String[] getTypeArr() {
		log.info("cri.type: " + type);
	    return type == null? new String[] {}: type.split("");
	}
	
	// spring의 UriComponentsBuilder 이용해서 parameter들을 연결해 url 형태로 가공
	public String getListLink() {
		
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.getAmount())
				.queryParam("type", this.getType())
				.queryParam("keyWord", this.getKeyWord());
		
		log.info("uriComponentsBuilder 이용해 만든 url: " + builder.toUriString());
		return builder.toUriString();
		
	}
}	
