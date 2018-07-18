class Attachment < ApplicationRecord
  belongs_to :user

  validates :csv_file, presence: true
  validates :uuid, presence: true

  after_initialize :generate_token

  mount_uploader :csv_file, CsvUploader

  def self.import(file)
    csv_name = file.original_filename
    Book.transaction do
      attachment = Current.user.attachments.build(csv_file: file, original_csv_filename: csv_name)

      CSV.foreach(file.path, headers: true) do |row|
        merged_params = row.to_hash.merge(csv_name: csv_name)
        Current.user.books.create! merged_params
      end

      attachment.save
      url = attachment.csv_file.url
      CsvNotificationJob.perform_later(url)
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
