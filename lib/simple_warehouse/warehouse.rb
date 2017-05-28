module SimpleWarehouse
  ##
  # Warehouse storage. Coordinates 0, 0 are top left
  #  0 1 2 ..
  #  1
  #  2
  #  .
  #  .
  #
  #  The position 0,0 is valid
  class Warehouse
    def initialize(width, height)
      @width = width
      @height = height
      @crates = []
    end

    def can_store?(position, crate)
      # Doesn't go outbounds
      # Doesn't overlap  
    end
  end

  class Position
    attr_reader :x, :y

    def initialize(x, y)
      @x = x
      @y = y
    end
  end

  class Crate
    attr_reader :width, :height, :product

    def initialize(width, height, product)
      @width = width
      @height = height
      @product = product
    end
  end

  class StoredCrate

    def initialize(position, crate)
      @position = position
      @crate = crate
    end

    def overlaps?(other)
      if self.max_x < other.min_x then 
        false
      elsif self.min_x > other.max_x then
        false
      elsif self.max_y < other.min_y then
        false
      elsif self.min_y > other.max_y then
        false
      else
        true
      end
    end

    protected

    def min_x
      @position.x
    end

    def max_x
      min_x + @crate.width - 1
    end

    def min_y
      @position.y
    end

    def max_y
      min_y + @crate.height - 1
    end
  end
end
