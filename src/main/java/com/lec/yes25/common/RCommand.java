package com.lec.yes25.common;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

public interface RCommand {
	void execute(HttpServletRequest request, Model model) ;
}
