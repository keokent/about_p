class User < ActiveRecord::Base
  extend Enumerize

  belongs_to :section
  validates :name, presence: true, length: { maximum: 40 }
  validates :section_id, presence: true
  validates :job_type, presence: true
  validates :github_uid, presence: true
  validates :irc_name, presence: true, length: { maximum: 20 }, format: { with: /\A[a-zA-Z][a-zA-Z\-\_\^0-9]*\Z/ }, uniqueness: { case_sensitive: false } 
  validates :twitter_id, length: { maximum: 15 }, format: { with: /\A[0-9a-zA-Z\_]*\Z/ }
  
  before_save :create_remember_token

  private
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end

  enumerize :job_type, :in => [:engineer, :designer, :director, :customer_service, :backoffice, :producer, :manager, :officer, :other]

  mount_uploader :face_image, FaceImageUploader
end
