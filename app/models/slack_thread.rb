# frozen_string_literal: true

class SlackThread < ApplicationRecord
  validates_presence_of :thread_ts
end
