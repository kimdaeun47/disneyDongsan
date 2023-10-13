package com.disney;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {
	private String connectPath = "/dongsanStorage/**";
	
	private String resourcePath = "file:///C:\\dongsanStorage\\";
	
	@Override
	public void addResourceHandlers (ResourceHandlerRegistry registry) {
		registry.addResourceHandler(connectPath)
				.addResourceLocations(resourcePath);
	}

}
