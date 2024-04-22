package com.java.store;

import java.util.List;

public interface UserCartDao {
	List<UserCart> viewCart(String userId);
	public void addToCart(int bookId);
	public void removeFromCart(int bookId);
	public UserCart searchCartByBookId(int bookId);
	
}
