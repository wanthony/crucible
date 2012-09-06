module Crucible
  module ReviewClient
    def filter(options = {})
      get('/reviews-v1/filter', options)
    end
  end
end
