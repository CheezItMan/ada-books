require "test_helper"

describe SessionsController do

  describe "auth_callback" do

    it "logs in an existing user and redirects them back to the homepage" do

      # Setup
      start_count = User.count

      user = users(:dee)


      # Action
      log_in(user, :github)

      # assert

      must_respond_with :redirect

      must_redirect_to root_path

      User.count.must_equal start_count

      session[:user_id].must_equal user.id
    end


    it "Can log in a new user" do

      user = User.new provider: 'github', name: "ada", email: 'ada@ada.com', uid: 99
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(user))

      proc {
        get auth_callback_path(:github)
      }.must_change 'User.count', 1

      user = User.find_by(provider: 'github', name: 'ada')

      session[:user_id].must_equal user.id
      must_redirect_to root_path
      must_respond_with :redirect


    end

  end






end
