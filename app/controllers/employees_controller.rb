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
        else
            @employee = Employee.find(id)
        end
    end

private

    def employee_params
        params.require(:employee).permit(:name, :eid)
    end
end
