package com.meal.member.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.meal.member.vo.MemberVO;


public interface MemberService {
	public MemberVO login(Map  loginMap) throws Exception;
	public void addMember(MemberVO memberVO) throws Exception;
	public String overlapped(String id) throws Exception;
	public void updateMember(MemberVO memberVO) throws Exception;
	public void delMember(MemberVO memberVO) throws Exception;
	public MemberVO decode(String u_id) throws Exception;
	public void logout(String u_id) throws Exception;
	public String checkpw(String id) throws Exception;
}