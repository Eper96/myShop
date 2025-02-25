package com.example.demo.member;

import java.text.DecimalFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.util.WebUtils;

import com.example.demo.MyUtil;
import com.example.demo.dto.BaesongDto;
import com.example.demo.dto.GumaeDto;
import com.example.demo.dto.ProductDto;
import com.example.demo.dto.ReviewDto;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Service
@Qualifier("ms")
public class MemberServiceImpl implements MemberService {
	@Autowired
	private MemberMapper mapper;

	@Override
	public String member() {

		return "/member/member";
	}

	@Override
	public String useridChk(HttpServletRequest request) {

		String userid = request.getParameter("userid");
		return mapper.useridChk(userid).toString();

	}

	@Override
	public String memberOk(MemberDto mdto) {
		// 아이디 중복체크를 다시 한다..
		Integer n = mapper.useridChk(mdto.getUserid());
		if (n == 0) {
			mapper.memberOk(mdto);
			return "redirect:/login/login";
		} else {
			return "redirect:/member/member?err=1";
		}
	}

	@Override
	public String cartView(HttpServletRequest request, Model model, HttpSession session) {
		ArrayList<ProductDto> plist = null;
		
		if (session.getAttribute("userid") == null) {

			 // 쿠키변수를 읽어온다 //  상품코드-수량
			Cookie cookie=WebUtils.getCookie(request, "cart");
			if(cookie!=null && !cookie.getValue().equals(""))
			{
				String[] pcodes=cookie.getValue().split("/"); // 상품코드1-수량/상품코드2-수량/상품코드3-수량/
				
				plist=new ArrayList<ProductDto>();
				DecimalFormat df=new DecimalFormat("#,###");
				
				for(int i=0;i<pcodes.length;i++)
				{
					String pcode=pcodes[i].substring(0,12);
					
					ProductDto pdto=mapper.getProduct(pcode);
					
					MyUtil.getBaesong(pdto);
					
					int price=pdto.getPrice();
					int halin=pdto.getHalin();
					int juk=pdto.getJuk();
					
					double halinPrice=price-(price*halin/100.0);		
					double jukPrice= price*juk/100.0;
					
					pdto.setHalinPriceStr(df.format(halinPrice));
					pdto.setJukPriceStr(df.format(jukPrice));
				 
					// 계산된 할인금액을 price필드에 저장해서 뷰에 전달
					pdto.setPrice((int)halinPrice);
					
					// 배열에서 수량을 뽑아서 pdto의 su필드에 저장
					int su=Integer.parseInt(pcodes[i].substring(13));
					pdto.setSu(su);
				
					//  wchk를 모두 1
					pdto.setWchk(1);
					
					plist.add(pdto);
				}
				model.addAttribute("allChk","1");
				model.addAttribute("plist",plist);
			}
		} else {
			// cart테이블의 정보를 전달하기
			String userid = session.getAttribute("userid").toString();
			plist = mapper.cartView(userid);
			DecimalFormat df = new DecimalFormat("#,###");
			int wchkNum=0;
			for (int i = 0; i < plist.size(); i++) {
				ProductDto pdto = plist.get(i);
				MyUtil.getBaesong(pdto);

				int price = pdto.getPrice();
				int halin = pdto.getHalin();
				int juk = pdto.getJuk();
				int baePrice = pdto.getBaeprice();
				double halinPrice = price - (price * halin / 100);
				double jukPrice = halinPrice * juk / 100;

				String PriceStr = df.format(price);
				pdto.setPriceStr(PriceStr);
				pdto.setBaePriceStr(df.format(baePrice));
				pdto.setHalinPriceStr(df.format(halinPrice));
				pdto.setJukPriceStr(df.format(jukPrice));
				
				// 계산된 할인금액을 price필드에 저장해서 뷰에 전달
				pdto.setPrice((int)halinPrice);
				if (pdto.getWchk()==1) {
					wchkNum++;
				}
			}
			int allChk=0;
			if (wchkNum == plist.size()) {
				allChk=1;
			}
			model.addAttribute("allChk",allChk);
			model.addAttribute("plist", plist);

		}

		// 레코드의 갯수에 따른 section의 높이 조절
		int height = 660;
		int size = 0;
		if (plist!=null) {
			size = plist.size();
		}
		if (size > 4) {
			int n = size-4;
			n=n*115;	// 추가되는 레코드당 110px를 추가
			height=n+height; // 기본값 추가
		}
		model.addAttribute("height",height);
		model.addAttribute("today",LocalDate.now().toString());

		return "member/cartView";
	}

	@Override
	public String cartDel(HttpServletRequest request, HttpSession session,HttpServletResponse response) {
		
		if (session.getAttribute("userid")==null) {
			String pcodes=request.getParameter("ids"); // 상품코드1 : 상품코드1,상품코드2,상품코드3,
			
			Cookie cookie=WebUtils.getCookie(request, "cart");
			
			if(cookie!=null && !cookie.getValue().equals(""))
			{
				String cart=cookie.getValue(); // 쿠키변수에 있는 값 => 상품코드1-수량/상품코드2-수량/상품코드3-수량/
				String[] carts=cart.split("/"); // 상품코드를 배열로 변경
				
				String[] pcodeDel=pcodes.split(","); // 삭제하고자 하는 상품코드의 집합
		 				
				for(int i=0;i<carts.length;i++)
				{
					for(int j=0;j<pcodeDel.length;j++)
					{
						if(carts[i].indexOf(pcodeDel[j]) != -1) // 있으면 0이상의 인덱스값 , 없으면 -1
						{
							carts[i]="";
						}
					}					
				}
				
				for(int i=0;i<carts.length;i++)
				{
					System.out.println(i+" : "+carts[i]);
				}
				
				// 배열의 상품코드를 문자열로 변경
				String newCart="";
				for(int i=0;i<carts.length;i++)
				{
					if(carts[i]!="")
					{
						newCart=newCart+carts[i]+"/";
						
						System.out.println(i);
					}
				}
				
				cookie=new Cookie("cart",newCart);
				cookie.setMaxAge(60*60*24);
				cookie.setPath("/");
				
				response.addCookie(cookie);
			}
		} else {
			// 요청된 상품을 cart테이블에서 삭제
			// 선택삭제 => "11,12,13,"
			// 삭제 => "11"
			
			String ids = request.getParameter("ids");
			String[] imsi = ids.split(",");
			for (int i = 0; i < imsi.length; i++) {
				mapper.cartDel(imsi[i]);
			}
			
		}
		return "redirect:/member/cartView";
	}

	@Override
	public String cghSu(HttpServletRequest request,HttpSession session,
			HttpServletResponse response) {
		String id = request.getParameter("id");
		String num = request.getParameter("num");
		String pcode = request.getParameter("pcode");
		
		if (session.getAttribute("userid")==null) {
			Cookie cookie = WebUtils.getCookie(request, "cart");
			if(cookie!= null && !cookie.getValue().equals("")) {
				String cart = cookie.getValue();
				String[] carts = cart.split("/");
				for (int i = 0; i < carts.length; i++) {
					if(carts[i].indexOf(pcode) != -1) {
						//carts[i] = carts[i].substring(0,13) + num;
						carts[i] = pcode + "-" + num;
					}
				}
				// 다시 문자열을 생성해서 쿠키에 저장
				String newCarts="";
				for(int i = 0; i < carts.length; i++) {
					newCarts += carts[i] + "/";
				}
				cookie = new Cookie("cart",newCarts);
				cookie.setMaxAge(3600);
				cookie.setPath("/");
				response.addCookie(cookie);
			}
			return "0";	
		} else {
			mapper.chgSu(id,num);
			return "0";
		}
	}

	@Override
	public String jjimList(HttpSession session, Model model) {
		if(session.getAttribute("userid")==null) {
			return "redirect:../login/login";
			
		} else {
			String userid = session.getAttribute("userid").toString();
			ArrayList<ProductDto> plist= mapper.jjimList(userid);
			model.addAttribute("plist",plist);
			return "member/jjimList";
		}	
	}

	@Override
	public String jjimDel(HttpSession session, HttpServletRequest request) {
		
		if (session.getAttribute("userid") == null) {
			return "redirect:../login/login";
		} else {
			String ids = request.getParameter("ids");
			String[] imsi = ids.split(",");
			for (int i = 0; i < imsi.length; i++) {
				mapper.jjimDel(imsi[i]);
			}
			return "redirect:/member/jjimList";
		}
	}

	@Override
	public String addCart(HttpSession session, HttpServletRequest request) {
		if(session.getAttribute("userid")==null) {
			return "redirect:../login/login";
		} else {
			String userid=session.getAttribute("userid").toString();
			String pcode = request.getParameter("pcode");
			mapper.addCart(userid,pcode);
			return "redirect:/member/jjimList";
		}
		
	}
	@Override
	public String addCart2(HttpSession session, HttpServletRequest request) {
		if(session.getAttribute("userid")==null) {
			return "-1"; // 장바구니 갯수가 될 수 없는 값으로 return한다.
		} else {
			String userid=session.getAttribute("userid").toString();
			String pcode = request.getParameter("pcode");
			if (mapper.isCart(userid,pcode)) {
				mapper.upCart(userid,pcode);
			} else {
				mapper.addCart(userid,pcode);
			}
			// return을 장바구니 갯수
			return mapper.getCartSu(userid);
		}
	}


	@Override
	public String chgState(HttpSession session, GumaeDto gdto) {
		if(session.getAttribute("userid")==null) {
			return "redirect:/login/login";
		} else {
			mapper.chgState(gdto);
			return "redirect:/member/jumunList";
		}
		
	}

	@Override
	public String review(ReviewDto rdto,Model model) {
		
		model.addAttribute("gid",rdto.getId());
		model.addAttribute("pcode",rdto.getPcode());
		return "/member/review";
	}

	@Override
	public String reviewOk(ReviewDto rdto, HttpSession session) {
		rdto.setUserid(session.getAttribute("userid").toString());
		mapper.reviewOk(rdto);
		
		// 지금 상품평을 추가한 구매내용에 상품평을 적었다는 것을 저장.
		mapper.chgReview(rdto.getId()); // 구매테이블의 id
		// 상품 당 별점의 평균... => product.star
		// 평균별점을 계산하어 product.star에 저장.
		// review.star 평균
		double avg = mapper.avgStar(rdto.getPcode());
		int reviewCount = mapper.getReviewCount(rdto.getPcode());
		mapper.chgStar(avg,reviewCount,rdto.getPcode());
		
		return "redirect:/member/jumunList";
	}

	@Override
	public String reviewDelete(HttpServletRequest request, HttpSession session) {
		if (session.getAttribute("userid")==null) {
			return "redirect:/login/login";
			
		} else {
			String id = request.getParameter("id");
			String pcode = request.getParameter("pcode");
			String gid = request.getParameter("gid");
			mapper.reviewDelete(id);
			
			// 상품평을 삭제
			// 1. 별점을 재계산, product.review => -1
			// 2. guamer.review => 0
			double avg = mapper.avgStar(pcode); // review가 한 개도 없을 경우에는 문제가 발생한다. 
			int reviewCount = mapper.getReviewCount(pcode);
			//mapper.chgReview2(id); // 필요한건 gumae테이블의 아이디
			mapper.chgStar(avg, reviewCount, pcode);
			mapper.chgReview2(gid);
			
			if(request.getParameter("chk")==null) {
				return "redirect:/product/productContent?pcode="+pcode;
			} else {
				return "redirect:/member/reviewList";
			}
		}
		
	}

	@Override
	public String reviewUpdate(HttpServletRequest request, HttpSession session, Model model) {
		if(session.getAttribute("userid")==null) {
			return "redirect:/login/login";
		} else {
			String id = request.getParameter("id");
			String pcode = request.getParameter("pcode");
			String chk = request.getParameter("chk");
			ReviewDto rdto = mapper.getReview(id);
			
			model.addAttribute("rdto",rdto);
			model.addAttribute("chk",chk);
			return "member/reviewUpdate";
		}
	}

	@Override
	public String reviewUpdateOk(ReviewDto rdto, HttpSession session,HttpServletRequest request) {
		if(session.getAttribute("userid")==null) {
			return "redirect:/login/login";
		} else {
			// 1. review 테이블 수정
			mapper.reviewUpdateOk(rdto);
			// 2. 해당 상품의 별점 평균 수정.
			double avg = mapper.avgStar(rdto.getPcode());
			int reviewCount = mapper.getReviewCount(rdto.getPcode());
			mapper.chgStar(avg,reviewCount,rdto.getPcode());
			
			if (request.getParameter("chk")==null) {
				return "redirect:/product/productContent?pcode="+rdto.getPcode();
			} else {
				return "redirect:/member/reviewList";
			}
			
		}
	}

	@Override
	public String memberInfo(HttpSession session, Model model) {
		if(session.getAttribute("userid")==null) {
			return "redirect:/login/login";
		}
			String userid=(String)session.getAttribute("userid");
			MemberDto mdto = mapper.memberInfo(userid);
			model.addAttribute("mdto",mdto);
			return "/member/memberInfo";
	}
	
	@Override
	public String chgEmail(HttpSession session, HttpServletRequest request) {
		if(session.getAttribute("userid")==null) {
			return "0";
		} else {
			String userid = (String)session.getAttribute("userid");
			String email = request.getParameter("email");
			mapper.chgEmail(userid,email);
			return "1";
		}
	}

	@Override
	public String chgPhone(HttpServletRequest request, HttpSession session) {
		if(session.getAttribute("userid")==null) {
			return "redirect:/login/login";
		} else {
			String userid = (String)session.getAttribute("userid");
			String phone = request.getParameter("phone");
			mapper.chgPhone(userid,phone);
			return "redirect:/member/memberInfo";
		}
	}

	@Override
	public String oldPwdChk(HttpServletRequest request, HttpSession session) {
		if(session.getAttribute("userid")==null) {
			return "0";
		} else {
			String userid = (String)session.getAttribute("userid");
			String oldPwd = request.getParameter("oldPwd");
			System.out.println(userid+" "+oldPwd);
			if(mapper.isPwd(userid,oldPwd)) {
				return "1";
			} else {
				return "2";
			}
		}
	}

	@Override
	public String chgPwd(HttpServletRequest request, HttpSession session) {
		if(session.getAttribute("userid")==null) {
			return "redirect:/login/login";
		} else {
			String userid = (String)session.getAttribute("userid");
			String oldPwd = request.getParameter("oldPwd");
			String nPwd = request.getParameter("nPwd");
			String err;
			if(mapper.isPwd(userid,oldPwd)) {
				mapper.chgPwd(userid, nPwd, oldPwd);
				err="1";
			} else {
				err="0";
			}
			return "redirect:/member/memberInfo?err="+err;
		}
	}

	@Override
	public String baesongList(HttpSession session, Model model) {
		String userid = (String)session.getAttribute("userid");
		ArrayList<BaesongDto> blist = mapper.baesongList(userid);
		
		String reqStr = null;
		for (int i=0; i<blist.size();i++) {	
			BaesongDto bdto = blist.get(i);
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
		
		return "member/baesongList";
	}

	@Override
	public String jumunList(HttpSession session, Model model, HttpServletRequest request) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String reviewList(HttpSession session, Model model) {
		if(session.getAttribute("userid")==null) {
			return "redirect:/login/login";
		} else {
			String userid = session.getAttribute("userid").toString();
			ArrayList<HashMap> mapAll = mapper.reviewList(userid);
			model.addAttribute("mapAll",mapAll);
			return "member/reviewList";
		}	
	}

	@Override
	public String qnaList(HttpSession session, Model model) {
		if (session.getAttribute("userid")==null) {
			return "redirect:/login/login";
		} else {
			String userid = session.getAttribute("userid").toString();
			ArrayList<HashMap> mapAll = mapper.qnaList(userid);
			model.addAttribute("mapAll",mapAll);
			return "member/qnaList";
		}
	}

	
	

}
