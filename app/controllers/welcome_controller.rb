class WelcomeController < ApplicationController
  def index
    @upcoming_manual_transactions = Transaction.where("status = ? AND submit_date < ?", "manual", Date.today+31)
    @upcoming_automatic_transactions = Transaction.where("status = ? AND submit_date < ?", "automatic", Date.today+31)
    @pending_transactions = Transaction.where(status: "pending")

  end
end
