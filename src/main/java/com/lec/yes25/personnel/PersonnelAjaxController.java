package com.lec.yes25.personnel;

import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.lec.yes25.personnel.command.CmmtListCommand;
import com.lec.yes25.personnel.command.GoworkCommand;
import com.lec.yes25.personnel.command.NewempCommand;
import com.lec.yes25.personnel.command.OutworkCommand;
import com.lec.yes25.personnel.command.OverworkCommand;
import com.lec.yes25.personnel.command.TotalworkCommand;

@RestController
@RequestMapping("/personnel/*.ajax")
public class PersonnelAjaxController  {

	public PersonnelAjaxController() {
		super();
	}

	@PostMapping("/personnel/writeOk.ajax")
	public AjaxWriteResult writeOk(HttpServletRequest request, Model model)throws ParseException {
		System.out.println("/writeOk.ajax----사원등록 누르면----여기로----");
		// 현재 인증된(로그인한) 사용자의 정보 가져오기
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails) principal;
		String username = userDetails.getUsername();
		new NewempCommand().execute(request, model);
		return buildResult(request);
	}

	@RequestMapping(value = "/personnel/gowork.ajax", method = { RequestMethod.GET, RequestMethod.POST })
	public AjaxWriteResult gowork(HttpServletRequest request, Model model) throws ParseException {
		System.out.println("/gowork.ajax----출근 누르면 ----여기로----");
		// 현재 인증된(로그인한) 사용자의 정보 가져오기
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails) principal;
		String username = userDetails.getUsername();
		model.addAttribute("username", username);
		
		new GoworkCommand().execute(request, model);
		return buildResult(request);
	}

	@RequestMapping(value = "/personnel/outwork.ajax", method = { RequestMethod.GET, RequestMethod.POST })
	public AjaxWriteResult outwork(HttpServletRequest request, Model model) throws ParseException {
		System.out.println("/outwork.ajax----퇴근 누르면 ----여기로----");
		// 현재 인증된(로그인한) 사용자의 정보 가져오기
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails) principal;
		String username = userDetails.getUsername();
		model.addAttribute("username", username);
		new OutworkCommand().execute(request, model);
		return buildResult(request);
	}

	@RequestMapping(value = "/personnel/overwork.ajax", method = { RequestMethod.GET, RequestMethod.POST })
	public AjaxWriteResult overwork(HttpServletRequest request, Model model) throws ParseException {
		System.out.println("/overwork.ajax---- 연장신청 누르면 ----여기로----");
		// 현재 인증된(로그인한) 사용자의 정보 가져오기
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails) principal;
		String username = userDetails.getUsername();
		model.addAttribute("username", username);
		new OverworkCommand().execute(request, model);
		return buildResult(request);
	}
	
	@RequestMapping(value = "/personnel/totalwork.ajax", method = { RequestMethod.GET, RequestMethod.POST })
	public AjaxWriteResult totalwork(HttpServletRequest request, Model model) throws ParseException {
		System.out.println("/totalwork.ajax----여기로----");
		// 현재 인증된(로그인한) 사용자의 정보 가져오기
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails) principal;
		String username = userDetails.getUsername();
		model.addAttribute("username", username);
		new TotalworkCommand().execute(request, model);
		return buildResult(request);
	}
	
	
	@RequestMapping(value = "/personnel/cmmtlist.ajax", method = { RequestMethod.GET, RequestMethod.POST })
	public AjaxWriteResult cmmtList(HttpServletRequest request, Model model,
				@RequestParam("startDate") String start, 
				@RequestParam("endDate") String end) throws ParseException { // model 에 dto 담김
		
		System.out.println("/cmmtlist.ajax----여기로----");
		// 현재 인증된(로그인한) 사용자의 정보 가져오기
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails) principal;
		String username = userDetails.getUsername();
		model.addAttribute("username", username);
		model.addAttribute("start", start);
		model.addAttribute("end", end);
		new CmmtListCommand().execute(request, model);
		
		return buildList(request);
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
