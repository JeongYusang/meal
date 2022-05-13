package com.meal.board.gr.controller;

import java.io.File;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.meal.admin.vo.AdminVO;
import com.meal.board.gr.service.BoardGrService;
import com.meal.board.gr.vo.BoardGrVO;
import com.meal.board.gr.vo.Img_grVO;
import com.meal.common.controller.BaseController;
import com.meal.member.vo.MemberVO;
import com.meal.seller.vo.SellerVO;

@Controller("boardGrController")
@RequestMapping("/boardGr")

public class BoardGrControllerImpl extends BaseController implements BoardGrController {

	private String CURR_IMAGE_UPLOAD_PATH = "C:\\Meal\\Image";
	@Autowired
	private BoardGrService boardGrService;
	@Autowired
	private BoardGrVO boardGrVO;
	@Autowired
	private MemberVO memberVO;
	@Autowired
	private SellerVO sellerVO;

	@Override
	@RequestMapping(value = "/boardGrinsert.do", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView writeBoardGr(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)
			throws Exception {
		ModelAndView mav = new ModelAndView();
		String imageFileName = null;
		HttpSession session = multipartRequest.getSession();

		HashMap<String, Object> newboardGrMap = new HashMap<String, Object>();
		Enumeration enu = multipartRequest.getParameterNames();
		while (enu.hasMoreElements()) {
			String name = (String) enu.nextElement();
			String value = multipartRequest.getParameter(name);
			System.out.println("name + value = " + name + " : " + value);
			newboardGrMap.put(name, value);
		}
		boardGrService.boardGrWrite(newboardGrMap);

		List<HashMap<String, Object>> imageFileList = (List<HashMap<String, Object>>) upload(multipartRequest);
		
		BoardGrVO boardInfo = (BoardGrVO)boardGrService.findb_gr_id();
		  int b_gr_id = (Integer) boardInfo.getB_gr_id();
		  int g_id = (Integer) boardInfo.getG_id();
		  MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");
		  String reg_id = memberVO.getU_id();

		// 이미지 이동을 위한 메소드
		try {
			if (imageFileList != null && imageFileList.size() != 0) {
				for (HashMap<String, Object> item : imageFileList) {
					// 이미지 리스트에 관하여 파일정보 MAP에 판매자 아이디를 추가시킴
					item.put("b_gr_id", b_gr_id);
					item.put("reg_id", reg_id);
					
					// 이미지 파일네임을통해 파일경로 설정
					imageFileName = (String) item.get("fileName");
					if (!(imageFileName.equals("") || imageFileName == null)) {
						// 이미지에 해당하는 정보를 DB에 저장 s_id | cate = fileName |fileName = originalfileName
						boardGrService.addImg(item);
						// temp에 있는 이미지파일경로 설정
						File srcFile = new File(CURR_IMAGE_UPLOAD_PATH + "\\" + "temp" + "\\" + imageFileName);
						// 이동하고자 하는 이미지 파일경로 설정
						File destDir = new File(CURR_IMAGE_UPLOAD_PATH  + "\\" +"goods"+ "\\" + g_id + "\\" + "Gr" + "\\" + b_gr_id);
						// 이동
						FileUtils.moveFileToDirectory(srcFile, destDir, true);
					}
				}
			}
			// 결과창에 출력해주기 위해 판매자 정보를 저장해줌
			MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");
			mav.addObject("memberInfo", memberInfo);
			String viewName = "redirect:/boardGr/selectBoardGrList.do";
			mav.setViewName(viewName);
			return mav;
		} catch (Exception e) {
			e.printStackTrace();
			// 에러가 날경우 temp에 있는 저장했던 이미지 파일들을 삭제 시킴
			if (imageFileList != null && imageFileList.size() != 0) {
				for (HashMap<String, Object> item : imageFileList) {
					imageFileName = (String) item.get("fileName");
					File srcFile = new File(CURR_IMAGE_UPLOAD_PATH + "\\" + "temp" + "\\" + imageFileName);
					srcFile.delete();
					String viewName1 = "redirect:/boardGr/selectBoardGrList.do";
					mav.setViewName(viewName1);
					return mav;
				}
			}
				return mav;
		}
	}

	@Override
	@RequestMapping(value = "/boardGrUpdateform.do", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView boardGrUpdateform(@ModelAttribute("b_gr_id") Integer b_gr_id, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		String viewName = request.getParameter("viewName");
		Map boardGrMap = boardGrService.boardGrView(b_gr_id);
		BoardGrVO boardGrVO = (BoardGrVO)boardGrMap.get("boardGrVO");
		HttpSession session = request.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");
		SellerVO sellerVO = (SellerVO) session.getAttribute("sellerInfo");
		String u_id = memberVO.getU_id();
		String u_id1 = boardGrVO.getU_id();
		System.out.println(u_id);
		System.out.println(u_id1);
		try {
			if (memberVO.getU_id().equals(boardGrVO.getU_id())) {
				mav.addObject("boardGrVO", boardGrVO);
				mav.setViewName(viewName);
			} else if (sellerVO.getS_id().equals(boardGrVO.getS_id())) {
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
	public ModelAndView selectBoardGrList(
			@RequestParam(value = "dateMap", required = false) Map<String, Object> dateMap,
			@RequestParam(value = "section", required = false) String section,
			@RequestParam(value = "pageNum", required = false) String pageNum, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session = request.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");
		SellerVO sellerVO = (SellerVO) session.getAttribute("sellerInfo");
		String message = (String) request.getAttribute("message");
		if (message != null) {
			mav.addObject("message", message);
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
		if (message != null) {
			mav.addObject("message", message);
		}
		Map boardGrMap = boardGrService.boardGrView(b_gr_id);
		BoardGrVO boardGrVO = (BoardGrVO) boardGrMap.get("boardGrVO");
		List<Img_grVO> imageList = (List<Img_grVO>) boardGrMap.get("imageList");
		mav.addObject("boardGrInfo", boardGrVO);
		mav.addObject("imageList", imageList);

		mav.setViewName(viewName);

		// 추가 리스트 들고올 것
		List<BoardGrVO> boardList = boardGrService.boardGrViewReview(b_gr_id);

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
			Map boardGrMap = boardGrService.boardGrView(b_gr_id);
			BoardGrVO boardGrVO = (BoardGrVO) boardGrMap.get("boardGrVO");
			// 여기작성중 답글창에 해당게시글 내용 기재할예정
			mav.addObject("boardGrInfo", boardGrVO);

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
		Map boardGrMap = boardGrService.boardGrView(b_gr_id);
		BoardGrVO boardGrVO = (BoardGrVO) boardGrMap.get("boardGrVO");
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
			HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes)
			throws Exception {
		ModelAndView mav = new ModelAndView();
		String viewName = request.getParameter("viewName");
		Map boardGrMap = boardGrService.boardGrView(b_gr_id);
		BoardGrVO boardGrVO = (BoardGrVO) boardGrMap.get("boardGrVO");
		HttpSession session = request.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");
		SellerVO sellerVO = (SellerVO) session.getAttribute("sellerInfo");
		System.out.println("sellerInfo : " + sellerVO);
		AdminVO adminVO = (AdminVO) session.getAttribute("adminInfo");
		try {
			if (memberVO != null) {

				if (memberVO.getU_id().equals(boardGrVO.getU_id())) {
					boardGrService.boardGrDelete(b_gr_id);
					String viewName1 = "redirect:/boardGr/selectBoardGrList.do";
					String message = "게시글이 삭제 되었습니다";
					redirectAttributes.addAttribute("message", message);
					mav.setViewName(viewName1);
					return mav;
				}

			} else if (sellerVO != null) {

				if (sellerVO.getS_id().equals(boardGrVO.getS_id())) {
					boardGrService.boardGrDelete(b_gr_id);
					String viewName1 = "redirect:/boardGr/selectBoardGrList.do";
					mav.setViewName(viewName1);
					return mav;
				}

			} else if (adminVO != null) {
				mav.addObject("boardGrVO", boardGrVO);
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


