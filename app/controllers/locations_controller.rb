class LocationsController < ApplicationController

    def new

    end

    def create
        require 'csv'

        #logger.debug "params: #{params}"
        locations_files = params[:locations]
        @employee = Employee.where("name = ? AND eid = ?", params[:employee][:name], params[:employee][:eid]).take
        for file in locations_files
            #logger.debug "file_path: #{file.path}"
            if File.extname(file.path) == ".loc"
                CSV.foreach(file.path) do |row|
                    location = Location.new(lat: row[0], lng: row[1], time: row[2])
                    @employee.locations << location
                    @employee.save
                    location.save
                end
            end
        end
        redirect_to home_path(@employee, 0)
    end
end
