class BookmarksController < ApplicationController
  before_action :set_bookmark, only: :destroy
  before_action :set_list, only: [:new, :create]

  def new
    @bookmark = Bookmark.new
  end


  def create
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list)
    else
      @review = Review.new
      render :new, status: :unprocessable_entity
    end
  end


  # def destroy
  #   @list = List.find(params[:list_id])
  #   @bookmark = @list.bookmarks.find(params[:id]) # Find the specific bookmark to delete
  #   @bookmark.destroy
  #   redirect_to list_path(@list), notice: "Bookmark deleted successfully!"
  # end

  def destroy
    @list = List.find_by(id: params[:list_id])
    @bookmark = @list&.bookmarks.find(params[:id]) if @list # Find the specific bookmark to delete

    if @bookmark
      @bookmark.destroy
      redirect_to list_path(@list), status: :see_other
    else
      redirect_to list_path(@list), alert: "Failed to delete bookmark."
    end

  end

  private
  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

  def set_list
    @list = List.find(params[:list_id])
  end
end
