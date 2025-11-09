class ImportBooksJob < ApplicationJob
  queue_as :default

  def perform(import_id, csv_content)
    import = Import.find(import_id)
    import.update(status: :processing)
    
    start_time = Time.current
    created_count = 0
    skipped_count = 0
    
    require "csv"
    
    csv_data = CSV.parse(csv_content, headers: true)
    
    csv_data.each do |row|
      author_name = row["author_name"]&.strip
      next if author_name.blank?
      
      author = Author.find_by(name: author_name)
      if author.nil?
        skipped_count += 1
        next
      end
      
      book = Book.new(
        title: row["title"]&.strip,
        author: author,
        year: row["year"]&.strip&.to_i,
        description: row["description"]&.strip
      )
      
      if book.save
        created_count += 1
      else
        skipped_count += 1
      end
    end
    
    execution_time = Time.current - start_time
    
    import.update(
      created_count: created_count,
      skipped_count: skipped_count,
      execution_time: execution_time,
      status: :completed
    )
    
    # Send email report to admin
    admin_user = User.find_by(admin: true)
    if admin_user
      UserMailer.import_report(admin_user, import).deliver_now
    end
  rescue StandardError => e
    import.update(status: :failed)
    raise e
  end
end

