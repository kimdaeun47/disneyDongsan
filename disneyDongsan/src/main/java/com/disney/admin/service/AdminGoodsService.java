package com.disney.admin.service;

import java.util.List;

import com.disney.vo.GoodsVO;
import com.disney.vo.OrderDetailPayVO;
import com.disney.vo.OrderPayVO;

public interface AdminGoodsService {
	
	public List<GoodsVO> goodsList(GoodsVO gvo);
	public int goodsListCnt(GoodsVO gvo);
	
	public int goodsInsert(GoodsVO gvo) throws Exception;
	
	public GoodsVO goodsDetail(GoodsVO gvo);
	
	public GoodsVO goodsUpdateForm(GoodsVO gvo);
	public int goodsUpdate(GoodsVO gvo) throws Exception;
	
	public int goodsDelete(GoodsVO gvo) throws Exception;
	
	
	
	
	public List<OrderPayVO> orderList() throws Exception;
	
	public List<OrderDetailPayVO> orderView(OrderPayVO opv) throws Exception;
	
	public void delivery(OrderPayVO opv) throws Exception;
	
}
