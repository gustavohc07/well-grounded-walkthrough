class Cake
  def initialize(batter)
    @batter = batter
    @baked = true
  end
end

class Egg; end

class Flour; end

class Baker
  def bake_cake
    @batter = []
    pour_flour # the only way to call this private method is if `self` is an instance of Baker. It can't be called with an explicit receiver: `self.add_egg` is not going to work.
    add_egg
    stir_batter
    return Cake.new(@batter)
  end

  private

  def pour_flour
    @batter.push(Flour.new)
  end

  def add_egg
    @batter.push(Egg.new)
  end

  def stir_batter; end
end