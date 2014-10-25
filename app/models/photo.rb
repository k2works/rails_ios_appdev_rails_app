class Photo < ActiveRecord::Base
  belongs_to :user
  belongs_to :album
  has_one :travel
  has_attached_file :image, :style => { :thumb => ["64x64",:png] }
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
