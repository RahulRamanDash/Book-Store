package com.java.store;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * Servlet implementation class BookStoreServlet
 */
public class BookStoreServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BookStoreServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		String action = request.getParameter("action");
	        if(request.getParameter("action")!=null) {   	
		        if ("viewbooks".equals(action.toLowerCase())) {
		            viewBooks(request, response);
		        } else if ("searchbook".equals(action.toLowerCase())) {
		        	if(request.getParameter("bookId")!=null && request.getParameter("bookId").length() > 0) {
		        		String bookId = request.getParameter("bookId");
		        		searchBook(request, response, bookId);		        		
		        	}else {
		        		out.println("Enter bookId");
		        	}
		        } else if ("updateStock".equals(action.toLowerCase())) {
		        	if(request.getParameter("bookId")!=null && request.getParameter("bookId").length() > 0) {
		        		String bookId = request.getParameter("bookId");
		        		updateStock(request, response, bookId);		        		
		        	}else {
		        		out.println("Enter bookId");
		        	}
		        } else {
		            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
		            out.println("Unknown action: " + action);
		        }
	        }else {
	        	out.println("Book Store Api");
	        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	// All methods to call impl
	
	private void viewBooks(HttpServletRequest request, HttpServletResponse response) throws IOException {
		PrintWriter out = response.getWriter();
		BooksDaoImpl booksImpl = new BooksDaoImpl();
		List<Books> books = booksImpl.viewBooks();
		System.out.println(books);
		ObjectMapper mapper = new ObjectMapper();
		mapper.setDateFormat(new SimpleDateFormat("yyyy-MM-dd"));
		String json = mapper.writeValueAsString(books);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		out.println(json);
		// response.getWriter().write(json);
    }

    private void searchBook(HttpServletRequest request, HttpServletResponse response, String bookIdStr) throws IOException {
    	PrintWriter out = response.getWriter();
    	int bookId = Integer.parseInt(bookIdStr);
		BooksDaoImpl booksImpl = new BooksDaoImpl();
		Books book = booksImpl.searchBooksForAdmin(bookId);
		System.out.println(book);
		ObjectMapper mapper = new ObjectMapper();
		mapper.setDateFormat(new SimpleDateFormat("yyyy-MM-dd"));
		String json = mapper.writeValueAsString(book);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		out.println(json);
    }

    private void updateStock(HttpServletRequest request, HttpServletResponse response, String bookId) throws IOException {
    	PrintWriter out = response.getWriter();
    	Books book = new Books();
		book.setBookId(0);
		book.setBookName(null);
		book.setGenre(null);
		book.setAuthorName(null);
		book.setBookUrl(null);
		book.setPrice(0);
		book.setPublishedDate(null);
		book.setDescription(null);
    	
		BooksDaoImpl booksImpl = new BooksDaoImpl();
		booksImpl.updateBookDetail(book);
    }


}
