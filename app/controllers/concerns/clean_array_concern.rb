module CleanArrayConcern
	extend ActiveSupport::Concern

	def clean_array(arr)
		result = []

		arr.each do |val|
			not_empty = false
			val.keys.each do |key|
				not_empty = true unless val[key].nil? or val[key].blank?
			end

			result << val if not_empty
		end

		result
	end

	def clean_arrays(data)
		result = {}

		data.each_pair do |idx, val|
			puts "#{idx} => #{val.inspect}"

			result[idx] = val.is_a?(Array) ? clean_array(val) : result[idx] = val
		end

		result
	end
end
