package com.java.store;

import java.util.List;
import java.util.Map;

import javax.faces.application.FacesMessage;
import javax.faces.context.ExternalContext;
import javax.faces.context.FacesContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

public class LoginDaoImpl implements LoginDAO{

	SessionFactory sf;
	Session session;
	
	@Override
	public String addUser(Users user) {
		sf = SessionHelper.getConnection();
		session = sf.openSession();
		Transaction transaction = session.beginTransaction();
		session.save(user);
		transaction.commit();
		session.close();
		sf.close();
		return "User Added....";
	}
	public Users searchUser(String userName) {
		Map<String, Object> sessionValue = FacesContext.getCurrentInstance().getExternalContext().getSessionMap();
		FacesContext context = FacesContext.getCurrentInstance();
		sf = SessionHelper.getConnection();
		session = sf.openSession();
		Criteria criteria = session.createCriteria(Users.class);
		criteria.add(Restrictions.eq("username", userName));		
		return (Users) criteria.uniqueResult();
	}
	public List<Users> showUsersForAdmin() {
		sf = SessionHelper.getConnection();
		session = sf.openSession();
		Criteria criteria = session.createCriteria(Users.class);
		return criteria.list();
	}
	
	  public void addCookie(String name, String value, int maxAge) {
	        ExternalContext externalContext = FacesContext.getCurrentInstance().getExternalContext();
	        HttpServletResponse response = (HttpServletResponse) externalContext.getResponse();
	        Cookie cookie = new Cookie(name, value);
	        cookie.setMaxAge(maxAge);
	        response.addCookie(cookie);
	    }
	
	@Override 
	public String authenticate(Users user) {
		Map<String, Object> sessionValue = FacesContext.getCurrentInstance().getExternalContext().getSessionMap();
		FacesContext context = FacesContext.getCurrentInstance();
		Cookie cookie;
		sf = SessionHelper.getConnection();
		session = sf.openSession();
		Criteria criteria = session.createCriteria(Users.class);
		criteria.add(Restrictions.eq("username", user.getUsername()));
		criteria.add(Restrictions.eq("password", user.getPassword()));
		
		criteria.setProjection(Projections.rowCount());
		long userCount = (long)criteria.uniqueResult();
		session.close();
		sf.close();
		if(userCount==1) {
			Users loggedUser = searchUser(user.getUsername());
			sessionValue.put("loggedUser", loggedUser);
			sessionValue.put("userId", loggedUser.getId());
			addCookie("username", user.getUsername(), 1800);
			return "ViewBooks.jsp?faces-redirect=true";
		}else {
			context.addMessage("form:login", new FacesMessage("Invalid UserName or Password!"));
			return "";
		}
	}
	
	public String authenticateAdmin(Users user) {
		Map<String, Object> sessionValue = FacesContext.getCurrentInstance().getExternalContext().getSessionMap();
		FacesContext context = FacesContext.getCurrentInstance();
		Cookie cookie;
		sf = SessionHelper.getConnection();
		session = sf.openSession();
		Criteria criteria = session.createCriteria(Admin.class);
		criteria.add(Restrictions.eq("username", user.getUsername()));
		criteria.add(Restrictions.eq("password", user.getPassword()));
		
		criteria.setProjection(Projections.rowCount());
		long adminCount = (long)criteria.uniqueResult();
		session.close();
		sf.close();
		
		if(adminCount==1) {
			addCookie("admin", user.getUsername(), 1800);
			sessionValue.put("adminId", "1");
			return "admin/AdminDashboard.jsp?faces-redirect=true";
		}else {
			context.addMessage("form:login", new FacesMessage("Invalid UserName or Password!"));
			return "";
		}
	}
	
	public String logout() {
		Map<String, Object> sessionValue = FacesContext.getCurrentInstance().getExternalContext().getSessionMap();
		sessionValue.clear();
		addCookie("username", "", 0);
		return "Login.jsp?faces-redirect=true";
	}

	
}
