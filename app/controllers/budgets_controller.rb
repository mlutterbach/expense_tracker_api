class BudgetsController < ApplicationController
  before_action :authorize

  def index
    budgets = @current_user.budgets.where(month: params[:month])
    render json: budgets
  end

  def show
    month = params[:month] || Time.current.strftime('%Y-%m')
    budget = @current_user.budgets.find_by(month: month)

    if budget
      render json: budget, status: :ok
    else
      render json: { message: "No budget set for #{month}" }, status: :not_found
    end
  end

  def create
    budget = @current_user.budgets.new(budget_params)

    if budget.save
      render json: budget
    else
      render json: { errors: budget.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    budget = @current_user.budgets.find(params[:id])

    if budget.update(budget_params)
      render json: budget
    else
      render json: { errors: budget.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    budget = @current_user.budgets.find(params[:id])
    budget.destroy
    head :no_content
  end

  private

  def budget_params
    params.require(:budget).permit(:month, :amount)
  end
end
