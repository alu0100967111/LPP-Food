# Constants of energy
# @param PROTEIN_ENERGY [int] protein energy.
# @param GLUCID_ENERGY [int] glucid energy.
# @param LIPID_ENERGY [int] lipid energy
PROTEIN_ENERGY = 4
GLUCID_ENERGY = 4
LIPID_ENERGY = 9

# Abstract class for Food
class FoodAbstract
  
  # @attr_reader name [String] name the name of the food
  # @attr_reader protein_quantity [pair] pair of protein number and energy
  # @attr_reader glucid_quantity [pair] pair of glucid number and energy
  # @attr_reader lipid_quantity [pair] pair of lipid number and energy
  # @attr_reader energetic_content [double] energetic content of the food
  attr_reader :name, :protein_quantity, :glucid_quantity, :lipid_quantity, :energetic_content, :glucemic_
  
  # Constructor of Abstract Food for allowing the childs to call it.
  # @param name [String] the name for the food.
  # @param protein_energy_pair [pair] pair of protein number and energy.
  # @param glucid_energy_pair [pair] pair of glucid number and energy
  # @param lipid_energy_pair [pair] pair of lipid number and energy
  # @param lipid_energy_pair [pair] pair of lipid number and energy
  def initialize (name, protein_energy_pair, glucid_energy_pair, lipid_energy_pair)
    raise unless name.is_a? String
    raise unless ((protein_energy_pair.is_a? Array) && (glucid_energy_pair.is_a? Array) && (lipid_energy_pair.is_a? Array))
    raise unless ((protein_energy_pair.count == 2) && (glucid_energy_pair.count == 2) && (lipid_energy_pair.count == 2))

    protein_energy_pair.each { |element| raise unless element.is_a?(Integer) || element.is_a?(Float) }
    glucid_energy_pair.each { |element| raise unless element.is_a?(Integer) || element.is_a?(Float) }
    lipid_energy_pair.each { |element| raise unless element.is_a?(Integer) || element.is_a?(Float) }
    
    @name = name.capitalize
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
  
  # Calculates the energetic content for the food
  # @return [double] energetic_content
  def calculate_energetic_content
      energetic_content = 0
      @pair_macronutrient_energy.each{ |macronutrient, energy| energetic_content += (macronutrient * energy) }
      return energetic_content
  end
  
  # Return string with the output for the food
  # @return [String] outpout of food
  def to_s
      "Nombre: #{@name} | Proteínas: #{@protein_quantity} gramos | Glúcidos: #{@glucid_quantity} gramos | Lípidos: #{@lipid_quantity} gramos | " \
      "Contenido Energético: #{@energetic_content} Kcal."
  end
  
end

# Class for Food that inherit FoodAbstract
class Food < FoodAbstract

  # Including Comparable Module
  include Comparable
  
  # @attr_reader group_name [String] name the name of the food group
  attr_reader :group_name
  
  # Constructor of Food with the group name
  # @param name [String] the name for the food.
  # @param protein_energy_pair [pair] pair of protein number and energy.
  # @param glucid_energy_pair [pair] pair of glucid number and energy
  # @param lipid_energy_pair [pair] pair of lipid number and energy
  # @param group_name [String] the name for the food group.
  def initialize(name, protein_energy_pair, glucid_energy_pair, lipid_energy_pair, group_name, gluc_sample_pair_array = [])
    @group_name = group_name
    super(name, protein_energy_pair, glucid_energy_pair, lipid_energy_pair)
    
    @aibc_food_array = [] # The AIBC of this food for each person
    @aibc_glucose_array = [] # The AIBC of glucose for each person
    @ig_array = [] # The IG of this food for each person
    
    gluc_sample_pair_array.each { |person_array|
      @aibc_food_array.push(calculate_aibc(person_array[0])) # First is the samples of this food for a person
      @aibc_glucose_array.push(calculate_aibc(person_array[1])) # First is the samples of glucose for a person
      @ig_array.push(calculate_ig_for_person(@aibc_food_array.size))
    }
  end
  
  private
  
  def calculate_aibc(sample_array)
    (1...sample_array.size).map{|i| ((sample_array[i] + sample_array[i-1] - 2*sample_array[0]) / 2) * 5}.reduce(:+)
  end
  
  def calculate_ig_for_person(person_number)
    return ((@aibc_food_array[person_number-1] / @aibc_glucose_array[person_number-1]) * 100)
  end
  
  public
  
  def get_aibc_of_person(person_number)
    return @aibc_food_array[person_number-1]
  end
  
  def get_ig_of_person(person_number)
    return @ig_array[person_number-1]
  end
  
  def get_ig
    return (@ig_array.reduce(:+) / @ig_array.size)
  end
  
  # Return string with the output for the food calling the father
  # @return [String] output of food
  def to_s
    "Grupo: #{@group_name} | " + super
  end
  
  # Essential comparating for using Comparable Module
  # @return [String] Return which food is higher depending on the enrgetic content
  def <=> (food)
    raise unless food.is_a?Food
    return self.energetic_content <=> food.energetic_content
  end

end