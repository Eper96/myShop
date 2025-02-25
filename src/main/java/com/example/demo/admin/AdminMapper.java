package com.example.demo.admin;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.dto.CompanyDto;
import com.example.demo.dto.DaeDto;
import com.example.demo.dto.GumaeDto;
import com.example.demo.dto.JungDto;
import com.example.demo.dto.ProductDto;
import com.example.demo.dto.QnaDto;
import com.example.demo.dto.SoDto;

@Mapper
public interface AdminMapper {
    public ArrayList<DaeDto> getDae();
    public ArrayList<JungDto> getJung(String dae);
    public ArrayList<SoDto> getSo(String daejung);
    public ArrayList<CompanyDto> getCompany();
	public int getNumber(String pcode);
	public void proWriteOk(ProductDto pdto);
	public ArrayList<HashMap> panmaeList();
	public void chgState(GumaeDto gdto);
	public ArrayList<QnaDto> qnaList();
	public void qnaAnswer(QnaDto qdto);
	public void setRef(int id);
}







