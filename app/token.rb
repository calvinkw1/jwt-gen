require 'jwt'


class Token

  def set_alg
    puts "Initializing token type JWT with HS256 algorithm.."
    'HS256'
  end

  def set_payload_claims user_id, email, exp, additional_claims
    payload = {
      user_id: user_id,
      email: email,
      exp: exp
    }

    if additional_claims
      payload.merge(additional_claims)
    else
      payload
    end
  end

  def get_user_id
    puts "Input issuer user ID.."
    gets.chomp
  end

  def get_email
    puts "Input issuer email.."
    email = gets.chomp
    if (/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i).match(email) == nil
      puts "Please enter a valid email address!"
      get_email
    else
      email
    end
  end

  def get_exp
    puts "Input expiration(exp) time in hours (1/2/3/4/etc).."
    hours = gets.chomp
    if hours.to_i != 0
      Time.now.to_i + (hours.to_i * 3600)
    else
      puts "Expiration time must be a number representing hours!"
      get_exp
    end
  end

  def set_additional_claims additional_claims
    puts "Any additional claims? (y/n)"
    y_or_n = gets.chomp.downcase
    
    if y_or_n == 'y'
      puts "Please enter key name"
      key = gets.chomp
      puts "Please enter value"
      val = gets.chomp
      additional_claims[:"#{key}"] = val
      set_additional_claims additional_claims
    elsif y_or_n == 'n'
      additional_claims
    end
  end

  def set_secret
    puts "Input secret.."
    gets.chomp
  end

  def encode_token payload, secret, alg
    JWT.encode payload, secret, alg
  end

  def token_pbcopy token
    IO.popen('pbcopy', 'w') {|io| io << token}
    puts "JWT successfully copied to clipboard!"
  end


end