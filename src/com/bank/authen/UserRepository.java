package com.bank.authen;


public interface UserRepository {
 
    public User findByEmail(String email);
}