package com.junasa.utils;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.*;
import java.io.InputStream;

public class EmailSender {
    public static void sendEmail(String to, String subject, String messageText) {
        try {
            Properties emailProps = new Properties();
            InputStream input = EmailSender.class.getClassLoader().getResourceAsStream("email.properties");

            if (input == null) {
                throw new RuntimeException("Cannot find email.properties file");
            }

            emailProps.load(input);

            String from = emailProps.getProperty("email.id");
            String password = emailProps.getProperty("email.password");

            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");

            Session session = Session.getInstance(props, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(from, password);
                }
            });

            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
            message.setSubject(subject);
            message.setText(messageText);

            Transport.send(message);
            System.out.println("Email sent successfully!");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
