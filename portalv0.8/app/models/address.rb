class Address < ApplicationRecord
	belongs_to :customer
	 geocoded_by :address       # can also be an IP address
  	after_validation :geocode  # auto-fetch coordinates	
end

