module ControllerMacros
  def login(user)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end
end

# まず、/spec/supportディレクトリに、controller_macros.rbを作成しloginメソッドを定義