package com.meal.common.File;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.meal.goods.service.GoodsService;
import com.meal.goods.vo.GoodsVO;
import com.meal.goods.vo.Img_gVO;

import net.coobird.thumbnailator.Thumbnails;
@Controller
public class DownLoad {

	@Autowired
	private Img_gVO img_gVO;
	@Autowired
	private GoodsVO goodsVO;
	@Autowired
	private GoodsService goodsService;

	private static String CURR_IMAGE_PATH = "C:\\Meal\\Image";
	// 경로 C:\\Meal\\Image\\goods\\ g_id\\cate \\fileName(상품기준)
	// 경로 C:\\Meal\\Image\\goods\\ g_id\\b_gr_id\\fileName(게시판기준)

	// 이미지 다운로드 상황은 3가지 (어드민 공지이미지 /이벤트이미지 | 상품에대한 이미지 | 상품후기에 관한 이미지 |
	// 상품
	@RequestMapping("/download1.do")
	protected void download1(@RequestParam("cate") String cate, @RequestParam("g_id") String g_id,
			 HttpServletResponse response) throws Exception {
		OutputStream out = response.getOutputStream();

		int g_id1 = Integer.parseInt(g_id);
		List<Img_gVO> listGoodsImg = goodsService.selectImgList(g_id1);
		for (Img_gVO goodsImg : listGoodsImg) {

			if (goodsImg.getCate().equals(cate)) {

				String filePath = CURR_IMAGE_PATH + "\\" + "goods" + "\\" + g_id + "\\" + goodsImg.getCate() + "\\" + goodsImg.getFileName();
				System.out.println(filePath);
				File image = new File(filePath);

				response.setHeader("Cache-Control", "no-cache");
				response.addHeader("Content-disposition", "attachment; fileName=" + goodsImg.getFileName());
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

		}
	}
	
	

	@RequestMapping("/thumbnails.do")
	protected void thumbnails(@RequestParam("cate") String cate, @RequestParam("goods_id") String goods_id,
			HttpServletResponse response) throws Exception {
		OutputStream out = response.getOutputStream();
		String filePath = CURR_IMAGE_PATH + "\\" + goods_id + "\\" + cate;
		File image = new File(filePath);

		if (image.exists()) {
			Thumbnails.of(image).size(121, 154).outputFormat("png").toOutputStream(out);
		}
		byte[] buffer = new byte[1024 * 8];
		out.write(buffer);
		out.close();
	}
}
