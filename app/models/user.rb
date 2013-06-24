class User < ActiveRecord::Base
  belongs_to :section
  validates :name, presence: true
end
