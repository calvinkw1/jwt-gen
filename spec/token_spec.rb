require './app/token'

describe Token do

  before do
    @token = Token.new
  end

  context "Testing token generation" do

    it "Should set HS256 as default algorithm" do
      expect(@token.set_alg).to eq('HS256')
    end

    it "Should get a user id" do
      expect(@token).to receive(:gets).once {"user1234"}
      expect(@token.get_user_id).to eq("user1234")
    end

    it "Should get a valid email address" do
      expect(@token).to receive(:gets).once {"example@google.com"}
      expect(@token.get_email).to match(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
    end

    it "Should prompt for email again on bad email format" do
      expect(@token).to receive(:gets).once {"asdfasdf"}
      expect(@token).to receive(:gets).once {"example@google.com"}
      expect(@token.get_email).to match(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
    end

    it "Should not set additional claims" do
      additional_claims = {}
      expect(@token).to receive(:gets).once {"n"}
      expect(@token.set_additional_claims(additional_claims)).to eq({})
    end

    it "Should set additional claims" do
      additional_claims = {}
      expect(@token).to receive(:gets).once {"y"}
      expect(@token).to receive(:gets).once {"foo"}
      expect(@token).to receive(:gets).once {"bar"}
      expect(@token).to receive(:gets).once {"n"}
      expect(@token.set_additional_claims(additional_claims)).to eq({foo: 'bar'})
    end

    it "Should check for exp as an integer" do
      expect(@token).to receive(:gets).once {"1"}
      expect(@token.get_exp).to be_a(Integer)
    end

    it "Should set a secret" do
      expect(@token).to receive(:gets).once {"my$3cr3tk3y"}
      expect(@token.set_secret).to eq("my$3cr3tk3y")
    end

    it "Should set payload" do
      user_id = 'user1234'
      email = 'example@google.com'
      exp = Time.now.to_i + ("1".to_i * 3600)
      additional_claims = {foo: "bar"}
      
      expect(@token.set_payload_claims user_id, email, exp, additional_claims).to eq({
        user_id: user_id,
        email: email,
        exp: exp,
        foo: "bar"
      })
    end

    it "Should encode token and return JWT" do
      alg = "HS256"
      payload = {
        user_id: "user1234",
        email: "example@google.com",
        exp: Time.now.to_i + ("1".to_i * 3600),
        foo: "bar"
      }
      secret = "my$3cr3tk3y"
      expect(@token.encode_token(payload, secret, alg)).to be_truthy
    end

  end

  context "Testing methods after JWT token generated" do

    before do
      alg = "HS256"
      payload = {
        user_id: "user1234",
        email: "example@google.com",
        exp: Time.now.to_i + ("1".to_i * 3600),
        foo: "bar"
      }
      secret = "my$3cr3tk3y"
      @jwt = @token.encode_token(payload, secret, alg)
    end

    it "Should be able to be split into 3 parts" do
      expect(@jwt.split('.').length).to eq(3)
    end

    it "Should copy JWT to pastboard" do
      @token.token_pbcopy(@jwt)
      expect(IO.popen('pbpaste', 'r').read).to be_truthy
    end

  end

end

