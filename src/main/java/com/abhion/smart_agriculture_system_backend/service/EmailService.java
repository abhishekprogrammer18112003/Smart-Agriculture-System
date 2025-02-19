package com.abhion.smart_agriculture_system_backend.service;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {
    private final JavaMailSender mailSender;

    public EmailService(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }

    public void sendOtpEmail(String email, int otp) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(email);
        message.setSubject("Your OTP for Verification");
        message.setText("Hi User, Welcome to FYP - Smart Agriculture System\n\nYour One-Time Password (OTP) is: " + otp + "\n\nThis OTP is valid for 5 minutes. ");
        mailSender.send(message);
    }
}

