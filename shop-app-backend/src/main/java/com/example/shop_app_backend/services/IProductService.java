package com.example.shop_app_backend.services;

import com.example.shop_app_backend.dtos.ProductDTO;
import com.example.shop_app_backend.dtos.ProductImageDTO;
import com.example.shop_app_backend.models.Product;
import com.example.shop_app_backend.models.ProductImage;
import com.example.shop_app_backend.responses.ProductResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

public interface IProductService {
    Product createProduct(ProductDTO productDTO) throws Exception;
    Product getProductById(long id) throws Exception;
    Page<ProductResponse> getAllProducts(PageRequest pageRequest);
    Product updateProduct(long id, ProductDTO productDTO) throws Exception;
    void deleteProduct(long id);
    boolean existsByName(String name);
    ProductImage createProductImage(
            Long productId,
            ProductImageDTO productImageDTO) throws Exception;

}
