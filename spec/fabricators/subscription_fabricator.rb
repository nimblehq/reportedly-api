# frozen_string_literal: true

Fabricator(:subscription) do
  channels ['']
  user     { Fabricate(:user) }
end
