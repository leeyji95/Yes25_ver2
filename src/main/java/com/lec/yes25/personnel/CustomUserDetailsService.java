package com.lec.yes25.personnel;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;

public class CustomUserDetailsService implements UserDetailsService {

	@Autowired
	private UserAuthDAO dao;

	@Autowired
	PasswordEncoder passwordEncoder;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

		CustomUserDetails user = dao.getUserById(username); // 사용자의 정보를 CustomUserDetails 형으로 가져온다.

		System.out.println("user 나와라    :   " + user);

		if (user == null) {
			throw new UsernameNotFoundException(username); // 만약 해당 username의 사용자 정보가 없다면 UsernameNotFoundException 예외를
															// 던져준다
		} else {
			user.setName(user.getName());
			user.setEmail(user.getEmail());
			user.setDeptno(user.getDeptno());
			user.setPositionno(user.getPositionno());
			user.setPhone(user.getPhone());
			user.setHiredate(user.getHiredate());
			ArrayList<GrantedAuthority> auth = new ArrayList<GrantedAuthority>();
			auth.add(new SimpleGrantedAuthority(user.getAuthorities().toString()));
			String str = auth.toString();
			user.setAuthority(str);
		}
		return user; // 사용자의 정보가 담긴 user를 리턴

//		 @Autowired
//		    private PersonnelDAO dao;
//		 
//		    @Override
//		    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
//		        CustomUserDetails user = dao.getUserById(username);
//		        if(user == null) {
//		            throw new UsernameNotFoundException(username);
//		        }
//		        return user;
//		    }

	}

}
