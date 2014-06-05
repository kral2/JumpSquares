class User < ActiveRecord::Base
  #resourcify
  rolify
  
  after_create :jumpsizeprofile

  def jumpsizeprofile
    Jumpsize.create(:size => "medium", :length1 => 20, :length2 => 22, :itemsperpage => 100, :jumpsizecreator => self.email, :sortorder => "name")
  end
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :database_authenticatable
         
  def self.search(search)
    if search
      where('email ILIKE ?', "%#{search}%")
    else
      all
    end
  end
  
end
