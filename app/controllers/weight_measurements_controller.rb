class WeightMeasurementsController < ApplicationController
  # GET /weight_measurements
  # GET /weight_measurements.json
  def index
    @weight_measurements = WeightMeasurement.order('created_at DESC').limit(12)
    @weight_measurement = WeightMeasurement.new

    @latest = WeightMeasurement.last
    @total = WeightMeasurement.count
    @avg = WeightMeasurement.average(:value)
    values = WeightMeasurement.select('value').all.map(&:value)
    @med = median(values)
    @min = values.min
    @max = values.max
    @uq  = excel_upper_quartile(values)
    @lq  = excel_lower_quartile(values)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @weight_measurements }
    end
  end

  # GET /weight_measurements/1
  # GET /weight_measurements/1.json
  def show
    @weight_measurement = WeightMeasurement.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @weight_measurement }
    end
  end

  # GET /weight_measurements/new
  # GET /weight_measurements/new.json
  def new
    @weight_measurement = WeightMeasurement.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @weight_measurement }
      format.js
    end
  end

  # GET /weight_measurements/1/edit
  def edit
    @weight_measurement = WeightMeasurement.find(params[:id])
  end

  # POST /weight_measurements
  # POST /weight_measurements.json
  def create
    @weight_measurement = WeightMeasurement.new(params[:weight_measurement])

    respond_to do |format|
      if @weight_measurement.save
        format.html { redirect_to @weight_measurement, notice: 'Weight measurement was successfully created.' }
        format.json { render json: @weight_measurement, status: :created, location: @weight_measurement }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @weight_measurement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /weight_measurements/1
  # PUT /weight_measurements/1.json
  def update
    @weight_measurement = WeightMeasurement.find(params[:id])

    respond_to do |format|
      if @weight_measurement.update_attributes(params[:weight_measurement])
        format.html { redirect_to @weight_measurement, notice: 'Weight measurement was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @weight_measurement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weight_measurements/1
  # DELETE /weight_measurements/1.json
  def destroy
    @weight_measurement = WeightMeasurement.find(params[:id])
    @weight_measurement.destroy

    respond_to do |format|
      format.html { redirect_to weight_measurements_url }
      format.json { head :no_content }
    end
  end

  private

  # from http://stackoverflow.com/a/14859546/281699
  def median(array)
    sorted = array.sort
    len = sorted.length
    return (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
  end

  # from http://stackoverflow.com/a/1744950/281699
  def excel_quartile(extreme,array)      
    return nil if array.empty?
    sorted_array = array.sort
    u = case extreme
    when :upper then 3 * sorted_array.length + 1
    when :lower then sorted_array.length + 3
    else raise "ArgumentError"
    end
    u *= 0.25
    if (u-u.truncate).is_a?(Integer)
      return sorted_array[(u-u.truncate)-1]
    else
      sample = sorted_array[u.truncate.abs-1]
      sample1 = sorted_array[(u.truncate.abs)]
      return sample+((sample1-sample)*(u-u.truncate))
    end
  end

  def excel_upper_quartile(array)
    excel_quartile(:upper, array)
  end

  def excel_lower_quartile(array)
    excel_quartile(:lower, array)
  end

end
