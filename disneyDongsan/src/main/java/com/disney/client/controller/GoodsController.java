package com.disney.client.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.disney.client.service.BasketService;
import com.disney.client.service.GoodsService;
import com.disney.client.service.MypageGoodsReviewService;
import com.disney.client.service.OrderService;
import com.disney.common.vo.PageDTO;
import com.disney.vo.BasketVO;
import com.disney.vo.GoodsReviewVO;
import com.disney.vo.GoodsVO;
import com.disney.vo.MemberVO;
import com.disney.vo.OrderPayVO;
import com.disney.vo.OrderVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/goods/*")
@Slf4j
public class GoodsController {
	
	@Setter(onMethod_ = @Autowired)
	private GoodsService goodsService;
	
	@Setter(onMethod_ = @Autowired)
	private BasketService basketService;
	
	@Setter(onMethod_ = @Autowired)
	private OrderService orderService;
	
	@Setter(onMethod_ = @Autowired)
	private MypageGoodsReviewService mypageGoodsService;
	
	
	
	//여기부터 굿즈 리스트@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@GetMapping("/goodsList")
	public String GoodsList(@ModelAttribute GoodsVO gvo, Model model) {
		log.info("goodsList 호출 성공");
		
		gvo.setAmount(8);
		
		List<GoodsVO> goodsList = goodsService.goodsList(gvo);
		model.addAttribute("goodsList", goodsList);
		
		int total = goodsService.goodsListCnt(gvo);

		model.addAttribute("pageMaker", new PageDTO(gvo, total));
		
		return "client/goods/goodsList";
	}
	

	@GetMapping("/goodsDetail")
	public String goodsDetail(@ModelAttribute GoodsVO gvo, Model model) {
		log.info("goodsDetail 호출 성공");
		
		GoodsVO detail = goodsService.goodsDetail(gvo);
		model.addAttribute("detail", detail);
		
		return "client/goods/goodsDetail";
	}
	
	
	// 굿즈 디테일 리뷰
	@ResponseBody
	@GetMapping(value="/all/{g_id}", produces=MediaType.APPLICATION_JSON_VALUE)
	public List<GoodsReviewVO> goodsReviewList(@PathVariable("g_id") Integer g_id, GoodsReviewVO gvo){
		log.info("list 호출 성공");
		
		List<GoodsReviewVO> entity = null;
		gvo.setG_id(g_id);
		entity = mypageGoodsService.goodsReviewList(gvo);
		
		return entity;
	}
	
	
	
	
	
	//여기부터 장바구니@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	//장바구니 추가
	@PostMapping("/basketInsert")
	@ResponseBody
	public String addBasketPOST(BasketVO bvo, @SessionAttribute(name = "Member", required = false) MemberVO Member) {
		log.info("basketInsert 호출성공");
		int result = 0;
		
		if(Member != null) {
			result = basketService.addBasket(bvo);
			log.info("result = " + result);
		} else {
			result = 5;
		}
		
		return result + "";
		
	}
	
	//장바구니 리스트
	@GetMapping("/basketList")
	public String basketPageGET(@SessionAttribute(name = "Member", required = false) MemberVO Member, Model model, RedirectAttributes ras) {
		log.info("BasketList 호출성공");
		String url = "";
		
		if(Member != null) {
			model.addAttribute("basketInfo", basketService.getBasketList(Member.getMemberId()));
			url = "client/goods/basketList";
		} else {
			ras.addFlashAttribute("errorMsg", "로그인을 먼저 해주세요.");
			url = "redirect:/member/loginForm";
		}
		
		return url;
	}
	
	//장바구니 수량 수정
	@PostMapping("/basketUpdate")
	public String updateBasketPOST(BasketVO bvo) {
		
		basketService.modifyCount(bvo);
		
		return "redirect:/goods/basketList";
	}
	
	@PostMapping("/basketDelete")
	public String deleteBasketPOST(BasketVO bvo) {
		
		basketService.deleteBasket(bvo.getBasket_id());
		
		return "redirect:/goods/basketList";
	}

	
	
	
	
	
	
	//여기부터 굿즈 주문@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//	@GetMapping("/goodsOrder/{member_id}")
//	public String goodsOrderPage(@PathVariable("member_id") String member_id, OrderVO ovo, Model model,) {
//		log.info("goodsOrder 호출 성공");
//		
//		model.addAttribute("orderList", orderService.getGoodsInfo(ovo.getOrders()));
//		model.addAttribute("memberInfo", memberService.getMemberInfo(member_id));
//		
//		System.out.println(ovo);
//		
//		return "client/goods/goodsOrder";
//	}
	
	//여기부터 굿즈 주문@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@GetMapping("/goodsOrder")
	public String goodsOrderPage(OrderVO ovo, Model model, @SessionAttribute(name="Member", required = false) MemberVO Member, RedirectAttributes ras) {
		log.info("goodsOrder 호출 성공");
		System.out.println(ovo);
		String url = "";
		
		if(Member != null) {
			model.addAttribute("orderList", orderService.getGoodsInfo(ovo.getOrders()));
			model.addAttribute("memberInfo", Member);
			url = "client/goods/goodsOrder";
		} else {
			ras.addFlashAttribute("errorMsg", "로그인을 먼저 해주세요.");
			url = "redirect:/member/loginForm";
		}
		
		return url;
	}
	
	

	//여기부터 결제 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	
	@PostMapping("/goodsPay")
	public String orderPayPagePost(OrderPayVO opv, @SessionAttribute(name="Member") MemberVO Member) {
		
		System.out.println(opv);		
		
		orderService.order(opv, Member);
		
		return "redirect:/goods/goodsList";
	}
	
	
	
	
	
	
	
	
	
	

}
