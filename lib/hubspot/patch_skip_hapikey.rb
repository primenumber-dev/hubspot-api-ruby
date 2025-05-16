# HubSpot API 9.5.1 Monkey-Patch : skip blank hapikey on OAuth
module Hubspot
  module Crm
    module Schemas
      class ApiClient # :nodoc:
        alias _orig_update_params_for_auth! update_params_for_auth!

        def update_params_for_auth!(header_params, query_params, auth_names)
          # hapikey が空なら除外
          auth_names = Array(auth_names).reject do |name|
            name == 'hapikey' && @config.api_key['hapikey'].to_s.strip.empty?
          end

          _orig_update_params_for_auth!(header_params, query_params, auth_names)
        end
      end
    end
  end
end
