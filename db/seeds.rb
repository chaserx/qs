puts 'generating some weight measurements'
25.times do
  WeightMeasurement.create(value: Random.rand(100...242).round(2), unit: 'kg')
  sleep 1
end
