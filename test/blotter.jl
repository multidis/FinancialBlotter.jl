facts("constructors") do
  context("inner constructor from TimeArray and Ticker") do
    ta = TimeArray([DateTime(1795,10,31)], [0.0 0.0],
                   FinancialBlotter.blottercolnames)
    @fact_throws FinancialBlotter.Blotter(ta, "string-not-Ticker-type")
    tk = "BESTBULL"
    fb = FinancialBlotter.Blotter(ta, FinancialSeries.Ticker(tk))
    @fact fb.ticker.id => tk
  end
  context("empty constructor") do
    fb0 = FinancialBlotter.Blotter()
    @fact isa(timestamp(fb0.series)[1], DateTime) => true
  end
  context("from TimeArray components and Ticker") do
    @fact_throws FinancialBlotter.Blotter(
      [DateTime(2015,1,1)], [0.0 0.0], ["only 1 col. name"],
      FinancialBlotter.blotterticker)
    @fact_throws FinancialBlotter.Blotter(
      [DateTime(2015,1,1)], [0.0], ["only 1D Array"],
      FinancialBlotter.blotterticker)
    fb = FinancialBlotter.Blotter(
      [DateTime(2015,1,1)], [0.0 0.0],
      FinancialBlotter.blottercolnames, FinancialBlotter.blotterticker)
    @fact colnames(fb.series) => FinancialBlotter.blottercolnames
  end



  ###

  context("inner constructor enforces constraints") do
      @fact 1 => roughly(1.0000000001)
  end

  context("empty constructor") do
      @fact 1 => roughly(1.0000000001)
  end

  context("add entry to existing Blotter object") do
    @fact 1.0000000000000001 => roughly(1)
  end

  context("constructed from orderbook") do
    @fact 1.0000000000000001 => roughly(1)
  end

  context("constructed from signal and FinancialTimeSeries") do
    @fact 1.0000000000000001 => roughly(1)
  end

  context("fillblotter") do
    @fact 1.0000000000000001 => roughly(1)
  end

  ### TODO
  @fact 0 => 1
end



### TODO: what is this for?

# facts("base imports") do

#   context("length is correct") do
#     @fact_throws log(-1)
#     @fact_throws sum(foo, bar)
#   end

#   context("getindex from single Int") do
#     @fact_throws log(-1)
#   end

#   context("getindex from Int array") do
#     @fact_throws log(-1)
#   end

#   context("getindex from colname") do
#     @fact_throws log(-1)
#   end

#   context("getindex from single date") do
#     @fact_throws log(-1)
#   end

#   context("getindex from date array") do
#     @fact_throws log(-1)
#   end

#   context("getindex from date range") do
#     @fact_throws log(-1)
#   end
# end
