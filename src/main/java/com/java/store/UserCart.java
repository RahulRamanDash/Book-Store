package com.java.store;

public class UserCart {
	
	private int cartId;
	private int userId;
	private int bookId;
	private String itemName;
	private int quantity;
	private double price;
	
	public UserCart() {
		super();
		// TODO Auto-generated constructor stub
	}
	public UserCart(int cartId, int userId, int bookId, String itemName, int quantity, double price) {
		super();
		this.cartId = cartId;
		this.userId = userId;
		this.bookId = bookId;
		this.itemName = itemName;
		this.quantity = quantity;
		this.price = price;
	}
	@Override
	public String toString() {
		return "UserCart [cartId=" + cartId + ", userId=" + userId + ", bookId=" + bookId + ", itemName=" + itemName
				+ ", quantity=" + quantity + ", price=" + price + "]";
	}
	public int getCartId() {
		return cartId;
	}
	public void setCartId(int cartId) {
		this.cartId = cartId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getBookId() {
		return bookId;
	}
	public void setBookId(int bookId) {
		this.bookId = bookId;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}

}
