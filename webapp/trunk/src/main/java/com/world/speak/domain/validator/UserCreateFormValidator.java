package com.world.speak.domain.validator;

import com.world.speak.domain.request.UserCreateRequest;
import com.world.speak.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

@Service
@Component
public class UserCreateFormValidator implements Validator {

    private static final Logger LOGGER = LoggerFactory.getLogger(UserCreateFormValidator.class);

    @Autowired
    private UserService userService;

    public UserCreateFormValidator(UserService userService) {
        this.userService = userService;
    }

    @Override
    public boolean supports(Class<?> clazz) {
        return clazz.equals(UserCreateRequest.class);
    }

    @Override
    public void validate(Object target, Errors errors) {
        LOGGER.debug("Validating {}", target);
        UserCreateRequest form = (UserCreateRequest) target;
        validateEmail(errors, form);
    }

    private void validateEmail(Errors errors, UserCreateRequest form) {
        if (userService.getUserByEmail(form.getValues().getEmail()) != null) {
            errors.reject("email.exists", "User with this email already exists");
        }
    }
}
