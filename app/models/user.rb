class User < ActiveRecord::Base
  extend Enumerize

  belongs_to :section
  validates :name, presence: true
  validates :section_id, presence: true
  validates :job_type, presence: true
  validates :github_id, presence: true
  validates :irc_name, presence: true
  before_save :create_remember_token

  private
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end

  enumerize :job_type, :in => [:engineer, :designer, :backoffice, :manager, :producer]
end
