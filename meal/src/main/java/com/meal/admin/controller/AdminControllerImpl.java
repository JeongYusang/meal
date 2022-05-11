package com.meal.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.meal.admin.service.AdminService;
import com.meal.admin.vo.AdminVO;
import com.meal.common.controller.BaseController;
import com.meal.member.vo.MemberVO;
import com.meal.seller.vo.SellerVO;

@Controller("adminController")
@RequestMapping("/admin")
public class AdminControllerImpl extends BaseController implements AdminController {

	@Autowired
	BCryptPasswordEncoder passwordEncode;
	@Autowired
	AdminService adminService;


	@Autowired
	private AdminVO adminVO;
	
	@Override
	@RequestMapping(value = "/logout.do", method = RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		AdminVO adminInfo = (AdminVO) session.getAttribute("adminInfo");
		String a_id = adminInfo.getA_id();
		session.setAttribute("isLogOn", false);
		session.removeAttribute("adminInfo");
		mav.setViewName("redirect:/main/main.do");
		return mav;
	}

	@RequestMapping(value = "/addadmin.do", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView addAdmin(@ModelAttribute("adminVO") AdminVO _adminVO, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		String a_id = _adminVO.getU_id();
		String a_pw = _adminVO.getU_pw();
		String a_name = _adminVO.getU_name();
		String a_hp = _adminVO.getU_hp1();
		String a_email1 = _adminVO.getU_email1();
		String a_email2 = _adminVO.getU_email2();
		String encodeu_pw = passwordEncode.encode(a_pw);
		_adminVO.setA_id(a_id);
		_adminVO.setA_pw(encodeu_pw);
		_adminVO.setA_name(a_name);
		_adminVO.setA_hp(a_hp);
		_adminVO.setA_email1(a_email1);
		_adminVO.setA_email2(a_email2);
		adminService.addAdmin(_adminVO);
		String viewName = "/main/main";
		mav.setViewName(viewName);
		return mav;
	}

	@RequestMapping(value = "/selectAllMembers.do", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView selectAllMembers(@RequestParam(value = "dateMap", required = false) Map<String, Object> dateMap,
			@RequestParam(value = "section", required = false) String section,
			@RequestParam(value = "pageNum", required = false) String pageNum, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HashMap<String, Object> pagingMap = new HashMap<String, Object>();
		Integer page = 1;
		Integer index = 0;
		if (pageNum != null) {

			if (section != null) {
				Integer page1 = Integer.parseInt((String) pageNum);
				Integer index1 = Integer.parseInt((String) section);

				System.out.println("인덱스" + index);
				Integer start = (page1 - 1) * 10 + index1 * 100;
				Integer end = 10;
				//Integer end = (page1) * 10 + index1 * 100; 출력개수를 정함.
				pagingMap.put("start", start);
				pagingMap.put("end", end);
				System.out.println(start);
				System.out.println(end);
				System.out.println(pagingMap);
			} else {
				Integer page1 = Integer.parseInt((String) pageNum);

				Integer start = (page1 - 1) * 10 + index * 100;
				Integer end = (page1) * 10 + index * 100;
				pagingMap.put("start", start);
				pagingMap.put("end", end);
			}
		} else {
			Integer start = (page - 1) * 10 + index * 100;
			Integer end = (page) * 10 + index * 100;
			pagingMap.put("start", start);
			pagingMap.put("end", end);
		}
		List<MemberVO> memberVO = adminService.selectAllMembers(pagingMap);
		mav.addObject("memberlist", memberVO);
		
		return mav;
	}
	@RequestMapping(value = "/selectAllSellers.do", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView selectAllSellers(@RequestParam(value = "dateMap", required = false) Map<String, Object> dateMap,
			@RequestParam(value = "section", required = false) String section,
			@RequestParam(value = "pageNum", required = false) String pageNum, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HashMap<String, Object> pagingMap = new HashMap<String, Object>();
		Integer page = 1;
		Integer index = 0;
		if (pageNum != null) {

			if (section != null) {
				Integer page1 = Integer.parseInt((String) pageNum);
				Integer index1 = Integer.parseInt((String) section);

				System.out.println("인덱스" + index);
				Integer start = (page1 - 1) * 10 + index1 * 100;
				Integer end = 10;
				//Integer end = (page1) * 10 + index1 * 100; 출력개수를 정함.
				pagingMap.put("start", start);
				pagingMap.put("end", end);
				System.out.println(start);
				System.out.println(end);
				System.out.println(pagingMap);
			} else {
				Integer page1 = Integer.parseInt((String) pageNum);

				Integer start = (page1 - 1) * 10 + index * 100;
				Integer end = (page1) * 10 + index * 100;
				pagingMap.put("start", start);
				pagingMap.put("end", end);
			}
		} else {
			Integer start = (page - 1) * 10 + index * 100;
			Integer end = (page) * 10 + index * 100;
			pagingMap.put("start", start);
			pagingMap.put("end", end);
		}
		List<SellerVO> sellerVO = adminService.selectAllSellers(pagingMap);
		mav.addObject("sellerlist", sellerVO);
		
		return mav;
	}

}
