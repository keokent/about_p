class GithubMember

  class << self
    def all
      JSON.parse(open("#{Rails.root}/tmp/ppb_members.json").read)
    end

    def paperboy?(nickname)
      self.all.has_key? nickname
    end
  end

end
