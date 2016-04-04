class EmployeesController < ApplicationController
    before_filter :authorize

    def new

    end

    def create
        @employee = Employee.new(employee_params)
        current_user.employees << @employee
        current_user.save
        if @employee.save
            redirect_to home_path(@employee)
        else
            flash[:alert] = "Error adding new employee"
            redirect_to addemployee_path
        end
    end

    def show
        id = params[:id]
        @employees_list = current_user.employees
        if @employees_list.empty?
            redirect_to addemployee_path
        elsif id == "0"
            @employee = @employees_list.first
            @locations = @employee.locations
            @times = @locations.map { |location| location['time'].strftime("%H:%M:%S %p %b %d, %Y") }
        else
            @employee = Employee.find(id)
            @locations = @employee.locations
            @times = @locations.map { |location| location['time'].strftime("%H:%M:%S %p %b %d, %Y") }
            if @employee.user_id != current_user.id
                redirect_to home_path(0)
            end
        end
    end

private

    def employee_params
        params.require(:employee).permit(:name, :eid)
    end
end
