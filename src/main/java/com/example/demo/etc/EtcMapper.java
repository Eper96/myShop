package com.example.demo.etc;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface EtcMapper {

	public ArrayList<EtcDto> getHoliday(int year, String month);
	
}
