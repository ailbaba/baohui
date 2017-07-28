package com.srm.online;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.netflix.loadbalancer.IRule;
import com.netflix.loadbalancer.RandomRule;

@Configuration
@ExcludeFromComponentScan
public class RibbonConfiguration {
	@Bean
	public IRule ribbonRule() {
		return new RandomRule();
	}
}
