class ReceiptMailerPreview < ActionMailer::Preview
  def receipt_email_preview
    ReceiptMailer.receipt_email(Order.last)
  end
end
