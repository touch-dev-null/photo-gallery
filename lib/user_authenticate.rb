module AuthUser
  require 'digest'

  def self.valid_password?(submitted_password)
    password == encrypt(submitted_password)
  end

  private

  def self.encrypt_password
    self.salt = make_salt unless valid_password?(password)
    self.password = encrypt(password)
  end

  def self.encrypt(string)
    secure_hash("#{salt}--#{string}")
  end

  def self.make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end

  def self.secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end

end