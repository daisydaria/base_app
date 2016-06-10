class Role < ActiveRecord::Base
  has_many :role_users
end
