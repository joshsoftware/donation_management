module UsersHelper
  def can_edit(role)
    if role == "Super Admin" || role == "Admin"
      false
    else
      true
    end
  end

end
