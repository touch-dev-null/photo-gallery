class Gallery < ActiveRecord::Base
  belongs_to :user
  has_many :photos, :dependent => :destroy

  before_save :generate_url_name

  attr_accessible :name

  def to_param
    #"#{id}-#{name.translify}"
    self.url_name
  end

  private

  def generate_url_name
    self.url_name = self.name.trans
  end

end
