package com.disney.client.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.disney.client.dao.BasketDAO;
import com.disney.client.dao.OrderDAO;
import com.disney.vo.BasketVO;
import com.disney.vo.MemberVO;
import com.disney.vo.OrderDetailPayVO;
import com.disney.vo.OrderDetailVO;
import com.disney.vo.OrderPayVO;

import lombok.Setter;

@Service
public class OrderServiceImpl implements OrderService {
	
	@Setter(onMethod_ = @Autowired)
	private OrderDAO orderDao;
	
	@Setter(onMethod_ = @Autowired)
	private BasketDAO basketDao;
	
//	@Setter(onMethod_ = @Autowired)
//	private MemberDAO memberDao;

	
	@Override
	public List<OrderDetailVO> getGoodsInfo(List<OrderDetailVO> orders){
		List<OrderDetailVO> result = new ArrayList<OrderDetailVO>();
		for(OrderDetailVO odv : orders) {
			OrderDetailVO goodsInfo = orderDao.getGoodsInfo(odv.getG_id());
			
			goodsInfo.setG_count(odv.getG_count());
			goodsInfo.initTotal();
			
			result.add(goodsInfo);
			
			
		}
		
		return result;
	}
	
	@Override
	@Transactional
	public void order(OrderPayVO opv, MemberVO member) {
		
		List<OrderDetailPayVO> odpv = new ArrayList<>();
		for(OrderDetailPayVO oit : opv.getOrders()) {
			OrderDetailPayVO orderItem = orderDao.getOrderInfo(oit.getG_id());
			//수량
			orderItem.setG_count(oit.getG_count());
			//기본정보
			orderItem.initTotal();
			//List객체 추가
			odpv.add(orderItem);
		}
		/* OrderPayVO 셋팅*/
		opv.setOrders(odpv);
		opv.getOrderPriceInfo();
		
		/*DB 주문, 주문상품,배송정보 넣기*/
		
		// g_order_id만들기 및 orderPayVO 객체g_order_id에 저장
		Date date = new Date();
		SimpleDateFormat format = new SimpleDateFormat("_yyyyMMddmm");
		String g_order_id = member.getMemberId() + format.format(date);
		opv.setG_order_id(g_order_id);
		
		orderDao.enrollOrder(opv);
		for(OrderDetailPayVO oit : opv.getOrders()) {
			oit.setG_order_id(g_order_id);
			orderDao.enrollOrderItem(oit);
		}
		
		for(OrderDetailPayVO oit : opv.getOrders()) {
			BasketVO bvo = new BasketVO();
			bvo.setMember_id(opv.getMember_id());
			bvo.setG_id(oit.getG_id());
			
			basketDao.deleteOrderBasket(bvo);
		}
		
	}
	
	
	
	
	
	
	
}
