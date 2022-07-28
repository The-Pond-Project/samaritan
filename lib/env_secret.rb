class EnvSecret
  class << self
    def get(variable_name)
      ENV[variable_name]
    end
  end
end
