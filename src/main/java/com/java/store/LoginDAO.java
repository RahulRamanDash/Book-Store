package com.java.store;

public interface LoginDAO {
	String addUser(Users user);
	String authenticate(Users user);
}
