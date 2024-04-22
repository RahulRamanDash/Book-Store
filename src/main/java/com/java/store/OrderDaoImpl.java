package com.java.store;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

public class OrderDaoImpl implements OrderDao{

	SessionFactory sf;
	Session session;
	BooksDao bookImpl = new BooksDaoImpl();
	
	public int generateOrderId() {
		sf = SessionHelper.getConnection();
		session = sf.openSession();
		Criteria cr = session.createCriteria(Orders.class);
		cr.setProjection(Projections.max("orderId"));
		if (cr.uniqueResult() == null) {
			return 1;
		} else {
			return (int)cr.uniqueResult()+1;
		}
	}
	
	public List<Orders> showOrder() {
		Map<String, Object> sessionValue = FacesContext.getCurrentInstance().getExternalContext().getSessionMap();
		// String userIdStr = (String) sessionValue.get("userId");
		// int userId = Integer.parseInt(userIdStr);
		int userId = (int) sessionValue.get("userId");
		
		sf = SessionHelper.getConnection();
		session = sf.openSession();
		Criteria cr = session.createCriteria(Orders.class);
		cr.add(Restrictions.eq("userId", userId));
		List<Orders> orders = cr.list();
		session.close();
		return orders;
	}

	public Orders searchOrderForAdmin(int orderId) {
		sf = SessionHelper.getConnection();
		session = sf.openSession();
		Criteria cr = session.createCriteria(Orders.class);
		cr.add(Restrictions.eq("orderId", orderId));
		Orders order = (Orders) cr.uniqueResult();
		session.close();
		return order;
	}
	public Orders searchOrder(int orderId) {
		Map<String, Object> sessionValue = FacesContext.getCurrentInstance().getExternalContext().getSessionMap();
		// String userIdStr = (String) sessionValue.get("userId");
		// int userId = Integer.parseInt(userIdStr);
		int userId = (int) sessionValue.get("userId");
		
		sf = SessionHelper.getConnection();
		session = sf.openSession();
		Criteria cr = session.createCriteria(Orders.class);
		cr.add(Restrictions.eq("userId", userId));
		cr.add(Restrictions.eq("orderId", orderId));
		Orders order = (Orders) cr.uniqueResult();
		session.close();
		sessionValue.put("orderedFound", order);
		return order;
	}
	
	public List<OrderItems> showOrderItemsForAdmin() {
		sf = SessionHelper.getConnection();
		session = sf.openSession();
		Criteria cr = session.createCriteria(Orders.class);
		cr.addOrder(Order.desc("orderId"));
		List<Orders> orders = cr.list();
		session.close();
		// Get order items
		
		List<OrderItems> allItems = new ArrayList<>();
		
		for (Orders order : orders) {
			session = sf.openSession();
			cr = session.createCriteria(OrderItems.class);
			cr.add(Restrictions.eq("orderId", order.getOrderId()));
			List<OrderItems> items = cr.list();
			allItems.addAll(items);
			session.close();
		}
		return allItems;
	}
	
	public List<OrderItems> showOrderItems() {
		Map<String, Object> sessionValue = FacesContext.getCurrentInstance().getExternalContext().getSessionMap();
		//String userIdStr = (String) sessionValue.get("userId");
		//int userId = Integer.parseInt(userIdStr);
		int userId = (int) sessionValue.get("userId");
		sf = SessionHelper.getConnection();
		session = sf.openSession();
		Criteria cr = session.createCriteria(Orders.class);
		cr.add(Restrictions.eq("userId", userId));
		cr.addOrder(Order.desc("orderId"));
		List<Orders> orders = cr.list();
		session.close();
		// Get order items
		
		List<OrderItems> allItems = new ArrayList<>();
		
		for (Orders order : orders) {
			session = sf.openSession();
			cr = session.createCriteria(OrderItems.class);
			cr.add(Restrictions.eq("orderId", order.getOrderId()));
			List<OrderItems> items = cr.list();
			allItems.addAll(items);
			session.close();
		}
		
		
		/*
		 * List<Books> bookList = new ArrayList<>(); for(OrderItems item : allItems) {
		 * Books bookFound = bookImpl.searchBooks(item.getBookId());
		 * bookList.add(bookFound); }
		 */
		
		return allItems;
	}
	
	@Override
	public String placeOrder(List<Books> bookList) {
		Map<String, Object> sessionValue = FacesContext.getCurrentInstance().getExternalContext().getSessionMap();
		FacesContext context = FacesContext.getCurrentInstance();
		
		java.util.Date utilDate = new java.util.Date();
		Date currentDate = new Date(utilDate.getTime());
		int orderId = generateOrderId();
		// String userIdStr = (String) sessionValue.get("userId");
		// int userId = Integer.parseInt(userIdStr);
		int userId = (int) sessionValue.get("userId");
		double totalPrice = (double) sessionValue.get("totalPrice");

		Orders order = new Orders();
		sf = SessionHelper.getConnection();
		session = sf.openSession();
		Transaction transaction = session.beginTransaction();
			
			order.setOrderId(orderId);
			order.setUserId(userId);
			order.setTotalAmount(totalPrice);
			order.setOrderStatus("Pending");
			order.setOrderDate(currentDate);

		session.save(order);
		transaction.commit();
		List<Orders> orders = showOrder();
		
		
		OrderItems item = new OrderItems();
		for(Books book : bookList) {
			Session session1 = sf.openSession();
			Transaction trans1 = session1.beginTransaction();
			
			item.setOrderId(orderId);
			item.setBookId(book.getBookId());
			item.setPrice(book.getPrice());
			item.setQuantity(1);
			
			session1.save(item);
			trans1.commit();
			session1.close();
			System.out.println("menu item for order Success "+ item);
		}
		sessionValue.put("orderMsg", "Order Placed Successfully");
		context.addMessage("successMsg", new FacesMessage("Order Placed"));
		return "ViewBooks.jsp?faces-redirect=true";
	}
}
