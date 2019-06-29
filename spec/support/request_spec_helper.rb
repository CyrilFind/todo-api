module RequestSpecHelper
  
  def json_response
    JSON.parse(response.body, symbolize_names: true)
  end

  def login(user)
    post new_user_session_path, params: { email: user.email, password: user.password }
  end

  # The authentication header looks something like this:
  # {"access-token"=>"abcd1dMVlvW2BT67xIAS_A", "token-type"=>"Bearer", "client"=>"LSJEVZ7Pq6DX5LXvOWMq1w", "expiry"=>"1519086891", "uid"=>"darnell@konopelski.info"}
  def get_auth_params(login_response)
    {
      'access-token': login_response.headers['access-token'],
      client: login_response.headers['client'],
      uid: login_response.headers['uid'],
      # expiry: login_response.headers['expiry'],
      # token_type: login_response.headers['token-type']
    }
  end

  def headers_from_login(user)
    login(user)
    get_auth_params(response)
  end
end
