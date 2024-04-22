package com.java.store;

import java.util.List;

public class StoreController {
	
	private Books books;
	private BooksDaoImpl booksImpl;

	
	
	// Getters And Setters
	
	/*
	 * public Books getBooks() { return books; } public void setBooks(Books books) {
	 * this.books = books; } public BooksDaoImpl getBooksImpl() { return booksImpl;
	 * } public void setBooksImpl(BooksDaoImpl booksImpl) { this.booksImpl =
	 * booksImpl; }
	 */
	
	// All the Methods
	
	public List<Books> viewBooksCont(){
		return booksImpl.viewBooks();
	}
	
}
