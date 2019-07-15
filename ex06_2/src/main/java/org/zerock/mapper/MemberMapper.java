package org.zerock.mapper;

import org.zerock.domain.MemberVO;

public interface MemberMapper {

	public MemberVO read(String userid);
	
	// 회원가입 mapper
	public void insertMember(MemberVO memberVO); 
}
