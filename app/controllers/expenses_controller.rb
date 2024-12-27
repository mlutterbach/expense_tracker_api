class ExpensesController < ApplicationController
  before_action :authorize

  # GET /expenses
  def index
    expenses = @current_user.expenses.order(date: "desc")
    if params[:filter] == 'week'
      expenses = expenses.where('date >= ?', 1.week.ago)
    elsif params[:filter] == 'month'
      expenses = expenses.where('date >= ?', 1.month.ago)
    elsif params[:filter] == '3months'
      expenses = expenses.where('date >= ?', 3.months.ago)
    elsif params[:start_date] && params[:end_date]
      expenses = expenses.where(date: params[:start_date]..params[:end_date])
    end

    if params[:min_amount] && params[:max_amount]
      expenses = expenses.where(amount: params[:min_amount]..params[:max_amount])
      expenses = expenses.where(amount: params[:min_amount]..params[:max_amount])
    elsif params[:min_amount]
      expenses = expenses.where('amount >= ?', params[:min_amount])
    elsif params[:max_amount]
      expenses = expenses.where('amount <= ?', params[:max_amount])
    end

    render json: expenses
  end

  # GET /monthly_by_category
  def monthly_by_category
    month = params[:month] || Time.current.strftime('%Y-%m')

    expenses_by_month_and_category = @current_user.expenses
                                                  .where("strftime('%Y-%m', date) = ?", month)
                                                  .group(:category)
                                                  .sum(:amount)

  sorted_expenses = expenses_by_month_and_category.sort_by { |_category, amount| -amount }.to_h

  formatted_expenses = { month => sorted_expenses }

  render json: formatted_expenses
  end


  # POST /expenses
  def create
    expense = @current_user.expenses.new(expense_params)
    if expense.save
      render json: expense, status: :created
    else
      render json: { errors: expense.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /expenses/:id
  def update
    expense = @current_user.expenses.find(params[:id])
    if expense.update(expense_params)
      render json: expense
    else
      render json: { errors: expense.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /expenses/:id
  def destroy
    expense = @current_user.expenses.find(params[:id])
    expense.destroy
    head :no_content
  end

  private

  def expense_params
    params.require(:expense).permit(:amount, :category, :description, :date)
  end
end
