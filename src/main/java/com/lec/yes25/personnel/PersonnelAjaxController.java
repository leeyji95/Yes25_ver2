package com.lec.yes25.personnel;

import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.lec.yes25.personnel.command.GoworkCommand;
import com.lec.yes25.personnel.command.NewempCommand;
import com.lec.yes25.personnel.command.OutworkCommand;
import com.lec.yes25.personnel.command.OverworkCommand;

@RestController
@RequestMapping("/personnel/*.ajax")
public class PersonnelAjaxController {

	
	@PostMapping("/personnel/writeOk.ajax")
	public AjaxWriteResult writeOk(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ParseException {
		System.out.println("/writeOk.ajax 일단 들어옴");
		// 현재 인증된(로그인한) 사용자의 정보 가져오기
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails) principal;
		String username = userDetails.getUsername();
		new NewempCommand().execute(request, response, model);
		return buildResult(request);
	}

	@RequestMapping(value = "/personnel/gowork.ajax", method = { RequestMethod.GET, RequestMethod.POST })
	public AjaxWriteResult gowork(HttpServletRequest request, HttpServletResponse response, Model model) throws ParseException {
		System.out.println("/gowork.ajax----출근 누르면 ----여기로----");
		// 현재 인증된(로그인한) 사용자의 정보 가져오기
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails) principal;
		String username = userDetails.getUsername();
		model.addAttribute("username", username);
		new GoworkCommand().execute(request, response, model);
		return buildResult(request);
	}

	@RequestMapping(value = "/personnel/outwork.ajax", method = { RequestMethod.GET, RequestMethod.POST })
	public AjaxWriteResult outwork(HttpServletRequest request, HttpServletResponse response, Model model) throws ParseException {
		System.out.println("/outwork.ajax----퇴근 누르면 ----여기로----");
		// 현재 인증된(로그인한) 사용자의 정보 가져오기
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails) principal;
		String username = userDetails.getUsername();
		model.addAttribute("username", username);
		new OutworkCommand().execute(request, response, model);
		return buildResult(request);
	}

	@RequestMapping(value = "/personnel/overwork.ajax", method = { RequestMethod.GET, RequestMethod.POST })
	public AjaxWriteResult overwork(HttpServletRequest request, HttpServletResponse response, Model model) throws ParseException {
		System.out.println("/overwork.ajax---- 연장신청 누르면 ----여기로----");
		// 현재 인증된(로그인한) 사용자의 정보 가져오기
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails) principal;
		String username = userDetails.getUsername();
		model.addAttribute("username", username);
		new OverworkCommand().execute(request, response, model);
		return buildResult(request);
	}

	// response 할 메소드
	public AjaxWriteResult buildResult(HttpServletRequest request) {
		AjaxWriteResult result = new AjaxWriteResult();

		result.setStatus((String) request.getAttribute("status"));
		result.setMessage((String) request.getAttribute("message"));
		result.setCount((Integer) request.getAttribute("insertResult"));
		result.setCountUpdate((Integer) request.getAttribute("updateResult"));

		return result;
	} // end execute()

	@SuppressWarnings("unchecked") // 노란색 경고 지워짐
	public AjaxWriteList buildList(HttpServletRequest request) {
		List<UserDTO> list = (List<UserDTO>) request.getAttribute("list");

		AjaxWriteList result = new AjaxWriteList();
		result.setStatus((String) request.getAttribute("status"));
		result.setMessage((String) request.getAttribute("message"));

		if (list != null) {
			result.setCount(list.size());
			result.setList(list);
		}

		// 페이징 할때만 필요한 것들.
		try {
			result.setPage((Integer) request.getAttribute("page"));
			result.setTotalPage((Integer) request.getAttribute("totalPage"));
			result.setWritePages((Integer) request.getAttribute("writePages"));
			result.setPageRows((Integer) request.getAttribute("pageRows"));
			result.setTotalCnt((Integer) request.getAttribute("totalCnt"));
		} catch (Exception e) {
			// e.printStackTrace();
		}

		return result;
	} // end buildList()
}
