package com.example.shop_app_backend.services;

import com.example.shop_app_backend.dtos.OrderDetailDTO;
import com.example.shop_app_backend.exceptions.DataNotFoundException;
import com.example.shop_app_backend.models.OrderDetail;

import java.util.List;

public interface IOrderDetailService {
    OrderDetail createOrderDetail(OrderDetailDTO newOrderDetail) throws Exception;
    OrderDetail getOrderDetail(Long id) throws DataNotFoundException;
    OrderDetail updateOrderDetail(Long id, OrderDetailDTO newOrderDetailData)
            throws DataNotFoundException;
    void deleteById(Long id);
    List<OrderDetail> findByOrderId(Long orderId);
}