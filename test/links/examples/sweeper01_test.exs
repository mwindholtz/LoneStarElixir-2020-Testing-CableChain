defmodule Examples.Sweeper01Test do
  use Links.DataCase
  alias Examples.Sweeper01

  describe "only side effects, what can we test?" do
    test "does not crash" do
      assert :ok = Sweeper01.sweep()
    end
  end
end
