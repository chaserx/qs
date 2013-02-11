class CreateWeightMeasurements < ActiveRecord::Migration
  def change
    create_table :weight_measurements do |t|
      t.float :value, default: 0.0
      t.string :unit, default: 'lbs'

      t.timestamps
    end
  end
end
