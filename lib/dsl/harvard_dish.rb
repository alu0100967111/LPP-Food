# CLASS FOR HARVARDISHES
INGREDIENT_DATABASE_FILENAME = "input/food-data.txt"
INGREDIENT_DATABASE_GRAMS = 100

# INGREDIENT WEIGHT 10G
PIECE_QUANTITY = 100
SMALL_PIECE_QUANTITY = PIECE_QUANTITY * 0.5
MUG_QUANTITY = 240
SMALL_MUG_QUANTITY = MUG_QUANTITY * 0.5
SPOON_QUANTITY = 150
SMALL_SPOON_QUANTITY = SPOON_QUANTITY * 0.5

class HarvardDishDSL
  
  attr_reader :dish_title, :ingredient_quantity_array
  
  @@ingredient_database = read_ingredient_database(INGREDIENT_DATABASE_FILENAME)
  
  def initialize(dish_title, &block)
    @dish_title = dish_title
    @ingredient_quantity_array = [] # Arrays of pairs ingredient name and quantity
    @number_of_people = 0
    
    if block_given?
      if block.arity == 1
        yield self
      else
        instance_eval(&block)
      end
    end
    
  end
  
  def to_s
    rows = []
    total_energetic_content = 0
    
    @ingredient_quantity_array.each { |ingredient_name, ingredient_quantity|
      @food = @@ingredient_database[ingredient_name] * ingredient_quantity
      rows << [@food.name, ingredient_quantity*10, @food.glucid_quantity, @food.protein_quantity, @food.lipid_quantity, @food.energetic_content]
      total_energetic_content += @food.energetic_content
    }
    
    rows << ['Valor Energético Total', '', '', '', '', total_energetic_content]
    
    # Gema para tabla usada -> https://github.com/tj/terminal-table
    return Terminal::Table.new(:title => @dish_title, 
                               :headings => [' ', 'Gramos', 'Glúcidos', 'Proteínas', 'Lípidos', 'Valor Energético'], 
                               :rows => rows)
  end
  
  def vegetal (ingredient_name, options = {})
    ingredient_quantity = analyze_options(options)
    @ingredient_quantity_array.push([ingredient_name, ingredient_quantity])
  end
  
  def fruta (ingredient_name, options = {})
    ingredient_quantity = analyze_options(options)
    @ingredient_quantity_array.push([ingredient_name, ingredient_quantity])
  end
  
  def cereal (ingredient_name, options = {})
    ingredient_quantity = analyze_options(options)
    @ingredient_quantity_array.push([ingredient_name, ingredient_quantity])
  end
  
  def proteina (ingredient_name, options = {})
    ingredient_quantity = analyze_options(options)
    @ingredient_quantity_array.push([ingredient_name, ingredient_quantity])
  end
  
  def aceite (ingredient_name, options = {})
    ingredient_quantity = analyze_options(options)
    @ingredient_quantity_array.push([ingredient_name, ingredient_quantity])
  end
  
  def personas (number_of_people)
    @number_of_people = number_of_people
  end
  
  private
  
  def analyze_options(options)
    quantity = 0
    options.each { |option_name, option_value|
      case option_name
        when :porcion
          quantity = transform_to_grams(option_value)
        else :gramos
          quantity = option_value/10
      end
    }
    return quantity
  end
  
  # pieza, pieza pequeña, taza, taza pequeña, cucharon, cucharada
  def transform_to_grams(portion)
    quantity = 0
    
    if (portion =~ /piez/)
      if (portion =~ /pequeña/)
        quantity = SMALL_PIECE_QUANTITY
      else
        quantity = PIECE_QUANTITY
      end
    elsif (portion =~ /taz/)
      if (portion =~ /pequeña/)
        quantity = SMALL_MUG_QUANTITY
      else
        quantity = MUG_QUANTITY
      end
    elsif (portion =~ /cucharon/)
      quantity = SPOON_QUANTITY
    elsif (portion =~ /cuchar/)
      quantity = SMALL_SPOON_QUANTITY
    end
    
    fixed_quantity = (quantity * portion.to_r).to_f / INGREDIENT_DATABASE_GRAMS
          
    return fixed_quantity
  end
  
end