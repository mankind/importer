class Book < ApplicationRecord
  belongs_to :user

  validates :uuid,  presence: true, uniqueness: true
  validates :csv_name, presence: true
  
  def self.create_books_from_csv(file)
    csv_name = file.original_filename
    CSV.foreach(file.path, headers: true) do |row|
      if !row.to_hash.empty?
        hash_row = row.to_hash
        merged_values = hash_row.merge({csv_name: csv_name})
        Current.user.books.create! merged_values
      end
    end
  end

end
