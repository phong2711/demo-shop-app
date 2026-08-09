package com.example.shop_app_backend.services;

import com.example.shop_app_backend.dtos.CategoryDTO;
import com.example.shop_app_backend.models.Category;

import java.util.List;

public interface ICategoryService {
    Category createCategory(CategoryDTO category);
    Category getCategoryById(long id);
    List<Category> getAllCategories();
    Category updateCategory(long categoryId, CategoryDTO category);
    void deleteCategory(long id);
}
