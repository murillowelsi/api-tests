require "httparty"

class SpotApi
  include(HTTParty)
  base_uri "https://spotlab-api.herokuapp.com"

  def session(payload)
    return result = self.class.post(
             "/sessions",
             body: payload.to_json,
             headers: { "content-type": "application/json" },
           )
  end

  def dash(user_id)
    return self.class.get(
             "/dashboard",
             headers: { "user_id" => user_id },
           )
  end

  def find_spot(user_id, spot_id)
    return self.class.get(
             "/spots/" + spot_id,
             headers: { "user_id" => user_id },
           )
  end

  def remove_spot(user_id, spot_id)
    return self.class.delete(
             "/spots/" + spot_id,
             headers: { "user_id" => user_id },
           )
  end

  def save_spot(payload, user_id)
    return self.class.post(
             "/spots",
             body: payload,
             headers: { "user_id" => user_id },
           )
  end
end
