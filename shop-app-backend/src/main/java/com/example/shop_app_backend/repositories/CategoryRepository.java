package com.example.shop_app_backend.repositories;

import com.example.shop_app_backend.models.Category;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CategoryRepository extends JpaRepository<Category, Long> {
}
