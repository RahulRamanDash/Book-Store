package com.java.store;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

public class UserCartDaoImpl implements UserCartDao{

	SessionFactory sf;
	Session session;
	BooksDao bookImpl = new BooksDaoImpl();
	
	@Override
	public List<UserCart> viewCart(String userIdStr) {
		int userId = Integer.parseInt(userIdStr);
		sf = SessionHelper.getConnection();
		session = sf.openSession();
		Criteria criteria = session.createCriteria(UserCart.class);
		criteria.add(Restrictions.eq("userId", userId));
		List<UserCart> cartItems =  criteria.list();
		return cartItems;
	}
	
	public List<Books> viewCartItems() {
		Map<String, Object> sessionValue = FacesContext.getCurrentInstance().getExternalContext().getSessionMap();
		int userId = 0;
		if(sessionValue.get("userId")!=null) {			
			userId = (int) sessionValue.get("userId");
		}else {
			redirectToLogin();
		}
		sf = SessionHelper.getConnection();
		session = sf.openSession();
		Criteria criteria = session.createCriteria(UserCart.class);
		criteria.add(Restrictions.eq("userId", userId));
		List<UserCart> cartItems =  criteria.list();
		
		List<Books> bookList = new ArrayList<>();
		for(UserCart cart : cartItems) {
			Books bookFound	= bookImpl.searchBooks(cart.getBookId());
			bookList.add(bookFound);
		}	
		return bookList;
	}
	
	public int calculateCartValue() {
		Map<String, Object> sessionValue = FacesContext.getCurrentInstance().getExternalContext().getSessionMap();
		int userId = 0;
		if(sessionValue.get("userId")!=null) {			
			userId = (int) sessionValue.get("userId");
		}else {
			redirectToLogin();
		}
		sf = SessionHelper.getConnection();
		session = sf.openSession();
		Criteria criteria = session.createCriteria(UserCart.class);
		criteria.add(Restrictions.eq("userId", userId));
		List<UserCart> cartItems =  criteria.list();
		int cartItemCount = cartItems.size();
		sessionValue.put("cartItemCount", cartItemCount);
		double cartValue = 0;
		for(UserCart item : cartItems) {
			cartValue = cartValue+item.getPrice();
		}
		System.out.println("cartValue "+cartValue);
		sessionValue.put("cartValue", cartValue);
		
		return cartItemCount;
	}

	@Override
	public void addToCart(int bookId) {
		Map<String, Object> sessionValue = FacesContext.getCurrentInstance().getExternalContext().getSessionMap();
		FacesContext context = FacesContext.getCurrentInstance();
		// String userIdStr = (String) sessionValue.get("userId");
		// int userId = Integer.parseInt(userIdStr);
		int userId = (int) sessionValue.get("userId");
		
		Books book = bookImpl.searchBooks(bookId);
		UserCart cartFound = searchCartByBookId(bookId);
		if(cartFound==null) {
			sf = SessionHelper.getConnection();
			session = sf.openSession();
			Transaction transaction = session.beginTransaction();
			UserCart cart = new UserCart();
			
			cart.setBookId(bookId);
			cart.setItemName(book.getBookName());
			cart.setPrice(book.getPrice());
			cart.setQuantity(1);
			cart.setUserId(userId);
			session.save(cart);
			transaction.commit();
			System.out.println("Item Added to cart successfully....");
			context.addMessage("manageMsg", new FacesMessage("Item Added to cart successfully...."));
		}else {
			System.out.println("Item is Already in the cart...");
			context.addMessage("manageMsg", new FacesMessage("Item is Already in the cart..."));
		}
		
	}

	@Override
	public void removeFromCart(int bookId) {
		UserCart cartFound = searchCartByBookId(bookId);
		if(cartFound!=null) {
			sf = SessionHelper.getConnection();
			session = sf.openSession();
			Transaction transaction = session.beginTransaction();
			session.delete(cartFound);
			transaction.commit();
			System.out.println("Data Deleated From Employ Table");
		}else {
			System.out.println("Data Not Found");
		}
		
	}

	@Override
	public UserCart searchCartByBookId(int bookId) {
		sf = SessionHelper.getConnection();
		session = sf.openSession();
		Criteria criteria = session.createCriteria(UserCart.class);
		criteria.add(Restrictions.eq("bookId", bookId));
		return (UserCart) criteria.uniqueResult();
	}
	
	public String redirectToLogin() {
		return "ViewBooks.jsp?faces-redirect=true";
	}

}
