class StoresRole < ActiveRecord::Base
	belongs_to :store
	belongs_to :role
end
