class Gallery < ActiveRecord::Base
  belongs_to :user

  has_many :photos, :dependent => :destroy
  has_many :scheduled_photos, :dependent => :destroy

  before_save :generate_url_name

  validates :name, :length => { :in => 1..255 }, :allow_blank => false

  attr_accessible :name

  def directory_path
    "/uploads/galleries/#{self.id}"
  end

  def to_param
    #"#{id}-#{name.translify}"
    self.url_name
  end

  private

  def generate_url_name
    self.url_name = self.name.trans
  end

end
