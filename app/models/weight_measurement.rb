# Weight Measurements
#
# Record weight either in kilogram or pound, but save all data as kilogram.
# Data will be displayed to the user using the unit of their choice.
#
class WeightMeasurement < ActiveRecord::Base
  attr_accessible :unit, :value

  before_save :convert_to_kg

  def kg_to_lbs
    value * 2.20462
  end

  def lbs_to_kg
    value * 0.453592
  end

  def convert_to_kg
    if self.unit == 'lbs'
      self.value = lbs_to_kg
      self.unit = 'kg' 
      return true
    end
  end

end
