package com.lec.yes25.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

public interface RCommand {
	void execute(HttpServletRequest request, HttpServletResponse response, Model model) ;
}
