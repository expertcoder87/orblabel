class Role < ActiveRecord::Base
  has_many :stores_roles
  has_many :stores, through: :stores_roles

end
