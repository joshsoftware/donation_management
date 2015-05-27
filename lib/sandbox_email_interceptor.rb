class SandboxEmailInterceptor
  def self.delivering_email(message)
    message.to = ['shweta@joshsoftware.com']
  end
end
