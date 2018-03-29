class Ability
  include CanCan::Ability

  def initialize(user)
    
    if user.free_user?

    end

    if user.premium_user?
    end

    if user.mod?
    end

    if user.admin?
    end

  end

end
