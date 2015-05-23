module ApplicationHelper
  def assign_role user
    if user.role == "Super Admin"
      [['Admin','Admin'], ['Coordinator','Coordinator']]
    elsif user.role == "Admin"
      [['Coordinator','Coordinator']]
    end
  end
end
