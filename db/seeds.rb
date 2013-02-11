25.times do
  WeightMeasurement.create(value: Random.rand(100...242), unit: 'lbs')
end
