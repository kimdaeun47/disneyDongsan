package com.disney.client.service;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.disney.client.dao.MypageGoodsReviewDao;
import com.disney.common.file.FileUploadUtil;
import com.disney.vo.GoodsReviewVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MypageGoodsReviewServiceImpl implements MypageGoodsReviewService {
	
	@Setter(onMethod_ = @Autowired)
	private MypageGoodsReviewDao mypageGoodsReviewDao;
	
	@Override
	public List<GoodsReviewVO> myGoodsReviewList(String username){
		List<GoodsReviewVO> goodsReviewList = null;
		goodsReviewList = mypageGoodsReviewDao.myGoodsReviewList(username);
		return goodsReviewList;
		
	}
	
	@Override
	public List<GoodsReviewVO> ReviewCompleteList(String username){
		List<GoodsReviewVO> ReviewCompleteList = null;
		ReviewCompleteList = mypageGoodsReviewDao.ReviewCompleteList(username);
		return ReviewCompleteList;
		
	}
	
	@Override
	public int reviewInsert(GoodsReviewVO gvo) throws Exception  {
		int result = 0;
		if(gvo.getFile().getSize()>0) {
			String fileName = FileUploadUtil.fileUpload(gvo.getFile(), "goods");
			gvo.setRe_image(fileName);
		}
		result = mypageGoodsReviewDao.reviewInsert(gvo);
		return result;
	}
	
	@Override
	public GoodsReviewVO userReviewUpdateForm(GoodsReviewVO gvo) {
		GoodsReviewVO updateData = null;
		updateData = mypageGoodsReviewDao.userReviewUpdateForm(gvo);
		return updateData;
	}
	
	@Override
	public int userReviewUpdate(GoodsReviewVO gvo) throws Exception{
		int result = 0;
		if(!gvo.getFile().isEmpty()) {
			if(!gvo.getRe_image().isEmpty()) {
				FileUploadUtil.fileDelete(gvo.getRe_image());
			}
			String fileName = FileUploadUtil.fileUpload(gvo.getFile(), "goods");
			gvo.setRe_image(fileName);
		}
		result = mypageGoodsReviewDao.userReviewUpdate(gvo);
		return result;
	}
	
	@Override
	public int userReviewDelete(GoodsReviewVO gvo) throws Exception  {
		int result = 0;
		if(gvo.getRe_image().isEmpty()) {
			FileUploadUtil.fileDelete(gvo.getRe_image());
		}
		result = mypageGoodsReviewDao.userReviewDelete(gvo);
		return result;
	}
	
	
	//박기수꺼
	@Override
	public List<GoodsReviewVO> goodsReviewList(GoodsReviewVO gvo){
		List<GoodsReviewVO> list = null;
		list = mypageGoodsReviewDao.goodsReviewList(gvo);
		return list;
	}

}
