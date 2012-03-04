# put it in config/initializers and use in project
class Time

  def civil
    self.strftime("%d %b %Y at %I:%M %P")
  end

  def civil_date
    self.strftime("%d %b %Y")
  end

  def civil_time
    self.strftime("%I:%M %P")
  end

  def am_date
    self.strftime("%m/%d/%Y")
  end

  def eur_date
    self.strftime("%d/%m/%Y")
  end
end
