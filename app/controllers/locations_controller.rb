class LocationsController < ApplicationController

    def new

    end

    def create
        require 'csv'

        locations_file = params[:locations]
        @employee = Employee.where("name = ? AND eid = ?", params[:employee][:name], params[:employee][:eid]).take
        CSV.foreach(locations_file.path) do |row|
            location = Location.new(lat: row[0], lng: row[1], time: row[2])
            @employee.locations << location
            @employee.save
            location.save
        end
        redirect_to home_path(@employee, 0)
    end
end
