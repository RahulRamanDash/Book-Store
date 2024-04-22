package com.java.store;

import java.util.*;

public interface BooksDao {
	public List<Books> viewBooks();
	public Books searchBooks(int bookId);
}
