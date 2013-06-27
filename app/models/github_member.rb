class GithubMember

  class << self
    def all
      unless @members
        puts "load!"
        @members = JSON.parse(open("#{Rails.root}/tmp/ppb_members.json").read)
      end
      @members
    end
  end
end
