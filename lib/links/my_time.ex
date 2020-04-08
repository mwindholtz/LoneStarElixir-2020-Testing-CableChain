defmodule MyTime do
  @seconds_in_minute 60
  @seconds_in_hour 60 * @seconds_in_minute
  @seconds_in_day 24 * @seconds_in_hour

  def utc_now do
    utc_now_fn = Application.get_env(:links, :utc_now_fn, &DateTime.utc_now/0)
    utc_now_fn.()
  end

  def now_minus(magnitude, :days) do
    seconds_in_day = magnitude * @seconds_in_day
    now_minus(seconds_in_day, :seconds)
  end

  def now_minus(magnitude, :seconds) do
    utc_now() |> minus(magnitude, :seconds)
  end

  def minus(datetime, magnitude, :days) do
    seconds_in_day = magnitude * @seconds_in_day
    minus(datetime, seconds_in_day, :seconds)
  end

  def minus(datetime, magnitude, :seconds) do
    datetime |> DateTime.add(-magnitude)
  end
end
