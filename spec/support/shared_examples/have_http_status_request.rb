shared_examples 'have http status request' do |status, skip_request: false|
  specify '', skip_request: skip_request do
    is_expected.to have_http_status(status)
  end
end

shared_examples 'have http status with error request' do |status, error, skip_request: false|
  include_examples 'have http status request', status, skip_request: skip_request

  specify '', skip_request: skip_request do
    expect(json[:errors]).to include(error)
  end
end
