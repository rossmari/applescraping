class CheckResultsController < ApplicationController

  def index
    @check_results = CheckResult.all
  end

  def new
    @check = CheckResult.new
  end

  def create
    checker = SupportChecker.new(params[:check_result][:imei])
    checker.process
    @check = CheckResult.new(imei: params[:check_result][:imei], status: checker.status, e_date: checker.date)
    @check.save
    redirect_to root_path
  end

end