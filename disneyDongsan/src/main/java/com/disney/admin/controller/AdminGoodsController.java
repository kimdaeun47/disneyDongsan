package com.disney.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.disney.admin.service.AdminGoodsService;
import com.disney.common.vo.PageDTO;
import com.disney.vo.GoodsVO;
import com.disney.vo.OrderDetailPayVO;
import com.disney.vo.OrderPayVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;


@Controller
@RequestMapping("/admin/*")
@Slf4j
public class AdminGoodsController {
	
	@Setter(onMethod_ = @Autowired)
	private AdminGoodsService goodsService;
	
	
	@GetMapping("/adminMain")
	public String AdminMainPage() {
		return "admin/goods/adminMain";
	}
	
	/* 상품 관리 리스트 출력 */
	@GetMapping("/goodsList")
	public String goodsList(@ModelAttribute GoodsVO gvo, Model model) {
		log.info("goodsList 호출 성공");
		
		gvo.setAmount(8);
		
		List<GoodsVO> goodsList = goodsService.goodsList(gvo);
		model.addAttribute("goodsList", goodsList);
		
		int total = goodsService.goodsListCnt(gvo);
		
		model.addAttribute("pageMaker", new PageDTO(gvo, total));
		
		return "admin/goods/goodsList";
	}
	
	/* 상품 등록하기 */
	@GetMapping(value="/goodsInsertForm")
	public String GoodsInsertPage() {
		log.info("goodsInsert 호출 성공");
		return "admin/goods/goodsInsertForm";
	}
	
	/* 상품 등록하기 구현 */
	@PostMapping("/goodsInsert")
	
	public String goodsInsert(GoodsVO gvo, Model model) throws Exception{
		log.info("goodsInsert 호출 성공");
		
		int result = 0;
		String url ="";
		
		result = goodsService.goodsInsert(gvo);
		
		//return "redirect:/board/boardList";
		if(result == 1) {
			url = "/admin/goodsList";
		} else {
			url = "/admin/goodsInsertForm";
		}
		
		return "redirect:"+url;
	}
	
	
	@GetMapping("/goodsDetail")
	public String goodsDetail(@ModelAttribute GoodsVO gvo, Model model) {
		log.info("goodsDetail 호출 성공");
		
		GoodsVO detail = goodsService.goodsDetail(gvo);
		model.addAttribute("detail", detail);
		
		return "admin/goods/goodsDetail";
	}
	
	
	
	
	
	
	
	
	
	
	@GetMapping(value="/goodsUpdateForm")
	public String GoodsUpdateFormPage(@ModelAttribute GoodsVO gvo, Model model) {
		log.info("goodsupdateForm 호출 성공");
		log.info("g_id = " + gvo.getG_id());
		
		GoodsVO updateData = goodsService.goodsUpdateForm(gvo);
		
		model.addAttribute("updateData", updateData);	
		return "admin/goods/goodsUpdateForm";
	}
	
	@PostMapping("/goodsUpdate")
	public String goodsUpdate(@ModelAttribute GoodsVO gvo, RedirectAttributes ras) throws Exception {
		log.info("goodsUpdate 호출 성공");
		
		int result = 0;
		String url="";
		
		result = goodsService.goodsUpdate(gvo);
		ras.addFlashAttribute("goodsVO", gvo);
		
		if(result == 1) {
			url="/admin/goodsDetail";
		}else {
			url="/admin/goodsUpdateForm";
		}
		
		return "redirect:"+url;
	}
	
	
	// 삭제
	@PostMapping(value="/goodsDelete")
	public String goodsDelete(@ModelAttribute GoodsVO gvo) throws Exception{
		log.info("goodsDelete 호출 성공");
		
		int result = 0;
		String url = "";
		
		result = goodsService.goodsDelete(gvo);
		
		if(result == 1) {
			url="/admin/goodsList";
		}else {
			url="/admin/goodsDetail?g_id"+gvo.getG_id();
		}
		return "redirect:"+url;
	}
	
	
	@GetMapping("/deliveryList")
	public String deliveryListPage(Model model) throws Exception {
		log.info("deliveryListPage 호출 성공");
		
		List<OrderPayVO> orderList = goodsService.orderList();
		
		model.addAttribute("orderList", orderList);
		
		return "admin/delivery/deliveryList";
	}
	
	@GetMapping("/deliveryListDetail")
	public String deliveryListDetailPage(@RequestParam("n") String g_order_id, OrderPayVO opv, Model model) throws Exception{
		log.info("deliveryListDetail 호출 성공");
		
		opv.setG_order_id(g_order_id);
		List<OrderDetailPayVO> orderView = goodsService.orderView(opv);
		
		model.addAttribute("orderView", orderView);
		
		log.info(orderView.toString());
		return "admin/delivery/deliveryListDetail";
	
		
	}
	
	@PostMapping(value = "/deliveryListDetail")
	public String deliveryUpdatePage(OrderPayVO opv) throws Exception{
		log.info("deliveryUpdate 호출 성공");
		
		
		goodsService.delivery(opv);
		
		return "redirect:/admin/deliveryListDetail?n=" + opv.getG_order_id();
	}
	

	
	

	
}
