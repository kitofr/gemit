class String
  def classify
    self.gsub /^(\w)/ do |w| w.upcase end
  end
end
