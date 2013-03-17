puts 'generating some weight measurements'
25.times do
  WeightMeasurement.create(value: Random.rand(80...110).round(2), unit: 'kg')
  sleep 1
end
