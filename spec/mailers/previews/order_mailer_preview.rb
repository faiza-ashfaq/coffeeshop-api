# Preview all emails at http://localhost:3000/rails/mailers/order

require 'factory_bot_rails'

class OrderMailerPreview < ActionMailer::Preview
  include FactoryBot::Syntax::Methods

  def order_completed
    # TODO-r: this is not working,
    user = create(:user)
    order = create(:order, user: user)
    OrderMailer.with(user: user,
                     order: order)
               .order_completed(user, order)
  end
end
