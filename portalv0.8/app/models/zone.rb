class Zone < ApplicationRecord
	has_many :coordinate_zones, :dependent => :delete_all
	has_many :customers
end
