class ScheduledPhoto < ActiveRecord::Base
  belongs_to :user
  belongs_to :gallery

  attr_accessible :user_id, :status, :photo_path, :log
end
