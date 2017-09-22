package com.world.speak.service;

import com.world.speak.domain.CurrentUser;
import com.world.speak.domain.Role;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

@Service
@Component
public class CurrentUserService {
    private static final Logger LOGGER = LoggerFactory.getLogger(CurrentUserDetailsService.class);

    public boolean canAccessUser(CurrentUser currentUser, Long userId) {
        LOGGER.debug("Checking if user={} has access to user={}", currentUser, userId);
        return currentUser != null
                && (currentUser.getRole() == Role.ADMIN || currentUser.getId().equals(userId));
    }
}
