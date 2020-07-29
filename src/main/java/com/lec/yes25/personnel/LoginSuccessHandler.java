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

		// 세션 상세 정보 확인

//		HttpSession session = request.getSession();
//		Enumeration<?> attributeNames = session.getAttributeNames();
//		while (attributeNames.hasMoreElements()) {
//			String name = (String) attributeNames.nextElement();
//			System.out.println(name);
//			if (name.equals("SPRING_SECURITY_CONTEXT")) {
//				SecurityContext value = (SecurityContext) session.getAttribute(name);
//				authentication = value.getAuthentication();
//				System.out.println("여긴?");
//
//				User principal = (User) authentication.getPrincipal();
//				WebAuthenticationDetails details = (WebAuthenticationDetails) authentication.getDetails();
//				String username = authentication.getName();
//				
//				System.out.println("세션임 --> " + session);
//				session.setAttribute("username", username);
//				 System.out.println("유저네임....." + username);
//				 
//				
//				String password = (String) authentication.getCredentials();
//				System.out.println("name = " + name + "\n value = " + value.toString());
//				System.out.println("authentication : " + authentication.toString());
//				System.out.println("principal : " + principal);
//				System.out.println("details : " + details.toString());
//				System.out.println("username : " + username);
//				System.out.println("password : " + password);
//
//			}
//
//		}
		
		

		

		// 이것도 저것도 아니면 여기로 가겠다.
		response.sendRedirect(request.getContextPath() + "/personnel/main");

		// 이 클래스의 빈객체 컨텍스트에 만들어주기 !

	}

}
