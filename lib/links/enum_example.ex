defmodule Examples.Enum do
  def not_scary do
    Enum.map(
      [1, 2, 3],
      fn number -> IO.inspect(number) end
    )
  end
end
