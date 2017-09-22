package com.world.speak;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Configuration
@Service
@Transactional
@SpringBootApplication
@EnableJpaRepositories(
		basePackages = {
				"com.world.speak.repository"
		}
)
@EntityScan(
		basePackages = {
				"com.world.speak.domain"
		}
)
public class WSApplication {

	public static void main(String[] args) throws Exception {
		SpringApplication.run(WSApplication.class, args);
	}

}
