class Student < ActiveRecord::Base
	belongs_to :group
	belongs_to :plan
	has_and_belongs_to_many :disciplines
  belongs_to :user
  has_many :student_works
  has_many :student_honors
  has_many :duties
    
  validates :l_n, presence: true
  validates :f_n, presence: true
  validates :birth, presence: true
  validates :studbook, presence: true, uniqueness: true
  
  has_attached_file :avatar, styles: {big: '1000x1000>', thumb: '100x100', medium: '300x300>'},
  :path => ":rails_root/system/:class/:attachment/:id_partition/:style/:filename"
  
  validates_attachment :avatar, content_type: {content_type: /\Aimage/}

  def full_name 
      self.l_n + " " + self.f_n + " " + self.s_n
  end
end
