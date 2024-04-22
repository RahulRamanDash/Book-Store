package com.java.store;

import java.sql.Date;

public class Orders {	

	    private int orderId;
	    private int userId;
	    private Date orderDate;
	    private double totalAmount;
	    private String orderStatus;

	    public Orders() {
	        // Default constructor
	    }

		public Orders(int orderId, int userId, Date orderDate, double totalAmount, String orderStatus) {
			super();
			this.orderId = orderId;
			this.userId = userId;
			this.orderDate = orderDate;
			this.totalAmount = totalAmount;
			this.orderStatus = orderStatus;
		}

		@Override
		public String toString() {
			return "Order [orderId=" + orderId + ", userId=" + userId + ", orderDate=" + orderDate + ", totalAmount="
					+ totalAmount + ", orderStatus=" + orderStatus + "]";
		}

		public int getOrderId() {
			return orderId;
		}

		public void setOrderId(int orderId) {
			this.orderId = orderId;
		}

		public int getUserId() {
			return userId;
		}

		public void setUserId(int userId) {
			this.userId = userId;
		}

		public Date getOrderDate() {
			return orderDate;
		}

		public void setOrderDate(Date orderDate) {
			this.orderDate = orderDate;
		}

		public double getTotalAmount() {
			return totalAmount;
		}

		public void setTotalAmount(double totalAmount) {
			this.totalAmount = totalAmount;
		}

		public String getOrderStatus() {
			return orderStatus;
		}

		public void setOrderStatus(String orderStatus) {
			this.orderStatus = orderStatus;
		}

}
