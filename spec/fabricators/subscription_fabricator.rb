Fabricator(:subscription) do
  channels ['']
  user     { Fabricate(:user) }
end
