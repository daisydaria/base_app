class Document < ActiveRecord::Base
  has_attached_file :image, styles: {big: '1000x1000>', thumb: '100x100'},
  :path => ":rails_root/system/:class/:attachment/:id_partition/:style/:filename"
  validates_attachment :image, content_type: {content_type: [/\Aimage/, 'application/pdf']}
  

  belongs_to :user

  has_one :duty

  validates :text, presence: true
end
