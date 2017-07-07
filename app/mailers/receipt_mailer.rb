class ReceiptMailer < ActionMailer::Base
  default from: "receipt@jungleexample.com"

  def receipt_email(order)
    @order = order
    mail = mail(to: @order.email, subject: "Order \##{@order.id}")
  end
end
