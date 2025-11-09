module Api
  module V1
    class BooksController < Api::BaseController
      before_action :set_default_format
      
      def index
        @books = Book.includes(:author).all
        
        # Search by title
        if params[:title].present?
          @books = @books.where("title ILIKE ?", "%#{params[:title]}%")
        end
        
        # Filter by author_id
        if params[:author_id].present?
          @books = @books.where(author_id: params[:author_id])
        end
        
        # Pagination
        page = params[:page] || 1
        per_page = params[:per_page] || 10
        per_page = [per_page.to_i, 100].min # Limit max per_page to 100
        
        @books = @books.order(created_at: :desc)
        @books = @books.page(page).per(per_page)
      end

      def show
        @book = Book.includes(:author).find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Book not found" }, status: :not_found
      end

      private

      def set_default_format
        request.format = :json unless request.format
      end
    end
  end
end

