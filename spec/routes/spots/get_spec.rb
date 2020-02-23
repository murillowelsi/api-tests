describe "GET /spots/:id" do
  before(:all) do
    result = SpotApi.new.session({ email: "dunha2@gmail.com" })
    @user_id = result.parsed_response["_id"]
  end
  
  describe "when get unique spot" do
    before(:all) do
      spot = ({ thumbnail: "contoso.jpg", company: "Contoso", techs: ["java", "elixir"], price: 120, user: @user_id.to_mongo_id })

      @spot_id = MongoDb.new.save_spot(spot)
      @result = SpotApi.new.find_spot(@user_id, @spot_id)
    end

    it "should return 200" do
      expect(@result.response.code).to eql "200"
    end

    it "should contain company" do
      expect(@result.parsed_response).to include("company" => "Contoso")
    end

    it "should contain techs" do
      expect(@result.parsed_response).to include("techs" => ["java", "elixir"])
    end

    it "should contain price" do
      expect(@result.parsed_response).to include("price" => 120)
    end

    it "should contain thumbnail url" do
      expect(@result.parsed_response["thumbnail"]).to end_with "contoso.jpg"
    end
  end

  describe "when spot does not exists" do
    before(:all) do
      @mongo_id = MongoDb.new.mongo_id
      @result = SpotApi.new.find_spot(@user_id, @mongo_id)
    end

    it "should return 404" do
      expect(@result.response.code).to eql "404"
    end

    it "should be empty" do
      expect(@result.parsed_response).to be_empty
    end
  end
end
