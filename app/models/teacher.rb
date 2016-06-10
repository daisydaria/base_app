class Teacher < ActiveRecord::Base
	belongs_to :user
	has_and_belongs_to_many :departments
	has_and_belongs_to_many :disciplines
	has_many :academic_hours
	validates :lname, presence: true
	validates :fname, presence: true
	validates :birth, presence: true
	validates :degree, presence: true
	validates :rank, presence: true
	validates :post, presence: true
has_attached_file :avatar, styles: {big: '1000x1000>', thumb: '100x100'},
    :path => ":rails_root/system/:class/:attachment/:id_partition/:style/:filename"
    validates_attachment :avatar, content_type: {content_type: /\Aimage/}
	def full_name
		self.lname + " " + self.fname + " " + self.sname
	end
end
