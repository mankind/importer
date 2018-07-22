class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  validates :name, presence: true, uniqueness: true
  
  has_many :books, dependent: :destroy
  has_many :attachments, dependent: :destroy

  def page_title
    unless most_recent_csv_file.nil?
     @page_title ||= @csv.original_csv_filename
    end
  end

  def most_recent_csv_file
    @csv ||= attachments.last
  end

  def books_from_last_csv
    books.where(csv_name: page_title)
  end

end
