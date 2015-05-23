module UsersHelper
  def can_edit(role)
    if role == "Super Admin" || role == "Admin"
      true
    else
      false
    end
  end

end
