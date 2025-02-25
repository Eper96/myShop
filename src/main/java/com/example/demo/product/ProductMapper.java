package com.example.demo.product;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.dto.BaesongDto;
import com.example.demo.dto.CartDto;
import com.example.demo.dto.GumaeDto;
import com.example.demo.dto.ProductDto;
import com.example.demo.dto.QnaDto;
import com.example.demo.dto.ReviewDto;
import com.example.demo.member.MemberDto;

@Mapper
public interface ProductMapper {
	public ArrayList<ProductDto> productList(String orderStr,int index,String pcode);

	public int getTotalPg(String pcode);

	public String getDae(String code);

	public String getJung(String dae, String jung);

	public String getSo(String daejung, String so);

	public ProductDto productContent(String pcode);

	public void jjimOk(String pcode, String userid);

	public int isJjim(String userid, String pcode);

	public void jjimDelete(String userid, String pcode);

	public void addCart(CartDto cdto);
	
	public Boolean isCart(CartDto cdto);
	
	public void upCart(CartDto cdto);

	public MemberDto getMember(String userid);

	public BaesongDto getBaesong(String userid);

	public void baesongWriteOk(BaesongDto bdto);

	public ArrayList<BaesongDto> baesongList(String userid);

	public void setZero(String userid);

	public int isBaesong(String attribute);

	public int getNumber(String jumuncode);

	public void gumaeOk(GumaeDto gdto);
	
	public void cartDel(String userid, String pcode);

	public void useJuk(int useJuk, String userid);

	public ArrayList<GumaeDto> getGumae(String jumuncode);

	
	public BaesongDto getBaesong2(String id);

	public ArrayList<ReviewDto> getReview(String pcode);

	public void qnaWriteOk(QnaDto qdto);

	public ArrayList<QnaDto> getQna(String pcode);

	public void qnaDelete(int id);
	
    public void baesongDelete(String id);

    public void baesongUpdateOk(BaesongDto bdto);

	//public String getLabeledUserid(String userid);
	
}
