package com.meal.board.gr.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.meal.admin.vo.AdminVO;
import com.meal.board.gr.service.BoardGrService;
import com.meal.board.gr.vo.BoardGrVO;
import com.meal.common.controller.BaseController;
import com.meal.member.vo.MemberVO;
import com.meal.seller.vo.SellerVO;


@Controller("boardGrController")
@RequestMapping("/boardGr")

public class BoardGrControllerImpl extends BaseController implements  BoardGrController {

	@Autowired
	private BoardGrService boardGrService;
	@Autowired
	private BoardGrVO boardGrVO;
	@Autowired
	private MemberVO memberVO;
	@Autowired
	private SellerVO sellerVO;

	// 회원이 쓴 문의게시글 조회
	@Override
	@RequestMapping(value = "/selectMyBoardGr.do", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView selectMyBoardBr(@RequestParam(defaultValue = "1") int curPage, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session = request.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");
		String u_id = memberVO.getU_id();
		boardGrVO.setU_id(u_id);
		List<BoardGrVO> boardGr = (List<BoardGrVO>) boardGrService.listBoardGr(boardGrVO);
		mav.addObject("boardGr", boardGr);

		return mav;
	}

	@Override
	@RequestMapping(value = "/boardGrinsert.do", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView writeBoardGr(@ModelAttribute("BoardGrVO") BoardGrVO boardGrVO, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		try {
			boardGrService.boardGrWrite(boardGrVO);
			String message = "글이 작성 되었습니다";
			mav.addObject("message", message);
			String viewName = "redirect:/boardGr/selectBoardGrList.do";
			mav.setViewName(viewName);
			return mav;
		} catch (Exception e) {
			String viewName1 = "/boardGr/boardGrWrite";
			mav.setViewName(viewName1);
			return mav;
		}
	}

	@Override
	@RequestMapping(value = "/boardGrUpdateform.do", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView boardGrUpdateform(@ModelAttribute("b_gr_id") Integer b_gr_id, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		String viewName = request.getParameter("viewName");
		BoardGrVO boardGrVO = boardGrService.boardGrView(b_gr_id);
		HttpSession session = request.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");
		SellerVO sellerVO = (SellerVO) session.getAttribute("sellerInfo");
		AdminVO adminVO = (AdminVO) session.getAttribute("adminInfo");
		try {
			if (memberVO.getU_id().equals(boardGrVO.getU_id())) {

				mav.addObject("boardGrVO", boardGrVO);
				mav.setViewName(viewName);
			} else if (sellerVO.getS_id().equals(boardGrVO.getS_id())) {
				mav.addObject("boardGrVO", boardGrVO);
				mav.setViewName(viewName);
			} else if (adminVO != null) {
				mav.addObject("boardGrVO", boardGrVO);
				mav.setViewName(viewName);
			} else {
				String message = "회원정보가 일치하지 않습니다.";
				mav.addObject("message", message);
				mav.addObject("b_gr_id", b_gr_id);
				viewName = "redirect:/boardGr/bGrDetail.do";
				mav.setViewName(viewName);

			}
			return mav;
		} catch (Exception e) {
			mav.addObject("boardGrVO", boardGrVO);
			String message = "회원정보가 일치하지 않습니다.";
			mav.addObject("message", message);
			mav.addObject("b_gr_id", b_gr_id);
			viewName = "redirect:/boardGr/bGrDetail.do";
			mav.setViewName(viewName);
			return mav;
		}
	}

	@Override
	@RequestMapping(value = "/boardGrUpdate.do", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView boardGrUpdate(@ModelAttribute BoardGrVO boardGrVO, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		String viewName = request.getParameter("viewName");
		try {
			boardGrService.boardGrUpdate(boardGrVO);
			viewName = "redirect:/boardGr/bGrDetail.do";
			int b_gr_id = boardGrVO.getB_gr_id();
			mav.addObject("b_gr_id", b_gr_id);
			mav.setViewName(viewName);
		} catch (Exception e) {
			int b_gr_id = (Integer) boardGrVO.getB_gr_id();
			mav.addObject("b_gr_id", b_gr_id);
			viewName = "redirect:/boardGr/boardGrUpdateform.do";
			mav.setViewName(viewName);
		}
		return mav;
	}

	@Override
	@RequestMapping(value = "/selectBoardGrList.do", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView selectBoardGrList(@RequestParam(value = "dateMap", required = false) Map<String, Object> dateMap,
			@RequestParam(value = "section", required = false) String section,
			@RequestParam(value = "pageNum", required = false) String pageNum, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session = request.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");
		SellerVO sellerVO = (SellerVO) session.getAttribute("sellerInfo");
		String message = (String) request.getAttribute("message");
		if(message != null) {
		mav.addObject("message",message);
		}
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
				// Integer end = (page1) * 10 + index1 * 100; 출력개수를 정함.
				pagingMap.put("start", start);
				pagingMap.put("end", end);
				System.out.println(start);
				System.out.println(end);
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

		List<BoardGrVO> boardGr = boardGrService.selectBoardGrList(pagingMap);
		List<BoardGrVO> board2 = boardGrService.selectBoardGrallList();

		for (BoardGrVO item : boardGr) {
			for (BoardGrVO j : board2) {
				if (!((int) item.getB_gr_id() == (int) j.getParentNo())) {
					String compare = "N";
					item.setCompare(compare);
				} else {
					String compare = "Y";
					item.setCompare(compare);
					System.out.println("BoardCompare" + item.getB_gr_id());
					break;
				}
			}
		}
		mav.addObject("boardGr", boardGr);
		return mav;
	}

	@Override
	@RequestMapping(value = "/bGrDetail.do", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView boardGrView(@RequestParam("b_gr_id") int b_gr_id, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		String viewName = (String) request.getAttribute("viewName");
		String message = (String) request.getAttribute("message");
		if(message != null) {
		mav.addObject("message",message);
		}
		mav.setViewName(viewName);
		BoardGrVO boardGrVO = boardGrService.boardGrView(b_gr_id);
		// 추가 리스트 들고올 것
		List<BoardGrVO> boardList = boardGrService.boardGrViewReview(b_gr_id);
		mav.addObject("boardGrInfo", boardGrVO);
		mav.addObject("ReviewList", boardList);

		return mav;
	}

	@Override
	@RequestMapping(value = "/boardGrWrite.do", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView writeCheck(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		HttpSession session = request.getSession();
		MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");
		SellerVO sellerInfo = (SellerVO) session.getAttribute("sellerInfo");
		AdminVO adminInfo = (AdminVO) session.getAttribute("AdminVO");
		System.out.println("member :" + memberInfo + "  seller :" + sellerInfo + "  admin : " + adminInfo);
		if (memberInfo == null && sellerInfo == null && adminInfo == null) {
			String viewName1 = "redirect:/boardGr/selectBoardGrList.do";
			String message = "로그인을 해주세요.";
			mav.addObject("message", message);
			mav.setViewName(viewName1);
			return mav;
		} else {
			String viewName = "/boardGr/boardGrWrite";
			mav.setViewName(viewName);
			return mav;
		}

	}

	@RequestMapping(value = "/boardGrreviewForm.do", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView reviewForm(@ModelAttribute("b_gr_id") Integer b_gr_id, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		HttpSession session = request.getSession();
		// MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo"); 멤버의 권한은
		// 받지않음
		SellerVO sellerInfo = (SellerVO) session.getAttribute("sellerInfo");
		AdminVO adminInfo = (AdminVO) session.getAttribute("AdminVO");

		// if (memberInfo == null && sellerInfo == null && adminInfo == null) { 멤버의 권한은
		// 받지 않음
		if (sellerInfo == null && adminInfo == null) { // 로그인이 아닐경우 창으로 반송
			String viewName = "/boardGr/boardGrReviewForm";
			BoardGrVO boardGrVO1 = boardGrService.boardGrView(b_gr_id);
			// 여기작성중 답글창에 해당게시글 내용 기재할예정
			mav.addObject("boardGrInfo", boardGrVO1);

			mav.setViewName(viewName);
			return mav;
		} else { // 로그인하고 어드민일경우

			String viewName1 = "redirect:/boardGr/selectBoardGrList.do";
			String message = "로그인을 해주세요.";
			mav.addObject("message", message);
			mav.setViewName(viewName1);
			return mav;
		}

	}

	@Override
	@RequestMapping(value = "/boardGrReviewform.do", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView boardGrReviewForm(@RequestParam(value = "b_gr_id", required = false) Integer b_gr_id,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		String viewName = request.getParameter("viewName");
		BoardGrVO boardGrVO = boardGrService.boardGrView(b_gr_id);
		HttpSession session = request.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");
		SellerVO sellerVO = (SellerVO) session.getAttribute("sellerInfo");
		AdminVO adminVO = (AdminVO) session.getAttribute("adminInfo");
		try {
			if (sellerVO != null && memberVO == null) {
				mav.addObject("boardGrVO", boardGrVO);
				mav.setViewName(viewName);
			} else if (adminVO != null && memberVO == null) {
				mav.addObject("boardGrVO", boardGrVO);
				mav.setViewName(viewName);
			} else {
				String message = "리뷰에 대한 권한이없습니다.";
				mav.addObject("message", message);
				mav.addObject("b_gr_id", b_gr_id);
				viewName = "redirect:/boardGr/bGrDetail.do";
				mav.setViewName(viewName);

			}
			return mav;
		} catch (Exception e) {
			mav.addObject("boardGrVO", boardGrVO);
			String message = "회원정보가 일치하지 않습니다.";
			mav.addObject("message", message);
			mav.addObject("b_gr_id", b_gr_id);
			viewName = "redirect:/boardGr/bGrDetail.do";
			mav.setViewName(viewName);
			return mav;
		}
	}

	@Override
	@RequestMapping(value = "/boardGrDelete.do", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView boardGrDelete(@RequestParam(value = "b_gr_id", required = false) Integer b_gr_id,
			HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) throws Exception {
		ModelAndView mav = new ModelAndView();
		String viewName = request.getParameter("viewName");
		BoardGrVO boardGrVO = boardGrService.boardGrView(b_gr_id);
		HttpSession session = request.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");
		SellerVO sellerVO = (SellerVO) session.getAttribute("sellerInfo");
		System.out.println("sellerInfo : " + sellerVO);
		AdminVO adminVO = (AdminVO) session.getAttribute("adminInfo");
		try {
			if (memberVO != null) {

				if (memberVO.getU_id().equals(boardGrVO.getU_id())) {
					boardGrService.boardGrDelete(b_gr_id);
					redirectAttributes.addAttribute("boardGrVO", boardGrVO);
					String viewName1 = "redirect:/boardGr/selectBoardGrList.do";
					mav.setViewName(viewName1);
					return mav;
				}

			} else if (sellerVO != null) {

				if (sellerVO.getS_id().equals(boardGrVO.getS_id())) {
					boardGrService.boardGrDelete(b_gr_id);
					redirectAttributes.addAttribute("boardGrVO", boardGrVO);
					String viewName1 = "redirect:/boardGr/selectBoardGrList.do";
					mav.setViewName(viewName1);
					return mav;
				}

			} else if (adminVO != null) {
				mav.addObject("boardGrVO", boardGrVO);
				boardGrService.boardGrDelete(b_gr_id);
				String viewName1 = "redirect:/boardGr/selectBoardGrList.do";
				mav.setViewName(viewName1);
				return mav;
			}
			String message = "게시물 작성자가 아닙니다.";
			redirectAttributes.addAttribute("message", message);
			redirectAttributes.addAttribute("b_gr_id", b_gr_id);
			viewName = "redirect:/boardGr/bGrDetail.do";
			mav.setViewName(viewName);
			return mav;

		} catch (Exception e) {
			mav.addObject("boardGrVO", boardGrVO);
			String message = "회원정보가 일치하지 않습니다.";
			redirectAttributes.addAttribute("message", message);
			redirectAttributes.addAttribute("b_gr_id", b_gr_id);
			viewName = "redirect:/boardGr/bGrDetail.do";
			mav.setViewName(viewName);
			return mav;
		}

	}

}

