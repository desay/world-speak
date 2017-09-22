package com.world.speak.service;

import com.world.speak.domain.CurrentUser;
import com.world.speak.domain.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

@Service
@Component
public class CurrentUserDetailsService implements UserDetailsService {

    private static final Logger LOGGER = LoggerFactory.getLogger(CurrentUserDetailsService.class);

    @Autowired
    private UserService userService;

    public CurrentUserDetailsService(UserService userService) {
        this.userService = userService;
    }

    @Override
    public CurrentUser loadUserByUsername(String email) throws UsernameNotFoundException {
        LOGGER.debug("Authenticating user with email={}", email.replaceFirst("@.*", "@***"));
        User user = userService.getUserByEmail(email);
        return new CurrentUser(user);
    }

}
