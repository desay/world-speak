package com.world.speak.web;

import com.world.speak.domain.User;
import com.world.speak.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class WSController {
	private static final Logger LOGGER = LoggerFactory.getLogger(WSController.class);

	@Autowired
	private UserService userService;

	@RequestMapping(value = {"getAllAppMenu", "/applicationMenuList"})
	public ModelAndView getAllAppMenu() {
		LOGGER.debug("Add menu and users to page");
		List<User> users = userService.getAllUsers();
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject(users);
		return modelAndView;
	}

	@RequestMapping("/")
	public ModelAndView getLoginPage() {
		ModelAndView modelAndView = new ModelAndView ("login");
		return modelAndView;
	}

}
