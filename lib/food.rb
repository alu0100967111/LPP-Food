require "food/version"

module FoodGem

  class Food
      
    attr_reader :name, :protein_quantity, :glucid_quantity, :lipid_quantity  
      
    def initialize (name, protein_energy_pair, glucid_energy_pair, lipid_energy_pair)
      raise unless name.is_a? String
      raise unless ((protein_energy_pair.is_a? Array) && (glucid_energy_pair.is_a? Array) && (lipid_energy_pair.is_a? Array))
      raise unless ((protein_energy_pair.count == 2) && (glucid_energy_pair.count == 2) && (lipid_energy_pair.count == 2))

      protein_energy_pair.each { |element| raise unless element.is_a?(Integer) || element.is_a?(Float) }
      glucid_energy_pair.each { |element| raise unless element.is_a?(Integer) || element.is_a?(Float) }
      lipid_energy_pair.each { |element| raise unless element.is_a?(Integer) || element.is_a?(Float) }
      
      @name = name
      @protein_quantity = protein_energy_pair[0]
      @glucid_quantity = glucid_energy_pair[0]
      @lipid_quantity = lipid_energy_pair[0]
    end
      
  end
  
end
