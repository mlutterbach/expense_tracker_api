class ExpensesController < ApplicationController
  before_action :authorize

  # GET /expenses
  def index
    expenses = current_user.expenses
    if params[:filter] == 'week'
      expenses = expenses.where(:date.gte => 1.week.ago)
    elsif params[:filter] == 'month'
      expenses = expenses.where(:date.gte => 1.month.ago)
    elsif params[:filter] == '3months'
      expenses = expenses.where(:date.gte => 3.months.ago)
    elsif params[:start_date] && params[:end_date]
      expenses = expenses.where(:date.gte => params[:start_date], :date.lte => params[:end_date])
    end
    render json: expenses
  end

  # POST /expenses
  def create
    expense = current_user.expenses.new(expense_params)
    if expense.save
      render json: expense, status: :created
    else
      render json: { errors: expense.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /expenses/:id
  def update
    expense = current_user.expenses.find(params[:id])
    if expense.update(expense_params)
      render json: expense
    else
      render json: { errors: expense.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /expenses/:id
  def destroy
    expense = current_user.expenses.find(params[:id])
    expense.destroy
    head :no_content
  end

  private

  def expense_params
    params.permit(:amount, :category, :description, :date)
  end
end
