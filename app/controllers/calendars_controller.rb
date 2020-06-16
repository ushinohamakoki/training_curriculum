class CalendarsController < ApplicationController

  # １週間のカレンダーと予定が表示されるページ
  def index
    getWeek
    @plan = Plan.new
  end

  # 予定の保存
  def create
    Plan.create(plan_params)
    redirect_to action: :index
  end

  private

  def plan_params
    params.require(:plan).permit(:date, :plan)
  end

  def getWeek
    wday = ["(日)","(月)","(火)","(水)","(木)","(金)","(土)"]

    require 'date'
    @todays_date = Date.today
    @week_days = []

    @plans = Plan.where(date: @todays_date..@todays_date + 7)
    7.times do |x|
      plans = []
      plan = @plans.map do |plan|
        plans.push(plan.plan) if plan.date == @todays_date + x
      end

      days = { month: (@todays_date + x).month, date: @todays_date.day + x, day: wday[(@todays_date + x).strftime("%u").to_i - 7], plans: plans }
      @week_days.push(days)
    end
  end
end