package com.world.speak.web;

import com.world.speak.domain.User;
import com.world.speak.domain.request.UserCreateRequest;
import com.world.speak.domain.response.AdditionalResponseItem;
import com.world.speak.domain.response.AjaxResponseBody;
import com.world.speak.domain.response.ValueResponse;
import com.world.speak.domain.validator.UserCreateFormValidator;
import com.world.speak.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class UserController {

    private static final Logger LOGGER = LoggerFactory.getLogger(UserController.class);
    @Autowired
    private UserService userService;

    @Autowired
    private UserCreateFormValidator userCreateFormValidator;

    @InitBinder("form")
    public void initBinder(WebDataBinder binder) {
        binder.addValidators(userCreateFormValidator);
    }

    @PreAuthorize("@currentUserServiceImpl.canAccessUser(principal, #id)")
    @RequestMapping("/edit/{id}")
    public ModelAndView getUserPage(@PathVariable Long id) {
        LOGGER.debug("Getting user page for user={}", id);
        return new ModelAndView("edit", "edit", userService.getUserById(id));
    }

    @RequestMapping(value = "/getCreateResult", method = RequestMethod.POST)
    public AjaxResponseBody getCreateResult (@RequestBody UserCreateRequest form) {

        AjaxResponseBody result = new AjaxResponseBody();
        User user = new User();
        try {
            user = userService.create(form);
        } catch (DataIntegrityViolationException e) {
            LOGGER.warn("Exception occurred when trying to save the user, assuming duplicate email", e);
            return result;
        }
        AdditionalResponseItem additionalInfo = result.getAdditionalinfo();
        additionalInfo.setIdentifiableid(user.getId());
        additionalInfo.setTest(user);

        ValueResponse values = result.getValues();
        values.setEmail(form.getValues().getEmail());
        values.setPassword(form.getValues().getPassword());
        values.setRole(form.getValues().getRole());
        result.setAddedrow(true);
        return result;
    }
}