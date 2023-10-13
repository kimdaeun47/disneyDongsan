package com.disney.admin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.disney.vo.GoodsVO;
import com.disney.vo.OrderDetailPayVO;
import com.disney.vo.OrderPayVO;


@Mapper
public interface AdminGoodsDAO {
	
	public List<GoodsVO> goodsList(GoodsVO gvo);
	public int goodsListCnt(GoodsVO gvo);
	
	public int goodsInsert(GoodsVO gvo);

	public GoodsVO goodsDetail(GoodsVO gvo);
	
	public GoodsVO goodsUpdateForm(GoodsVO gvo);
	public int goodsUpdate(GoodsVO gvo);
	
	public int goodsDelete(int g_id);
	
	
	public List<OrderPayVO> orderList() throws Exception;
	
	public List<OrderDetailPayVO> orderView(OrderPayVO opv) throws Exception;
	
	public void delivery(OrderPayVO opv) throws Exception;
	
}
