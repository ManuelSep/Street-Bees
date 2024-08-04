class Rack::Attack
  # Throttle requests to fetch comics (index action)
  throttle('req/comics_index', limit: 100, period: 1.hour) do |req|
    req.ip if req.path == '/comics' && req.get?
  end

  # Throttle requests to search comics by character
  throttle('req/comics_search', limit: 100, period: 1.hour) do |req|
    req.ip if req.path == '/comics' && req.get? && req.params['character_name'].present?
  end
end

Rack::Attack.enabled = !Rails.env.test?
