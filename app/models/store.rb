class Store < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:confirmable
  #attr_accessor :public_name, :legal_name, :cnpj, :area_code
  validates :public_name,:legal_name, :cnpj, :area_code, presence: true
  validates :checkbox, :acceptance => true
  validates :cnpj, :cnpj => true
  #validates :area_code, length: { maximum: 2 }, numericality: true
  
   has_one :address
   accepts_nested_attributes_for :address
   has_many :bikes

   has_many :maintenance_events


   has_many :stores_roles
   has_many :roles, through: :stores_roles

    def with_address
      build_address if address.nil?
      self
    end

    def add_role(role)
      self.stores_roles.create(role_id: role)
    end
  
    def has_role?(role)
      role = Role.find_by(name: role.to_s)
      self.roles.include? role
    end

end
