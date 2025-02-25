package com.example.demo.product;

import java.text.DecimalFormat;
import java.time.LocalDate;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.util.WebUtils;

import com.example.demo.MyUtil;
import com.example.demo.dto.BaesongDto;
import com.example.demo.dto.CartDto;
import com.example.demo.dto.GumaeDto;
import com.example.demo.dto.ProductDto;
import com.example.demo.dto.QnaDto;
import com.example.demo.dto.ReviewDto;
import com.example.demo.member.MemberDto;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Service
@Qualifier("ps")
public class ProductServiceImpl implements ProductService {
	@Autowired
	private ProductMapper mapper;

	@Override
	public String productList(HttpServletRequest request, Model model) {

		String pcode = request.getParameter("pcode");

		int page = 1;
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		int index = (page - 1) * 20;
		int pstart = page / 10;
		if (page % 10 == 0) {
			pstart--;
		}
		pstart = (pstart * 10) + 1;
		int pend = pstart + 9;
		int totalPg = mapper.getTotalPg(pcode);
		if (totalPg < pend) {
			pend = totalPg;
		}

		// 정렬형태를 처리하기
		// 가격높은순, 가격낮은순, 판매량순, 최신순
		String orderStr = "";
		int order = 1;
		if (request.getParameter("order") != null) {
			order = Integer.parseInt(request.getParameter("order"));
		}
		switch (order) {
		case 1:
			orderStr = "pansu desc";
			break;
		case 2:
			orderStr = "price desc";
			break;
		case 3:
			orderStr = "price asc";
			break;
		case 5:
			orderStr = "writeday desc";
			break;
		case 4:
			orderStr = "star desc";
			break;
		default:
			orderStr = "pansu desc";
		}
		model.addAttribute("order",order);
		
		// pcode를 이용하여 Home - 대분류 - 중분류 - 소분류 를 뷰에 전달.
		String menuList = "";
		if(pcode.length() == 3) {
			// Home - 대분류
			
			String dae = pcode.substring(1); // p01
			String daeName = mapper.getDae(dae);
			menuList = "Home - " + daeName;
			
		} else if (pcode.length() == 5) {
			// Home - 대분류 - 중분류
			
			String dae = pcode.substring(1,3);
			String jung = pcode.substring(3);
			
			String daeName = mapper.getDae(dae);
			String jungName = mapper.getJung(dae,jung);
			menuList = "Home - " +daeName + " - " + jungName;
			
		} else {
			// Home - 대분류 - 중분류 - 소분류
			
			String dae = pcode.substring(1,3);
			String jung = pcode.substring(3,5);
			String so = pcode.substring(5);
			
			String daeName = mapper.getDae(dae);
			String jungName = mapper.getJung(dae,jung);
			String daejung = dae+jung;
			String soName = mapper.getSo(daejung,so);
			menuList = "Home - " +daeName + " - " + jungName +" - " + soName;
		}
		
		model.addAttribute("menuList",menuList);
		
		ArrayList<ProductDto> plist = mapper.productList(orderStr, index, pcode);

		// 배송일 => 월/일(요일) 도착 예정
		for (int i = 0; i < plist.size(); i++) { // ArrayList의 요소<ProductDto>를 읽는다.
			ProductDto pdto = plist.get(i);

			/*
			 * String baeDayStr = MyUtil.getBaesong(pdto.getBaeday());
			 * pdto.setBaeDayStr(baeDayStr);
			 */
			MyUtil.getBaesong(pdto);

			// 별점을 getStar()메소드에 보내고
			// 노란별, 반별, 회색별
			/*
			 * int[] stars = MyUtil.getStar(pdto.getStar()); pdto.setYstar(stars[0]);
			 * pdto.setHstar(stars[1]); pdto.setGstar(stars[2]);
			 */

			MyUtil.getStar(pdto);

			int price = pdto.getPrice();
			int halin = pdto.getHalin();
			int juk = pdto.getJuk();

			double halinPrice = price - (price * halin / 100);
			double jukPrice = halinPrice * juk / 100;

			DecimalFormat df = new DecimalFormat("#,###");
			String PriceStr = df.format(price);
			pdto.setPriceStr(PriceStr);

			pdto.setHalinPriceStr(df.format(halinPrice));
			pdto.setJukPriceStr(df.format(jukPrice));
		}
		model.addAttribute("page", page);
		model.addAttribute("pstart", pstart);
		model.addAttribute("pend", pend);
		model.addAttribute("totalPg", totalPg);
		model.addAttribute("pcode", pcode);
		model.addAttribute("plist", plist);

		return "/product/productList";
	}

	
	@Override
	public String productContent(HttpServletRequest request, Model model,HttpSession session) {
		String pcode = request.getParameter("pcode");
		ProductDto pdto = mapper.productContent(pcode);
		
		// 현재 상품이 jjim테이블에 존재하는지 여부를 뷰에 전달.
		int jjimChk = 0;	// session이 없거나 값이 없으면 model로 넘길수가 없다. 초기값을 넣어준다. 
		if(session.getAttribute("userid")!=null) {
			String userid = session.getAttribute("userid").toString();
			jjimChk = mapper.isJjim(userid,pcode);	
		}	
		
		
		MyUtil.getStar(pdto);
		
		int price = pdto.getPrice();
		int halin = pdto.getHalin();
		int juk = pdto.getJuk();
		int baePrice = pdto.getBaeprice();
		double halinPrice = price - (price * halin / 100);
		double jukPrice = halinPrice * juk / 100;
		
		DecimalFormat df = new DecimalFormat("#,###");
		String PriceStr = df.format(price);
		pdto.setPriceStr(PriceStr);
		pdto.setBaePriceStr(df.format(baePrice));
		pdto.setHalinPriceStr(df.format(halinPrice));
		pdto.setJukPriceStr(df.format(jukPrice));
		
		
		MyUtil.getBaesong(pdto);
		model.addAttribute("pdto",pdto);
		
		ArrayList<ReviewDto> rlist = mapper.getReview(pcode);
		for (int i=0;i<rlist.size();i++) {
			/*
			 * String labeledUserid =
			 * mapper.getLabeledUserid(rdto.getUserid());
			 * rdto.setLabeledUserid(labeledUserid);
			 */
			ReviewDto rdto = rlist.get(i);
			rdto.setContent(rdto.getContent().replace("\r\n", "<br>"));
		}
		ArrayList<QnaDto> qlist = mapper.getQna(pcode);
		for (int i=0;i<qlist.size();i++) {
			QnaDto qdto = qlist.get(i);
			qdto.setContent(qdto.getContent().replace("\r\n", "<br>"));
		}
		
		model.addAttribute("qlist",qlist);
		model.addAttribute("rlist",rlist);
		model.addAttribute("jjimChk",jjimChk);
		return "/product/productContent";
	}

	
	
	@Override
	public String jjimOk(HttpServletRequest request, HttpSession session) {
		
		// 회원전용 문서
		
		if (session.getAttribute("userid")==null) {
			return "0";
			
		} else {
			String pcode = request.getParameter("pcode");
			String userid = session.getAttribute("userid").toString();
			mapper.jjimOk(pcode,userid);
			return "1";
		}
	}

	@Override
	public String jjimDelete(HttpServletRequest request, HttpSession session) {
		if(session.getAttribute("userid")==null) {
			return "0";
		} else {
			String userid = session.getAttribute("userid").toString();
			String pcode = request.getParameter("pcode");
			mapper.jjimDelete(userid,pcode);
			return "1";
		}
	}

	@Override
	public String addCart(CartDto cdto,HttpSession session,HttpServletRequest request, HttpServletResponse response) {
		if(session.getAttribute("userid")==null) {
			// return "0";
			// 쿠키변수에 상품코드와 수량을 저장한다.
			// 쿠키는 클라이언트에 저장 => 클라이언트에서 값을 읽어오려면 request, 저장하려면 response						
							
			// 새로 추가되는 상품코드
			String newCode = cdto.getPcode() + "-" + cdto.getSu()+"/";
			
			// 클라이언트에서 쿠키변수를 읽어온다.
			Cookie cookie = WebUtils.getCookie(request, "cart");
			
			if (cookie == null || cookie.getValue().equals("")) {
				cookie = new Cookie("cart",newCode);
				cookie.setMaxAge(60*60*24);
				cookie.setPath("/");
				
				//System.out.println("쿠키 만듬 : " + cookie.getValue());
				response.addCookie(cookie);
			} else {
				String cart = cookie.getValue(); // 자바의 cart변수
				
				// 중복체크
				String[] carts = cart.split("/");
				
				var chk = 0;
				for (int i = 0; i < carts.length;i++) {
					if (carts[i].indexOf(cdto.getPcode()) != -1) { // "상품코드-수량".indexOf("상품코드")
						// 기존 상품의 수량과 새로 추가되는 상품의 수량을 더해서 수정
						int hap = Integer.parseInt(carts[i].substring(13))+cdto.getSu();
						
						carts[i] = carts[i].substring(0,13)+hap;
						
						chk = 1;
					}
				}
				String cartNew = "";
				// 배열에 있는 상품을 String으로 변경 "/"를 구분자
				for (int i = 0; i < carts.length; i++) {
					cartNew = cartNew + carts[i]+"/";
				}
				
				if(chk == 1) {
					cart = cartNew;
				} else {
					cart = cartNew + newCode;
				}
				cookie = new Cookie("cart",cart);
				cookie.setMaxAge(60*60*24);
				cookie.setPath("/");
				
				//System.out.println("쿠키 추가함 : " + cookie.getValue());
				response.addCookie(cookie);
			}
			
			
		} else {	
			String userid = session.getAttribute("userid").toString();
			cdto.setUserid(userid);
			if (mapper.isCart(cdto)) {
				mapper.upCart(cdto);
			} else {
				mapper.addCart(cdto);
			}
			
		}
		return "1";
	}

	@Override
	public String productGumae(HttpSession session, HttpServletRequest request, Model model) {
		
		String pcode = request.getParameter("pcode");
		String su = request.getParameter("su");
		if (session.getAttribute("userid")==null) {
			return "redirect:/login/login?pcode="+pcode+"&su="+su;
			
		} else {
			String userid = (String)session.getAttribute("userid");
			// 구매자 정보
			MemberDto mdto = mapper.getMember(userid);
			model.addAttribute("mdto",mdto);
			
			
			// 배송지 정보
			BaesongDto bdto = mapper.getBaesong(userid);
			
			if (bdto!=null) {
				String reqStr = null;
				switch(bdto.getReq()) {
					case 0 : reqStr = "문 앞"; break;
					case 1 : reqStr = "직접 받고 부재시 문 앞"; break;
					case 2 : reqStr = "경비실"; break;
					case 3 : reqStr = "택배함"; break;
					case 4 : reqStr = "기타"; break;
					default: reqStr ="";
				}
				bdto.setReqStr(reqStr);
			}
			model.addAttribute("bdto",bdto);
			
			
			// 여러 개의 상품 정보
			// cartView에서는 , 를 가지고 있고 => 1개 이상 존재
			// productContent에서는 ,가 없으니 => 1개만 존재
			String[] pcodes = pcode.split(",");
			String[] sus = su.split(",");
			
			ArrayList<ProductDto> plist = new ArrayList<ProductDto>();
			for (int i = 0; i < pcodes.length; i++) {
			
				ProductDto pdto = mapper.productContent(pcodes[i]);
				MyUtil.getBaesong(pdto);
				// pdto의 su변수에는 재고수량!!
				pdto.setSu(Integer.parseInt(sus[i])); // 구매수량으로 set해야 한다.
				
				// 총 상품금액 , 적립금
				DecimalFormat df = new DecimalFormat("#,###");
				int price = pdto.getPrice();
				int halin = pdto.getHalin();
				price = price-(price*halin/100);
				pdto.setPrice(price);
				
				String PriceStr = df.format(price);
				pdto.setPriceStr(PriceStr);
				// 적립금은 MemberDto에 있음
				// 총 결제금액 => 할인금액으로 계산된 값을 pdto.price에 재저장.
				//int cPrice = price + pdto.getBaeprice();
				//pdto.setPrice(cPrice);
				
				plist.add(pdto);
			}
			
			
			model.addAttribute("plist",plist);
			
			
			return "product/productGumae";
		}
	}

	@Override
	public String baesongWrite() {
		return "/product/baesongWrite";
	}

	@Override
	public String baesongWriteOk(BaesongDto bdto, HttpSession session) {
		// 배송지 주소를 baesong테이블에 저장
		bdto.setUserid( (String)session.getAttribute("userid") );
		
		// 현재 입력된 주소를 기본주소로 한다면 기존의 기본주소를 0으로 수정
		if(bdto.getGibon()==1) {
			mapper.setZero((String)session.getAttribute("userid"));
		}
		// 처음 입력하는 주소인데 기본주소 체크를 안 했을 경우
		if(mapper.isBaesong((String)session.getAttribute("userid"))==0) {
			bdto.setGibon(1);
		}
		
		mapper.baesongWriteOk(bdto);		
		if (bdto.getCk()==0) {
			return "redirect:/product/baesongList";
		} else {
			return "/member/baesongUpdateOk";
		}
	}

	@Override
	public String baesongList(HttpSession session, Model model) {
		String userid = (String)session.getAttribute("userid");
		ArrayList<BaesongDto> blist = mapper.baesongList(userid);
		
		for (int i = 0; i < blist.size(); i++) {
			BaesongDto bdto = blist.get(i);
				String reqStr = null;
				switch(bdto.getReq()) {
					case 0 : reqStr = "문 앞"; break;
					case 1 : reqStr = "직접 받고 부재시 문 앞"; break;
					case 2 : reqStr = "경비실"; break;
					case 3 : reqStr = "택배함"; break;
					case 4 : reqStr = "기타"; break;
					default: reqStr ="";
				}
				bdto.setReqStr(reqStr);
			
		}
		model.addAttribute("blist",blist);
		return "/product/baesongList";
	}

	@Override
	public String gumaeOk(GumaeDto gdto, HttpSession session ,HttpServletRequest request) {
		if(session.getAttribute("userid")==null) {
			return "redirect:/login/login";
		} else {
			String userid = (String)session.getAttribute("userid");
			gdto.setUserid(userid);
			// 주문코드 만들기 => j20250211 + 001;
			String today = LocalDate.now().toString();
			today = today.replace("-", "");
			//System.out.println(today);
			String jumuncode = "j"+today;
			
			
			int num = mapper.getNumber(jumuncode);
			jumuncode = jumuncode+String.format("%03d", num);
			gdto.setJumuncode(jumuncode);
			
			String[] pcodes = request.getParameterValues("pcode");
			String[] sus = request.getParameterValues("su");
			/*
			 * // pcode,su의 값을 배열로 만든 뒤 하나 씩 저장 String[] pcodes =
			 * gdto.getPcode().split("/"); String[] sus = gdto.getSus().split("/"); // su는
			 * int자료형이니 sus라는 String자료형을 Dto에 생성
			 */			
			for (int i = 0; i < pcodes.length; i++) {
				// 배열의 각 요소에 있는 pcode,su로 setter
				gdto.setPcode(pcodes[i]);
				gdto.setSu(Integer.parseInt(sus[i]));
				mapper.gumaeOk(gdto);
				mapper.cartDel(userid, pcodes[i]);
			}
			// member 테이블의 juk 필드의 값을 사용된 적립금만큼 뺀다. 
			mapper.useJuk(gdto.getUseJuk(),gdto.getUserid());
			return "redirect:/product/gumaeList?jumuncode="+jumuncode;
		}	
	}

	@Override
	public String baesongDelete(HttpServletRequest request, HttpSession session) {
		if(session.getAttribute("userid")==null)
		{
			return "redirect:/etc/baesongOut";
		}
		else
		{
			String id=request.getParameter("id");
			mapper.baesongDelete(id);
			if (request.getParameter("ck")==null) {
				return "redirect:/product/baesongList";
			} else {
				return "redirect:/member/baesongList";
			}
		}	
	}

	@Override
	public String baesongUpdate(HttpServletRequest request, HttpSession session,Model model) 
	{
		
		if(session.getAttribute("userid")==null)
		{
			return "redirect:/etc/baesongOut";
		}
		else
		{
			String id=request.getParameter("id");
			BaesongDto bdto=mapper.getBaesong2(id);
			model.addAttribute("bdto",bdto);
			
			return "/product/baesongUpdate";
		}
	}

	@Override
	public String baesongUpdateOk(BaesongDto bdto, HttpSession session) 
	{
		if(session.getAttribute("userid")==null)
		{
			return "redirect:/etc/baesongOut";
		}
		else
		{
			if(bdto.getGibon()==1) {
				mapper.setZero(session.getAttribute("userid").toString());	
			}
			
				mapper.baesongUpdateOk(bdto);
				
			if (bdto.getCk() == 0 ) {
				return "redirect:/product/baesongList";
			} else {
				return "/member/baesongUpdateOk";
			}
		}	
	}
	
	
	
	@Override
	public String gumaeList(HttpServletRequest request, HttpSession session, Model model) {
		// 방금 주문한 상품의 주문코드를 이용하여 상퓸의 정보, 구매내역을'
		// 사용자에게 보여준다.
		
		// 상품정보 : 배송예정일, 수량, 상품그림, 제목, 할인적용된 금액
		// 배송지정보 : 받는사람, 우편번호, 주소, 배송요청사항
		// 구매가격 : 총상품금액, 모든 배송비, 사용적립금 = > 총 결제금액
		String jumuncode = request.getParameter("jumuncode");
		
		// gumae테이블 내용 가져오기
		ArrayList<GumaeDto> glist = mapper.getGumae(jumuncode);
		
		// glist의 GumaeDto 에서 pcode를 이용하여 Product테이블 내용을 ProductDto에 가져오기
		
		// 상품의 합계금액, 배송비 합계금액, 사용된 적립금을 저장할 변수
		int halinPriceAll = 0, baePriceAll=0;
		int useJuk=0;
		
		ArrayList<ProductDto> plist = new ArrayList<ProductDto>();
		for (int i = 0; i < glist.size(); i++) {
			GumaeDto gdto = glist.get(i);
			
			ProductDto pdto = mapper.productContent(gdto.getPcode());
			
			// 배송예정일
			MyUtil.getBaesong(pdto);
			// 구매수량 gdto.getSu() => pdto.setSu();
			pdto.setSu(gdto.getSu());
			// 상품그림, 제목은 pdto에
			// 할인 적용된 금액 = 상품금액-(상품금액*할인율/100)
			int halinPrice = pdto.getPrice() - (pdto.getPrice()*pdto.getHalin()/100);
			pdto.setPrice(halinPrice);
			
			// 상품의 합계금액, 배송비 합계금액, 사용된 적립금 => 따로 뷰에 전달
			halinPriceAll = halinPriceAll + halinPrice;
			baePriceAll = baePriceAll + pdto.getBaeprice();
			useJuk = gdto.getUseJuk();
			
			plist.add(pdto);
		}
		model.addAttribute("plist",plist);
		
		// 배송지 정보
		GumaeDto gdto = glist.get(0);
		BaesongDto bdto = mapper.getBaesong2(gdto.getBaeId()+"");
		String reqStr = null;
		switch(bdto.getReq()) {
			case 0 : reqStr = "문 앞"; break;
			case 1 : reqStr = "직접 받고 부재시 문 앞"; break;
			case 2 : reqStr = "경비실"; break;
			case 3 : reqStr = "택배함"; break;
			case 4 : reqStr = "기타"; break;
			default: reqStr ="";
		}
		bdto.setReqStr(reqStr);
		model.addAttribute("bdto",bdto);	
		
		model.addAttribute("halinPriceAll",MyUtil.comma(halinPriceAll));
		model.addAttribute("baePriceAll",MyUtil.comma(baePriceAll));
		model.addAttribute("useJuk",MyUtil.comma(useJuk));
		model.addAttribute("chongPrice",MyUtil.comma(halinPriceAll+baePriceAll-useJuk));
		
		return "/product/gumaeList";
	}

	@Override
	public String qnaWriteOK(QnaDto qdto, HttpServletRequest request,HttpSession session) {
		String userid = session.getAttribute("userid").toString();
		qdto.setUserid(userid);
		mapper.qnaWriteOk(qdto);
		
		return "redirect:/product/productContent?pcode="+qdto.getPcode();
	}


	@Override
	public String qnaDelete(QnaDto qdto,HttpServletRequest request) {
			//System.out.println(qdto.getId());
			mapper.qnaDelete(qdto.getId());
			
			if (request.getParameter("chk")==null) {
				return "redirect:/product/productContent?pcode="+qdto.getPcode();
			} else {
				return "redirect:/member/qnaList";
			}

	}
}
