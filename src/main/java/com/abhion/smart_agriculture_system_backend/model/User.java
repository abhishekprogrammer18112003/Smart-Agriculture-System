package com.abhion.smart_agriculture_system_backend.model;

import lombok.Data;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "users")
public class User {

    @Id
    private String apiKey;
    private String userName;
    private String email;
    private String password;
    private String jwtToken;
    private LocalDateTime dateTimestamp;
}
