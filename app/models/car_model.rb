class CarModel < ApplicationRecord

  enum :fuel_type, {gasoline: 1, diesel: 3, electric: 5, ethanol: 7, flex: 9}
  enum :transmission, {manual: 1, automatic: 3, continuously_variable: 5}
end
