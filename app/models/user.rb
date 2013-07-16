class User < ActiveRecord::Base
  include AboutP::Utils
  extend Enumerize

  belongs_to :section
  validates :name, presence: true, length: { maximum: 40 }
  validates :section_id, presence: true
  validates :job_type, presence: true
  validates :github_uid, presence: true
  validates :irc_name, presence: true, length: { maximum: 20 }, format: { with: /\A[a-zA-Z][a-zA-Z\-\_\^0-9]*\Z/ }, uniqueness: { case_sensitive: false } 
  validates :twitter_id, length: { maximum: 15 }, format: { with: /\A[0-9a-zA-Z\_]*\Z/ }
  
  before_save :create_remember_token
  after_create :notify_newcomer, :if => ->{ Rails.env.production? }
  after_update :notify_update, :if => ->{ Rails.env.production? }

  private
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end

  def notify_newcomer
    ikachan("#{self.nickname} さんがabout pをはじめました: http://about-p-kitak.sqale.jp/users/#{self.id}")
  end

  def notify_update
    ikachan("#{self.nickname} さんがabout pのプロフィールを更新しました: http://about-p-kitak.sqale.jp/users/#{self.id}")
  end

  enumerize :job_type, :in => [:engineer, :designer, :director, :customer_service, :backoffice, :producer, :manager, :officer, :other]

  mount_uploader :face_image, FaceImageUploader
end
