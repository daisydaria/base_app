class User < ActiveRecord::Base

  has_many :role_users
  has_one :student
  attr_accessor :role

  has_one :teacher
  authenticates_with_sorcery!
  
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :password, length: {minimum: 3}, confirmation: true,
            if: Proc.new { |u| u.new_record? or !u.password.blank? }

  validates :student, presence: true, if: Proc.new {|u| u.role.name == "Студент" if u.role}
  validates :teacher, presence: true, if: Proc.new {|u| u.role.name == "Преподаватель" if u.role}

end
