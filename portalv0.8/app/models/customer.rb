require 'address'
class Customer < ApplicationRecord
	belongs_to :zone,  required: false
	has_many :addresses, dependent: :destroy
	accepts_nested_attributes_for :addresses
									# reject_if: proc {|attributes| attributes['name'].blank?},
									# allow_destroy:true
	def self.import(path, file)
	# 10000,GRAL.RAMIREZ 1968,POSADAS,Misiones,3
		actualizado = 1

		CSV.foreach(path, headers: false) do | row |

			c =  Customer.where(:n_socio => row[0]).first
			if (c)
				c.estado = row[4]				
				actualizado+=1

			else

				c = Customer.new(:n_socio => row[0])
				c.estado = row[4]
				direccion = String(row[1]) + ", " + String(row[2]) + ", " + String(row[3])
				c.addresses.build(:address => direccion)

			end

			c.save
			# puts a.inspect
			
		end

	end


end







