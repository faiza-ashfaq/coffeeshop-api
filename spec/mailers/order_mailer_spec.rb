require 'rails_helper'

RSpec.describe OrderMailer, type: :mailer do
  describe 'order_completed' do
    let(:user) { create(:user) }
    let(:order) { create(:order) }
    let(:mail) { described_class.order_completed(user, order) }

    it 'renders the subject' do
      expect(mail.subject).to eq(I18n.t('emails.notify_order_complete_email', { id: order.hashid }))
    end

    it 'sends mail to user' do
      expect(mail.to).to eq([user.email])
    end
  end
end
