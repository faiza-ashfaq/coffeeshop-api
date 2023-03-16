json.partial! 'api/v1/users/user', user: @resource
json.must_change_password @resource.must_change_password
