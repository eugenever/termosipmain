class Article < ActiveRecord::Base

  validates :title, presence: true
  validates :description, presence: true
  validates :content, presence: true

end
