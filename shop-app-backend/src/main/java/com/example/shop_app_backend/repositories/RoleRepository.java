package com.example.shop_app_backend.repositories;

import com.example.shop_app_backend.models.Role;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RoleRepository extends JpaRepository<Role, Long> {
}
