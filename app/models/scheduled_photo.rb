class ScheduledPhoto < ActiveRecord::Base
  belongs_to :user
  belongs_to :gallery

  scope :pending, where(:status => "pending")

  attr_accessible :user_id, :status, :photo_path, :log
end
