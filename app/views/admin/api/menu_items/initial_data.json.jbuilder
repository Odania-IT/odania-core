Odania::TargetType.targets.each_pair.each do |idx, target|
	json.partial! target[:initial_data]
end
