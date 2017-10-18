require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest

  describe "BooksController" do

    it "going to the books index page is successful" do
      # Arrange

      # Act
      get books_path

      # Assert
      must_respond_with :success
    end

    it "should be able to visit an individual book show page" do
      # Arrange

      # Act
      get book_path( books(:book_one).id )

      # Assert
      must_respond_with :success
    end


    it "should respond with 404 if it's not found" do
      # Arrange
      books(:book_one).destroy()

      # Act
      get book_path( books(:book_one).id )

      # Assert
      must_respond_with :not_found
    end


    it "should be able to successfully create a book" do
      proc {
        post books_path, params: { book: { title: "New Title", author_id: authors(:italo_calvino).id } }
      }.must_change 'Book.count', 1

      must_respond_with :redirect
      must_redirect_to root_path
    end


    it "should rerender the form if it can't create the book" do
      proc {
        post books_path, params: { book: { author_id: authors(:italo_calvino).id } }
      }.must_change 'Book.count', 0

      must_respond_with :success
    end

    it "should be able to successfully update a book title" do
      put book_path( books(:book_one) ), params: { book: { title: "Updated Title" } }

      updated_book = Book.find( books(:book_one).id )

      updated_book.title.must_equal "Updated Title"

      must_redirect_to root_path
    end

  end

end
