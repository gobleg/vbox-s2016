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
        elsif id == "0"
            @employee = @employees_list.first
            all_locations = @employee.locations
            if date == "0"
                all_dates = all_locations.map { |location| location['time'] }
                most_recent_date = all_dates.max
                @display_date = most_recent_date.strftime("%b %d, %Y")
                @locations = Location.where("time BETWEEN ? AND ? AND employee_id = ?", most_recent_date.beginning_of_day, most_recent_date.end_of_day, @employee.id).all
            else
                date_p = DateTime.strptime(date, "%b %d, %Y")
                @display_date = date
                @locations = Location.where("time BETWEEN ? AND ? AND employee_id = ?", date_p.beginning_of_day, date_p.end_of_day, @employee.id).all
            end
            @times = @locations.map { |location| location['time'].strftime("%H:%M:%S %p %b %d, %Y") }
            @dates = all_locations.map { |location| location['time'].strftime("%b %d, %Y") }
            @dates = @dates.uniq
        else
            @employee = Employee.find(id)
            all_locations = @employee.locations
            if date == "0"
                all_dates = all_locations.map { |location| location['time'] }
                most_recent_date = all_dates.max
                @display_date = most_recent_date.strftime("%b %d, %Y")
                @locations = Location.where("time BETWEEN ? AND ? AND employee_id = ?", most_recent_date.beginning_of_day, most_recent_date.end_of_day, @employee.id).all
            else
                date_p = DateTime.strptime(date, "%b %d, %Y")
                @display_date = date
                @locations = Location.where("time BETWEEN ? AND ? AND employee_id = ?", date_p.beginning_of_day, date_p.end_of_day, @employee.id).all
            end
            @times = @locations.map { |location| location['time'].strftime("%H:%M:%S %p %b %d, %Y") }
            @dates = all_locations.map { |location| location['time'].strftime("%b %d, %Y") }
            @dates = @dates.uniq
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
