require 'spec_helper'

describe Spark do
  describe "with one number" do
    it "should render one bar" do
      expect(Spark::Grapher.render('10')).to eq('▁')
    end
  end

  describe "with the same number twice" do
    it "should render two bars" do
      expect(Spark::Grapher.render('2,2')).to eq('▁▁')
    end
  end

  describe "with one number followed by a bigger one" do
    it "should render bars in ascending order" do
      expect(Spark::Grapher.render('1,10')).to eq('▁█')
    end
  end

  describe "with one number followed by a smaller one" do
    it "should render bars in descending order" do
      expect(Spark::Grapher.render('10,1')).to eq('█▁')
    end
  end

  describe "with more numbers than available ticks" do
    it "should render bars" do
      expect(Spark::Grapher.render('1,2,3,4,5,6,7,8,9,10')).to eq('▁▁▂▃▄▄▅▆▇█')
    end
  end

  describe "with small-big-small" do
    it "should render smallest-biggest-smallest" do
      expect(Spark::Grapher.render('1,200,1')).to eq('▁█▁')
    end
  end

  describe "with spaces in the sequence" do
    it "should ignore spaces and render based on the numbers" do
      expect(Spark::Grapher.render('   1,   2,   1')).to eq('▁█▁')
    end
  end

  describe "with space separated numbers" do
    it "should render the graph for the numbers being passed" do
      expect(Spark::Grapher.render('1       2    1')).to eq('▁█▁')
      expect(Spark::Grapher.render('1    2000    1')).to eq('▁█▁')
      expect(Spark::Grapher.render('1999 2000 1999')).to eq('▁█▁')
    end
  end

  describe "with only zeroes" do
    it "should flatline" do
      expect(Spark::Grapher.render('0,0,0,0,0,0')).to eq('▁▁▁▁▁▁')
    end
  end

  describe "with various series" do
    it "should render relevant graphs" do
      expect(Spark::Grapher.render('1,1,1,1,1,1,2')).to eq('▁▁▁▁▁▁█')
      expect(Spark::Grapher.render('2,1,1,1,1,1,1')).to eq('█▁▁▁▁▁▁')
      expect(Spark::Grapher.render('1,0,0,0,0,0,1')).to eq('█▁▁▁▁▁█')
    end
  end
end