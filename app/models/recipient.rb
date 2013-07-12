class Recipient < ActiveRecord::Base
  # has_and_belongs_to_many :packages, :join_table => :package_recipient
  attr_accessible :email, :name, :address, :phone_number, :user_id
  #attr_accessor :is_new_recipient
  validates :name, :presence => true
  validates :email, :presence => true
  validates :email, :format => /@/

  #validates_numericality_of :phone_number
  validates_uniqueness_of :email, :scope => :user_id

  #before_save :check_exist
  #
  #def check_exist
  #  if :is_new_recipient
  #
  #  end
  #end

end
