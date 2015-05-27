if Rails.env.development?
  ActionMailer::Base.register_interceptor(SandboxEmailInterceptor)
end
