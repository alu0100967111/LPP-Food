require "food/version"

module FoodGem
    
  PROTEIN_ENERGY = 4
  GLUCID_ENERGY = 4
  LIPID_ENERGY = 9

  class FoodAbstract
      
    attr_reader :name, :protein_quantity, :glucid_quantity, :lipid_quantity, :energetic_content
      
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
      
      # Vector de pares, pues hash no permite iguales
      @pair_macronutrient_energy = []
      @pair_macronutrient_energy.push([protein_energy_pair[0], protein_energy_pair[1]])
      @pair_macronutrient_energy.push([glucid_energy_pair[0], glucid_energy_pair[1]])
      @pair_macronutrient_energy.push([lipid_energy_pair[0], lipid_energy_pair[1]])
      
      @energetic_content = calculate_energetic_content
    end
    
    def calculate_energetic_content
        energetic_content = 0
        @pair_macronutrient_energy.each{ |macronutrient, energy| energetic_content += (macronutrient * energy) }
        return energetic_content
    end
    
    def to_s
        "Nombre: #{@name} | Proteínas: #{@protein_quantity} gramos | Glúcidos: #{@glucid_quantity} gramos | Lípidos: #{@lipid_quantity} gramos | " \
        "Contenido Energético: #{@energetic_content} Kcal. |"
    end
  end
  
  class Food < FoodAbstract
    
    attr_reader :group_name
    
    def initialize(name, protein_energy_pair, glucid_energy_pair, lipid_energy_pair, group_name)
      @group_name = group_name
      super(name, protein_energy_pair, glucid_energy_pair, lipid_energy_pair)
    end
    
    def to_s
      "Grupo: #{@group_name} | " + super
    end
    
    # def <=> (food)
    #   raise unless food
    #   return self.energetic_content <=> food.energetic_content
    # end
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
      
      data_line = data_line[3..-1] 
      
      group_name = ""
      while (!data_line[0].nil?) # Si el nombre no cambia al pasar de string afloat es que es un float
        group_name << data_line[0] << " "
        data_line = data_line[1..-1] # Quito el primer elemento
      end
      
      food_array.push(Food.new(name[0..-2], protein, glucid, lipid, group_name[0..-2])) # Quito último espacio a nombre y grupo
    }
    
    return food_array
  end
  
  
end
