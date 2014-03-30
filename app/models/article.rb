class Article < ActiveRecord::Base

  validates :title, presence: true
  validates :description, presence: true
  validates :content, presence: true

  after_commit  :update_sitemap

  def update_sitemap
    system("RAILS_ENV=#{Rails.env} bundle exec rake sitemap:generate")
    system("RAILS_ENV=#{Rails.env} bundle exec rake sitemap:symlink")
  end

end
