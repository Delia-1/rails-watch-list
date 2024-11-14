class BookmarksController < ApplicationController

  def create
    @list = List.find(params[:list_id])
    @bookmark = @list.bookmarks.new(bookmark_params)
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list), notice: "Bookmark created successfully!"
    else
      redirect_to list_path(@list), alert: "Must be at least 6 chars!"
      # render :new, status: :unprocessable_entity
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
end
