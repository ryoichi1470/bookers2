class BooksController < ApplicationController
  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end
  def new
    @book = Book.new
  end 

  def show
     @new_book = Book.new
     @book = Book.find(params[:id])
     @user = @book.user
  end

  def create
    @book = Book.new(book_params)  
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "Created successfully"
      redirect_to @book  
    else
      render :new  
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Updated successfully"
      redirect_to @book  
    else
      render :edit  
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path 
  end
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
