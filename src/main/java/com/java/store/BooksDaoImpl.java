package com.java.store;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import javax.servlet.http.Part;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

public class BooksDaoImpl implements BooksDao{

	SessionFactory sf;
	Session session;
	
	public int generateStockId() {
		sf = SessionHelper.getConnection();
		session = sf.openSession();
		Criteria cr = session.createCriteria(Books.class);
		cr.setProjection(Projections.max("bookId"));
		if (cr.uniqueResult() == null) {
			return 1;
		} else {
			return (int)cr.uniqueResult()+1;
		}
	}
	
	@Override
	public List<Books> viewBooks() {
		sf = SessionHelper.getConnection();
		session = sf.openSession();
		Criteria criteria = session.createCriteria(Books.class);
		return criteria.list();
	}

	public String redirectToEditStock(int bookId) {
		Map<String, Object> sessionValue = FacesContext.getCurrentInstance().getExternalContext().getSessionMap();
		sf = SessionHelper.getConnection();
		session = sf.openSession();
		Criteria criteria = session.createCriteria(Books.class);
		criteria.add(Restrictions.eq("bookId", bookId));
		Books bookFound	= (Books) criteria.uniqueResult();
		sessionValue.put("bookFromStock", bookFound);
		session.close();
		sf.close();
		return "EditStock.jsp?faces-redirect=true";
	}
	
	public Books searchBooksForAdmin(int bookId) {
		sf = SessionHelper.getConnection();
		session = sf.openSession();
		Criteria criteria = session.createCriteria(Books.class);
		criteria.add(Restrictions.eq("bookId", bookId));
		Books bookFound	= (Books) criteria.uniqueResult();
		session.close();
		sf.close();
		return bookFound;
	}
	
	public String AddBookDetail(Books book, Part file) throws IOException {
		Map<String, Object> sessionValue = FacesContext.getCurrentInstance().getExternalContext().getSessionMap();
		FileUploadBean bean = new FileUploadBean();
		bean.upload(file);
		
		String path = (String) sessionValue.get("imgPath");
		book.setBookUrl(path);
		book.setBookId(generateStockId());
		
		sf = SessionHelper.getConnection();
		session = sf.openSession();
		Transaction transaction = session.beginTransaction();
		session.save(book);
		transaction.commit();
		
		
		
		return "ViewBooks.jsp?faces-redirect=true";		
	}
	
	public String updateBookDetail(Books book) throws IOException {
		sf = SessionHelper.getConnection();
		session = sf.openSession();
		Transaction transaction = session.beginTransaction();
		session.update(book);
		transaction.commit();
		return "ViewBooks.jsp?faces-redirect=true";		
	}
	
	@Override
	public Books searchBooks(int bookId) {
		Map<String, Object> sessionValue = FacesContext.getCurrentInstance().getExternalContext().getSessionMap();
		sf = SessionHelper.getConnection();
		session = sf.openSession();
		Criteria criteria = session.createCriteria(Books.class);
		criteria.add(Restrictions.eq("bookId", bookId));
		Books bookFound	= (Books) criteria.uniqueResult();
		session.close();
		sf.close();
		sessionValue.put("bookOrdered", bookFound);
		return bookFound;
	}
	
	public String showBookDetail(int bookId) {
		Map<String, Object> sessionValue = FacesContext.getCurrentInstance().getExternalContext().getSessionMap();
		sf = SessionHelper.getConnection();
		session = sf.openSession();
		Criteria criteria = session.createCriteria(Books.class);
		criteria.add(Restrictions.eq("bookId", bookId));
		Books bookFound	= (Books) criteria.uniqueResult();
		sessionValue.put("bookFound", bookFound);
		return "BookDetails.jsp?faces-redirect=true";
	}

	public String buyOneBook(int bookId) {
		Map<String, Object> sessionValue = FacesContext.getCurrentInstance().getExternalContext().getSessionMap();
		Books bookFound	= searchBooks(bookId);
		double totalPrice = bookFound.getPrice();
		
		List<Books> bookList = new ArrayList<>();
		bookList.add(bookFound);
		
		sessionValue.put("totalPrice", totalPrice);
		sessionValue.put("bookFound", bookList);
		return "checkout.jsp?faces-redirect=true";
	}
	
	public List<UserCart> viewCart(int userId) {
		sf = SessionHelper.getConnection();
		session = sf.openSession();
		Criteria criteria = session.createCriteria(UserCart.class);
		criteria.add(Restrictions.eq("userId", userId));
		List<UserCart> cartItems =  criteria.list();
		return cartItems;
	}
	
	public String buyFromCart() {
		Map<String, Object> sessionValue = FacesContext.getCurrentInstance().getExternalContext().getSessionMap();
		
		// String userIdStr = (String) sessionValue.get("userId");
		int userId = (int) sessionValue.get("userId");
		
		List<UserCart> cartItems = viewCart(userId);
		double totalPrice = 0;
		
		List<Books> bookList = new ArrayList<>();
		for(UserCart cart : cartItems) {
			Books bookFound	= searchBooks(cart.getBookId());
			totalPrice = totalPrice + cart.getPrice();
			bookList.add(bookFound);
		}
		sessionValue.put("totalPrice", totalPrice);
		sessionValue.put("bookFound", bookList);
		return "checkout.jsp?faces-redirect=true";
	}
	
//	public Books searchBooks(int bookId) {
//		sf = SessionHelper.getConnection();
//		session = sf.openSession();
//		Criteria criteria = session.createCriteria(Books.class);
//		criteria.add(Restrictions.eq("bookId", bookId));
//		Books bookFound	= (Books) criteria.uniqueResult();
//		return bookFound;
//	}
	
}
