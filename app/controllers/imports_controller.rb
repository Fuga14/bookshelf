class ImportsController < ApplicationController
  def new
    @import = Import.new
    @users = User.all
  end

  def create
    @import = Import.new(import_params)
    
    csv_file = params[:import][:csv_file]
    if csv_file.blank?
      @import.errors.add(:csv_file, "can't be blank")
      @users = User.all
      render :new, status: :unprocessable_entity
      return
    end

    if @import.save
      csv_content = csv_file.read
      ImportBooksJob.perform_later(@import.id, csv_content)
      redirect_to books_path, notice: "Import started. You will receive an email report when it completes."
    else
      @users = User.all
      render :new, status: :unprocessable_entity
    end
  end

  private

  def import_params
    params.require(:import).permit(:user_id)
  end
end

