package com.disney.admin.service;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.disney.admin.dao.AdminGoodsDAO;
import com.disney.common.file.FileUploadUtil;
import com.disney.vo.GoodsVO;
import com.disney.vo.OrderDetailPayVO;
import com.disney.vo.OrderPayVO;
import lombok.Setter;


@Service
public class AdminGoodsServiceImpl implements AdminGoodsService {
	
	@Setter(onMethod_ = @Autowired)
	private AdminGoodsDAO goodsDao;
		
	
	/* 상품 리스트 출력 */
	@Override
	public List<GoodsVO> goodsList(GoodsVO gvo){
		List<GoodsVO> list = null;
		list = goodsDao.goodsList(gvo);
		return list;
	}
	
	@Override
	public int goodsListCnt(GoodsVO gvo) {
		return goodsDao.goodsListCnt(gvo);
	}
	
	
	/* 상품 등록*/
	/*
	@Override
	public int goodsInsert(GoodsVO gvo) {
		int result = 0;
		result = goodsDao.goodsInsert(gvo);
		return result;
	}*/
	
	@Override
	public int goodsInsert(GoodsVO gvo) throws Exception{
		int result = 0;
		if(gvo.getFile().getSize() > 0) {
			String fileName = FileUploadUtil.fileUpload(gvo.getFile(), "goods");
			gvo.setG_image(fileName);
		}
		if(gvo.getFile_detail().getSize() > 0) {
			String fileName = FileUploadUtil.fileUpload(gvo.getFile_detail(), "goods");
			gvo.setG_image_detail(fileName);
		}
		
		result = goodsDao.goodsInsert(gvo);
		return result;
	}
	
	/* 상세 화면 */
	@Override
	public GoodsVO goodsDetail(GoodsVO gvo) {
		GoodsVO detail = goodsDao.goodsDetail(gvo);
		if(detail!=null) {
			detail.setG_detail(detail.getG_detail().toString().replace("\n", "<br />"));
		}
		return detail;
	}

	
	
	
	/* 상품 수정 */
	@Override
	public GoodsVO goodsUpdateForm(GoodsVO gvo) {
		GoodsVO updateData = null;
		updateData = goodsDao.goodsDetail(gvo);
		return updateData;
	}
	
	@Override
	public int goodsUpdate(GoodsVO gvo) throws Exception {
		int result = 0;
		if(!gvo.getFile().isEmpty()) {
			if(!gvo.getG_image().isEmpty()) {
				FileUploadUtil.fileDelete(gvo.getG_image());
			}
			String fileName = FileUploadUtil.fileUpload(gvo.getFile(), "goods");
			gvo.setG_image(fileName);
		}
		
		if(!gvo.getFile_detail().isEmpty()) {
			if(!gvo.getG_image_detail().isEmpty()) {
				FileUploadUtil.fileDelete(gvo.getG_image_detail());
			}
			String fileName = FileUploadUtil.fileUpload(gvo.getFile_detail(), "goods");
			gvo.setG_image_detail(fileName);
		}
		
		result = goodsDao.goodsUpdate(gvo);
		return result;
	}
	
	@Override
	public int goodsDelete(GoodsVO gvo) throws Exception{
		int result = 0;
		if(!gvo.getG_image().isEmpty()) {
			FileUploadUtil.fileDelete(gvo.getG_image());
		}
		if(!gvo.getG_image_detail().isEmpty()) {
			FileUploadUtil.fileDelete(gvo.getG_image_detail());
		}
		result = goodsDao.goodsDelete(gvo.getG_id());
		return result;
	}
	
	@Override
	public List<OrderPayVO> orderList() throws Exception{
		return goodsDao.orderList();
	}
	
	@Override
	public List<OrderDetailPayVO> orderView(OrderPayVO order) throws Exception{
		return goodsDao.orderView(order);
	}
	
	@Override
	public void delivery(OrderPayVO opv) throws Exception{
		goodsDao.delivery(opv);
	}

	

}
