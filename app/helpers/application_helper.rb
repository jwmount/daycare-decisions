module ApplicationHelper


def nappies_provided
  [
    'disposable',
    'cotton',
    'none'
  ]
end


  # see if this is unused in R365 as well?
  def Xaddress
    @address = Address.where("addressable_id = ? AND addressable_type = ?", self.id, 'Company').limit(1)
    unless @address.blank?
      address = "#{@address[0].street},  #{@address[0].suburb} #{@address[0].state} #{@address[0].post_code} "
    else
      'Empty'
    end
  end


end #module
