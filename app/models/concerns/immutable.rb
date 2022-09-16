module Immutable
    extend ActiveSupport::Concern

    def readonly?
        return true unless ENV['seeding']
        super
    end
end