class OrderMailer < ApplicationMailer
  def order_completed(user, order)
    order.completed!

    mail(to: user.email,
         subject: I18n.t('emails.notify_order_complete_email', { id: order.hashid }))
  end
end
