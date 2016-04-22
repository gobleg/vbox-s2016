class EmployeesController < ApplicationController
    before_filter :authorize

    def new

    end

    def create
        @employee = Employee.new(employee_params)
        current_user.employees << @employee
        current_user.save
        if @employee.save
            redirect_to home_path(@employee, 0)
        else
            flash[:alert] = "Error adding new employee"
            redirect_to addemployee_path
        end
    end

    def show
        id = params[:id]
        date = params[:date]
        @employees_list = current_user.employees
        if @employees_list.empty?
            redirect_to addemployee_path
        else
            if id == "0"
                @employee = @employees_list.first
            else
                @employee = Employee.find(id)
            end
            all_locations = @employee.locations
            all_obds = @employee.obds
            if date == "0"
                all_dates = all_locations.map { |location| location['time'] }
                all_dates += all_obds.map { |obd| obd['time'] }
                most_recent_date = all_dates.max
                if most_recent_date.nil?
                    most_recent_date = Time.now
                end
                @display_date = most_recent_date.strftime("%b %d, %Y")
                @locations = Location.where("time BETWEEN ? AND ? AND employee_id = ?", most_recent_date.beginning_of_day, most_recent_date.end_of_day, @employee.id).all
                @obds = Obd.where("time BETWEEN ? AND ? AND employee_id = ?", most_recent_date.beginning_of_day, most_recent_date.end_of_day, @employee.id).all
            else
                date_p = DateTime.strptime(date, "%b %d, %Y")
                @display_date = date
                @locations = Location.where("time BETWEEN ? AND ? AND employee_id = ?", date_p.beginning_of_day, date_p.end_of_day, @employee.id).all
                @obds = Obd.where("time BETWEEN ? AND ? AND employee_id = ?", date_p.beginning_of_day, date_p.end_of_day, @employee.id).all
            end
            @times = @locations.map { |location| location['time'].strftime("%I:%M:%S %p %b %d, %Y") }
            @dates = all_locations.map { |location| location['time'].strftime("%b %d, %Y") }
            @dates += all_obds.map { |obd| obd['time'].strftime("%b %d, %Y") }
            @dates = @dates.uniq.sort
            if @employee.user_id != current_user.id
                redirect_to home_path(0, 0)
            end
        end
    end

private

    def employee_params
        params.require(:employee).permit(:name, :eid)
    end
end
