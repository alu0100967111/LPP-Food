require "food/version"

module FoodGem
    
  PROTEIN_ENERGY = 4
  GLUCID_ENERGY = 4
  LIPID_ENERGY = 9

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
  
  def read_data (data_filename)
    data_string = File.open(data_filename).read.split("\n") # Divido el fichero en string de lineas
    food_array = []
    
    data_string.each { |data_line|
      data_line = data_line.split(" ") # La divido en espacios
      name = ""
      
      while (data_line[0] != data_line[0].to_f.to_s) # Si el nombre no cambia al pasar de string afloat es que es un float
        name << data_line[0] << " "
        data_line = data_line[1..-1] # Quito el primer elemento
      end
      
      protein = [data_line[0].to_f, PROTEIN_ENERGY]
      glucid = [data_line[1].to_f, GLUCID_ENERGY]
      lipid = [data_line[2].to_f, LIPID_ENERGY]
      
      food_array.push(Food.new(name[0..-2], protein, glucid, lipid)) #Quito último espacio a nombre
    }
    
    return food_array
  end
  
end
