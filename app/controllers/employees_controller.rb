class EmployeesController < ApplicationController
    before_filter :authorize

    def new

    end

    def create
        @employee = Employee.new(employee_params)
        if @employee.save
            redirect_to home_path(@employee)
        else
            flash[:alert] = "Error adding new employee"
            redirect_to addemployee_path
        end
    end

    def show

    end

private

    def employee_params
        params.require(:employee).permit(:name, :eid)
    end
end
