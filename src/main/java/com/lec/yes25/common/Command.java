package com.lec.yes25.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.expression.ParseException;
import org.springframework.ui.Model;

public interface Command {
	void execute(HttpServletRequest request, HttpServletResponse response) throws ParseException;
	
}
