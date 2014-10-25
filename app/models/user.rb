class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :confirmable
  has_many :photos
  has_many :friends
  has_many :followings, :through => :friends
  has_many :travels

  validates_uniqueness_of :username
end
