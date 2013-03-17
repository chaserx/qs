module WeightMeasurementsHelper
  # TODO(chase): should have a method to display the weight records 
  # consistently according to the user's preference. 

  def show_in_lbs(value)
    value.kg_to_lbs
  end

  def show_in_kg(value)
    value.lbs_to_kg
  end
end
