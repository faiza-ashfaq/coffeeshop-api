shared_examples 'an authenticated endpoint request' do
  let(:headers) { nil }

  include_examples 'have http status with error request',
                   :unauthorized,
                   I18n.t('devise.failure.unauthenticated')
end
