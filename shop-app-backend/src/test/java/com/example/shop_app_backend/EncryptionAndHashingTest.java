package com.example.shop_app_backend;

import io.jsonwebtoken.io.Encoders;
import jakarta.xml.bind.DatatypeConverter;
import org.junit.jupiter.api.Test;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

public class EncryptionAndHashingTest {
    @Test
    void hash() throws NoSuchAlgorithmException {
        String password = "123456";

        MessageDigest md = MessageDigest.getInstance("MD5");

        md.update(password.getBytes());
        byte[] digest = md.digest();
        String md5Hash = DatatypeConverter.printHexBinary(digest);
        System.out.println("MD5 round 1: {}" + md5Hash);

        md.update(password.getBytes());
        digest = md.digest();
        md5Hash = DatatypeConverter.printHexBinary(digest);
        System.out.println("MD5 round 2: {}" + md5Hash);

        PasswordEncoder passwordEncoder = new BCryptPasswordEncoder(10);
        System.out.println("BCrypt round 1: {}" + passwordEncoder.encode(password));
        System.out.println("BCrypt round 2: {}" + passwordEncoder.encode(password));
    }

    @Test
    void generateSecretKey() {
        SecureRandom random = new SecureRandom();
        byte[] keyBytes = new byte[32]; // 256-bit key
        random.nextBytes(keyBytes);
        String secretKey = Encoders.BASE64.encode(keyBytes);
        System.out.println("secretKey: " + secretKey);
    }
}
