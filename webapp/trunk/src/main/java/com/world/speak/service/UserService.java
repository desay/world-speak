package com.world.speak.service;

import com.world.speak.domain.User;
import com.world.speak.domain.request.UserCreateRequest;
import com.world.speak.repository.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Component
public class UserService {
    private static final Logger LOGGER = LoggerFactory.getLogger(UserService.class);

    @Autowired
    private UserRepository userRepository;

    public UserService (UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public User getUserById(long id) {
        LOGGER.debug("Getting user={}", id);
        return userRepository.findOne(id);
    }

    public User getUserByEmail(String email) {
        LOGGER.debug("Getting user by email={}", email.replaceFirst("@.*", "@***"));
        return userRepository.findOneByEmail(email);
    }

    public List<User> getAllUsers() {
        LOGGER.debug("Getting all users");
        return userRepository.findAll(new Sort("email"));
    }

    public User create(UserCreateRequest form) {
        User user = new User();
        user.setEmail(form.getValues().getEmail());
        user.setPasswordHash(new BCryptPasswordEncoder().encode(form.getValues().getPassword()));
        user.setRole(form.getValues().getRole());
        return userRepository.save(user);
    }

    public User update (UserCreateRequest form) {
        User userForId = getUserByEmail(form.getValues().getEmail());
        User user = userRepository.update(form.getValues().getEmail(), form.getValues().getPassword(), form.getValues().getRole().toString(), userForId.getId());
        return user;
    }
}

