package com.world.speak.repository;

import com.world.speak.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface UserRepository extends JpaRepository<User, Long> {
    User findOneByEmail(String email);

    @Query("update User ur set ur.email= :email, ur.passwordHash= :passwordHash, ur.role= :role where ur.id= :id")
    User update (@Param("email") String email, @Param("passwordHash") String passwordHash, @Param("role") String role, @Param("id") Long id );
}
