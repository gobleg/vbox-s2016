class LocationsController < ApplicationController

    def new

    end

    def create
        require 'csv'
        require 'date'

        input_files = params[:inputFiles]
        @employee = Employee.where("name = ? AND eid = ?", params[:employee][:name], params[:employee][:eid]).take
        if @employee.nil?
            flash[:alert] = "Employee not found"
            redirect_to upload_path
        elsif params[:inputFiles].nil?
            flash[:alert] = "No file selected"
            redirect_to upload_path
        else
            logger.debug "#{input_files}"
            for file in input_files
                if File.extname(file["attributes"].path) == ".loc"
                    CSV.foreach(file["attributes"].path) do |row|
                        location = Location.new(lat: row[0], lng: row[1], time: Time.at(Integer(row[2])).to_datetime)
                        @employee.locations << location
                        @employee.save
                        location.save
                    end
                elsif File.extname(file["attributes"].path) == ".mp4"
                    time = file["attributes"].original_filename.split('.')[0]
                    video = Video.create(:dash_video => file["attributes"], :time => Time.at(Integer(time)))
                    @employee.videos << video
                    @employee.save
                    video.save
                elsif File.extname(file["attributes"].path) == ".obd"
                    CSV.foreach(file["attributes"].path) do |row|
                        obd = Obd.new(time: Time.at(row[0].to_f), rpm: row[1].to_f, mph: row[2].to_f, throttle: row[3].to_f, intake_air_temp: row[4].to_f, fuel_status: row[5].to_f)
                        @employee.obds << obd
                        @employee.save
                        obd.save
                    end
                end
            end
            redirect_to home_path(@employee, 0)
        end
    end
end
