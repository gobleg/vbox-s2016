class LocationsController < ApplicationController

    def new

    end

    def create
        require 'csv'
        require 'date'

        #logger.debug "params: #{params}"
        locations_files = params[:locations]
        @employee = Employee.where("name = ? AND eid = ?", params[:employee][:name], params[:employee][:eid]).take
        if @employee.nil?
            flash[:alert] = "Employee not found"
            redirect_to upload_path
        elsif params[:locations].nil?
            flash[:alert] = "No file selected"
            redirect_to upload_path
        else
            for file in locations_files
                #logger.debug "file_path: #{file.path}"
                if File.extname(file.path) == ".loc"
                    CSV.foreach(file.path) do |row|
                        location = Location.new(lat: row[0], lng: row[1], time: Time.at(Integer(row[2])).to_datetime)
                        @employee.locations << location
                        @employee.save
                        location.save
                    end
                end
            end
            redirect_to home_path(@employee, 0)
        end
    end
end
