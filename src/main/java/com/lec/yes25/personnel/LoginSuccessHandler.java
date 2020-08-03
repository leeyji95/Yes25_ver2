package com.lec.yes25.personnel;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.WebAuthenticationDetails;

public class LoginSuccessHandler implements AuthenticationSuccessHandler {

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {

		System.out.println("Login Success");

		// Authentication 객체를 이용해서 사용자가 가진 모든 권한을 문자열로 체크 가능

		List<String> roleNames = new ArrayList<String>();
		authentication.getAuthorities().forEach(authority -> {
			roleNames.add(authority.getAuthority()); /* Authentication에 있는 모든 권한을 리스트에 담는다. */
		});

		System.out.println("ROLE NAMES : " + roleNames);

		// 
		response.sendRedirect(request.getContextPath() + "/personnel/main");

		// 이 클래스의 빈객체 컨텍스트에 만들어주기 !

	}

}
