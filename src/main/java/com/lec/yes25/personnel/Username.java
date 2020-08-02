package com.lec.yes25.personnel;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

public interface Username {
	// 현재 인증된(로그인한) 사용자의 정보 가져오기
	Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	UserDetails userDetails = (UserDetails) principal;
	String username = userDetails.getUsername();
		

}
