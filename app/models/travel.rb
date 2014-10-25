class Travel < ActiveRecord::Base
  has_many :albums

  belongs_to :user
  belongs_to :cover_photo, :class_name => "Photo", :foreign_key => "photo_id"
end
