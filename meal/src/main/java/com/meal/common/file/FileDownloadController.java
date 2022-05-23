package com.meal.common.file;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.meal.board.gr.service.BoardGrService;
import com.meal.board.gr.vo.BoardGrVO;
import com.meal.goods.service.GoodsService;
import com.meal.goods.vo.GoodsVO;

import net.coobird.thumbnailator.Thumbnails;

@Controller
public class FileDownloadController {

	@Autowired
	private BoardGrService boardGrService;
	@Autowired
	private BoardGrVO boardGrVO;
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private GoodsVO goodsVO;

	private String CURR_IMAGE_REPO_PATH = "C:\\Meal\\Image";
	private static final Logger logger = LoggerFactory.getLogger(FileDownloadController.class);

	@RequestMapping("/download")
	protected void download(@RequestParam("b_gr_id") int b_gr_id, HttpServletResponse response) throws Exception {
		BoardGrVO boardGrVO = boardGrService.grdownload(b_gr_id);
		String fileName = boardGrVO.getFileName();
		int g_id = boardGrVO.getG_id();

		OutputStream out = response.getOutputStream();
		String filePath = CURR_IMAGE_REPO_PATH + "\\" + "goods" + "\\" + g_id + "\\" + "Gr" + "\\" + b_gr_id + "\\"
				+ fileName;
		logger.debug("filePath: " + filePath);
		File image = new File(filePath);

		response.setHeader("Cache-Control", "no-cache");
		response.addHeader("Content-disposition", "attachment; fileName=" + fileName);
		FileInputStream in = new FileInputStream(image);
		byte[] buffer = new byte[1024 * 8];
		while (true) {
			int count = in.read(buffer);
			if (count == -1)
				break;
			out.write(buffer, 0, count);
		}
		in.close();
		out.close();
	}

	@RequestMapping(value = "/thumbnails.do", method = { RequestMethod.POST, RequestMethod.GET })
	protected void thumbnails(@RequestParam("b_gr_id") int b_gr_id, HttpServletResponse response) throws Exception {
		BoardGrVO boardGrVO = boardGrService.grdownload(b_gr_id);
		String fileName = boardGrVO.getFileName();
		int g_id = boardGrVO.getG_id();
		OutputStream out = response.getOutputStream();
		String filePath = CURR_IMAGE_REPO_PATH + "\\" + "goods" + "\\" + g_id + "\\" + "Gr" + "\\" + b_gr_id + "\\" + fileName;
		File image = new File(filePath);
		logger.debug("filePath: " + filePath);

		if (image.exists()) {
			Thumbnails.of(image).size(300, 300).outputFormat("png").toOutputStream(out);
		}
		byte[] buffer = new byte[1024 * 8];
		out.write(buffer);
		out.close();
	}

	/*
	 @RequestMapping(value = "/g_thumbnails.do", method = { RequestMethod.POST,
	 RequestMethod.GET })
	 
	protected void g_thumbnails(@RequestParam("g_id") int g_id, HttpServletResponse response) throws Exception {
		BoardGrVO boardGrVO = goodsService.grdownload(g_id);
		String fileName = boardGrVO.getFileName();
		int g_id = boardGrVO.getG_id();
		OutputStream out = response.getOutputStream();
		String filePath = CURR_IMAGE_REPO_PATH + "\\" + "goods" + "\\" + g_id + "\\" + fileName + "\\" + fileName;
		File image = new File(filePath);
		logger.debug("filePath: " + filePath);

		if (image.exists()) {
			Thumbnails.of(image).size(300, 300).outputFormat("png").toOutputStream(out);
		}
		byte[] buffer = new byte[1024 * 8];
		out.write(buffer);
		out.close();
	}
	*/
}
