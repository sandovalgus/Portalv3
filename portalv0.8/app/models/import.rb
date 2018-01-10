class Import < ApplicationRecord

	def self.update(e)
		s = Import.new(:state => e)
		s.save
	end

end
