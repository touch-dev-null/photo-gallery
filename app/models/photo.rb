class Photo < ActiveRecord::Base
  belongs_to :user
  belongs_to :gallery

  attr_accessible :photo, :user_id

  has_attached_file :photo,
                    :styles => {
                        :mini => {
                            :geometry => '124x124>',
                            :quality => 85,
                            :format => 'JPG'
                        },
                        :small => {
                            :geometry => '160x160>',
                            :quality => 85,
                            :format => 'JPG'
                        },
                        :thumb => {
                            :geometry => '200x200>',
                            :quality => 100
                        },
                        :medium => {
                            :geometry => '400x400>',
                            :quality => 100
                        },
                        :large => {
                            :geometry => '800x800#',
                            :quality => 100
                        },
                        :original => {
                            :geometry => '2000x2000#',
                            :quality => 100
                        }
                    }
end
