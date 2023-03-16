shared_examples 'an admin-authorized endpoint' do
  let(:user) { create(:user) }
  let(:headers) { auth_headers }

  include_examples 'have http status with error',
                   :unauthorized,
                   I18n.t('admin.not_an_admin')
end
