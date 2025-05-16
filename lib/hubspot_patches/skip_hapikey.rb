module Hubspot
  module SkipHapikeyPatch # :nodoc:
    def update_params_for_auth!(header, query, auth_names)
      filtered = Array(auth_names).reject do |name|
        name == 'hapikey' &&
          (@config.access_token.to_s.strip != '' ||
            @config.api_key['hapikey'].to_s.strip.empty?)
      end
      super(header, query, filtered)
    end
  end

  # CRM 配下にある全ての ApiClient に prepend
  module Crm
    constants.each do |sub|
      mod = const_get(sub)
      next unless mod.const_defined?(:ApiClient)

      mod::ApiClient.prepend SkipHapikeyPatch
    end
  end
end
