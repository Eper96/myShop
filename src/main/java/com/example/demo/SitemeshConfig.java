package com.example.demo;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

public class SitemeshConfig extends ConfigurableSiteMeshFilter{

	@Override
	protected void applyCustomConfiguration(SiteMeshFilterBuilder builder)
	{
	 
        builder.addDecoratorPath("*", "/default.jsp");
		
	 	
	// 제외할 폴더와 문서
	builder.addExcludedPath("/main/slide");
	
	builder.addExcludedPath("/etc/*");
	
	// 관리자 제외
	builder.addExcludedPath("/admin/*");
	
	// 배송 관련 제외
	builder.addExcludedPath("/product/baesong*");
        // test의 경로에 있는 문서들은 default가 포함되지 않는다. 
	builder.addExcludedPath("/member/baesongWrite");
	builder.addExcludedPath("/javascript/*");
	}
}

