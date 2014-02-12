module ApplicationHelper
# Care Categories
def care_categories
 [
  'Long Day Care',
  'Occasional Care',
  'Family Day Care',
  'In Home Care',
  'Before and After School Care',
  'Vacation Care',
  # current child care enquiry may find they need to provide a rebate to nannies and aupairs, 
  # we need to scope the flexibility in the major build to include this)
  'Future scope- nannies, babysitters, aupairs, ...'
  ]
  end

def languages
  [ 
    'Arabic',
    'Cantonese',
    'French',
    'German',
    'Hebrew',
    'Italian',
    'Mandarin',
    'Spanish',
    'Other'
  ]
end

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
