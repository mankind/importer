class Attachment < ApplicationRecord
  belongs_to :user

  validates :csv_file, presence: true
  validates :uuid, presence: true

  after_initialize :generate_token

  mount_uploader :csv_file, CsvUploader

  def self.import(file)
    Attachment.transaction do
      @attachment = create_attachment_fom_csv(file)
      create_books_from_csv(file)
    end
    @attachment.save
    url = @attachment.csv_file.url
    CsvNotificationJob.perform_later(url)
  end

  def self.create_attachment_fom_csv(file)
    csv_name = file.original_filename
    Current.user.attachments.build(csv_file: file, original_csv_filename: csv_name)
  end

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

  def csv_text
    csv_string
    data = []
    CSV.parse(@csv, headers: true, :row_sep => :auto) do |row|
       data << row.to_hash
    end
    data
  end

  def csv_string
    csv_file ||= self.csv_file
    @csv ||= open(csv_file.url).read
  end

  private

  def generate_token
    self.uuid = loop do
      code = SecureRandom.urlsafe_base64(nil, false)
       break code unless self.class.exists?(uuid: code)
    end
  end 

end
