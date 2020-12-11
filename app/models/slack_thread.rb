# frozen_string_literal: true

class SlackThread < ApplicationRecord
  validates :thread_ts, presence: true
end
