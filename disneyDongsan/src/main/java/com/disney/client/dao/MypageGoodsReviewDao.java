package com.disney.client.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.disney.vo.GoodsReviewVO;



@Mapper
public interface MypageGoodsReviewDao {
	
	public List<GoodsReviewVO> myGoodsReviewList(String username);
	
	public int reviewInsert(GoodsReviewVO gvo) throws Exception;
	
	public GoodsReviewVO userReviewUpdateForm(GoodsReviewVO gvo);
	
	public int userReviewUpdate(GoodsReviewVO gvo) throws Exception;
	
	public int userReviewDelete(GoodsReviewVO gvo) throws Exception;
	
	public List<GoodsReviewVO> ReviewCompleteList(String username);

	public List<GoodsReviewVO> goodsReviewList(GoodsReviewVO gvo);

}
