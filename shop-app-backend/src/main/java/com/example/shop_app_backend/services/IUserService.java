package com.example.shop_app_backend.services;

import com.example.shop_app_backend.dtos.UserDTO;
import com.example.shop_app_backend.exceptions.DataNotFoundException;
import com.example.shop_app_backend.models.User;

public interface IUserService {
    User createUser(UserDTO userDTO) throws DataNotFoundException;
    String login(String phoneNumber, String password);
}
