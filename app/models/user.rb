class User < ActiveRecord::Base
  extend Enumerize

  belongs_to :section
  validates :name, presence: true, length: { maximum: 40 }
  validates :section_id, presence: true
  validates :job_type, presence: true
  validates :github_id, presence: true
  validates :irc_name, presence: true, length: { maximum: 40 }

  enumerize :job_type, :in => [:engineer, :designer, :backoffice, :manager, :producer]
end
