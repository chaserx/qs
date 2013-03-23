puts 'generating some weight measurements'
dates = (1.month.ago.to_date..Date.today).map{ |date| date.strftime("%F") }
30.times do
  time = DateTime.parse(dates.sample)
  WeightMeasurement.create({value: Random.rand(98...101).round(2), unit: 'kg',
                           created_at: time, updated_at: time}, 
                           without_protection: true)
end
