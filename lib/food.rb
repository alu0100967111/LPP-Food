require "food/version"

module FoodGem

  class Food
      
    def initialize (name, protein_energy_pair, glucid_energy_pair, lipid_energy_pair)
      raise unless name.is_a? String
      raise unless ((protein_energy_pair.is_a? Array) && (glucid_energy_pair.is_a? Array) && (lipid_energy_pair.is_a? Array))
      raise unless ((protein_energy_pair.count == 2) && (glucid_energy_pair.count == 2) && (lipid_energy_pair.count == 2))

      protein_energy_pair.each { |element| raise unless element.is_a?(Integer) || element.is_a?(Float) }
      glucid_energy_pair.each { |element| raise unless element.is_a?(Integer) || element.is_a?(Float) }
      lipid_energy_pair.each { |element| raise unless element.is_a?(Integer) || element.is_a?(Float) }
    end
      
  end
  
end
