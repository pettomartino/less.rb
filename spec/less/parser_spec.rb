require 'spec_helper'

describe Less::Parser do

  cwd = Pathname(__FILE__).dirname

  describe "simple usage" do
    it "parse less into a tree" do
      root = subject.parse(".class {width: 1+1}")
      root.to_css.gsub(/\n/,'').should eql ".class {  width: 2;}"
    end
  end
  it "throws a ParseError if the lesscss is bogus" do
    expect {subject.parse('{^)')}.should raise_error(Less::ParseError)
  end

  describe "when configured with mulitple load paths" do
    before {@parser = Less::Parser.new :paths => [cwd.join('one'), cwd.join('two')]}

    it "will load files from both paths" do
      @parser.parse('@import "one.less";').to_css.gsub(/\n/,'').strip.should eql ".one {  width: 1;}"
      @parser.parse('@import "two.less";').to_css.gsub(/\n/,'').strip.should eql ".two {  width: 1;}"
    end
  end

end