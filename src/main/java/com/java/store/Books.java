package com.java.store;

import java.util.Date;

/*
BookID INT AUTO_INCREMENT PRIMARY KEY,
BookName VARCHAR(255),
AuthorName INT,
Price DECIMAL(10, 2),
PublishedDate DATE,
BookURL VARCHAR(255)
*/
public class Books {
	
	private int bookId;
	private String bookName;
	private String authorName;
	private double price;
	private Date PublishedDate;
	private String bookUrl;
	private String description;
	private String genre;
	
	public Books() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	public Books(int bookId, String bookName, String authorName, double price, Date publishedDate, String bookUrl,
			String description, String genre) {
		super();
		this.bookId = bookId;
		this.bookName = bookName;
		this.authorName = authorName;
		this.price = price;
		PublishedDate = publishedDate;
		this.bookUrl = bookUrl;
		this.description = description;
		this.genre = genre;
	}


	@Override
	public String toString() {
		return "Books [bookId=" + bookId + ", bookName=" + bookName + ", authorName=" + authorName + ", price=" + price
				+ ", PublishedDate=" + PublishedDate + ", bookUrl=" + bookUrl + ", description=" + description
				+ ", genre=" + genre + "]";
	}


	public int getBookId() {
		return bookId;
	}
	public void setBookId(int bookId) {
		this.bookId = bookId;
	}
	public String getBookName() {
		return bookName;
	}
	public void setBookName(String bookName) {
		this.bookName = bookName;
	}
	public String getAuthorName() {
		return authorName;
	}
	public void setAuthorName(String authorName) {
		this.authorName = authorName;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public Date getPublishedDate() {
		return PublishedDate;
	}
	public void setPublishedDate(Date publishedDate) {
		PublishedDate = publishedDate;
	}
	public String getBookUrl() {
		return bookUrl;
	}
	public void setBookUrl(String bookUrl) {
		this.bookUrl = bookUrl;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getGenre() {
		return genre;
	}

	public void setGenre(String genre) {
		this.genre = genre;
	}
	
}
