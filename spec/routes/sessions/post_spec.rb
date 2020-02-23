describe "POST /sessions" do
  context "when send email", :smoke do
    before(:all) do
      @result = SpotApi.new.session({email: "murillo.welsi@gmail.com"})
    end

    it "should return 200" do
      expect(@result.response.code).to eql "200"
    end

    it "should return session ID" do
      expect(@result.parsed_response["_id"].length).to eql 24
    end

    it "should return ID" do
      expect(@result.parsed_response["_id"]).to eql "5e510ac32a40bd0017a67e71"
    end

    it "should return user email" do
      expect(@result.parsed_response["email"]).to eql "murillo.welsi@gmail.com"
    end
  end

  context "when send wrong email" do
    before(:all) do
        api = SpotApi.new
        @result = api.session({email: "murillo.welsi$gmail.com"})
    end

    it "should return 409" do
      expect(@result.response.code).to eql "409"
    end

    it "should return wrong email" do
      expect(@result.parsed_response["error"]).to eql "wrong email"
    end
  end

  context "when send wrong email" do
    before(:all) do
        api = SpotApi.new
        @result = api.session({email: ""})
    end

    it "should return 412" do
      expect(@result.response.code).to eql "412"
    end

    it "should return wrong email" do
      expect(@result.parsed_response["error"]).to eql "required email"
    end
  end

  context "when send without data" do
    before(:all) do
        api = SpotApi.new
        @result = api.session({})
    end

    it "should return 412" do
      expect(@result.response.code).to eql "412"
    end

    it "should return required email" do
      expect(@result.parsed_response["error"]).to eql "required email"
    end
  end
end
